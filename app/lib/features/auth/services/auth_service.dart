import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';
import '../../chat/services/chat_websocket_service.dart';
import '../../chat/services/chat_sync_service.dart';
import '../../chat/services/rtc_signaling_service.dart';
import '../../chat/services/call_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final DefaultApi _api = ApiClient.instance.defaultApi;
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userInfoKey = 'user_info';

  // 缓存的用户信息
  Map<String, dynamic>? _cachedUserInfo;

  // 初始化：检查本地Token
  Future<bool> init() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null && token.isNotEmpty) {
      ApiClient.instance.setAuthToken(token);
      // 设置Token过期回调
      ApiClient.instance.setOnTokenExpired(_handleTokenExpired);
      // 连接 WebSocket
      ChatWebSocketService.instance.connect(token);
      // 连接 RTC 信令
      RtcSignalingService.instance.connect(token);
      CallService().init();
      // 初始化同步服务
      final userInfo = await getUserInfo();
      if (userInfo != null && userInfo['id'] != null) {
        final userId = int.tryParse(userInfo['id'].toString());
        if (userId != null) {
          ChatSyncService().init(userId);
        }
      }
      return true;
    }
    return false;
  }

  // Token过期回调（刷新失败时调用）
  Future<void> _handleTokenExpired() async {
    // 清除本地存储
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userInfoKey);
    _cachedUserInfo = null;
    // 断开WebSocket
    ChatWebSocketService.instance.disconnect();
    // 断开RTC信令
    RtcSignalingService.instance.disconnect();
    // TODO: 可以在这里发送事件通知UI跳转到登录页
  }

  // 获取当前Token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // 账号密码登录
  Future<BaseResponseLoginUserResponse> loginWithPassword(String account, String password) async {
    try {
      final response = await _api.userLogin(
        userLoginRequest: UserLoginRequest((b) => b
          ..userAccount = account
          ..userPassword = password
        ),
      );
      final data = response.data;
      if (data == null) {
        throw Exception('登录失败：服务器无响应');
      }
      // 检查业务状态码，code == 0 表示成功
      if (data.code != 0) {
        throw Exception(data.message ?? '登录失败');
      }
      await _handleLoginSuccess(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  // 手机号验证码登录
  Future<BaseResponseLoginUserResponse> loginWithPhone(String phone, String code) async {
    try {
      final response = await _api.phoneLogin(
        phoneLoginRequest: PhoneLoginRequest((b) => b
          ..phone = phone
          ..smsCode = code
        ),
      );
      final data = response.data;
      if (data == null) {
        throw Exception('登录失败：服务器无响应');
      }
      // 检查业务状态码，code == 0 表示成功
      if (data.code != 0) {
        throw Exception(data.message ?? '登录失败');
      }
      await _handleLoginSuccess(data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _handleLoginSuccess(BaseResponseLoginUserResponse responseData) async {
    if (responseData.data != null && responseData.data!.token != null) {
      final token = responseData.data!.token!;
      final refreshToken = responseData.data!.refreshToken;
      
      // 保存Token
      await _storage.write(key: _tokenKey, value: token);
      if (refreshToken != null) {
        await _storage.write(key: _refreshTokenKey, value: refreshToken);
      }
      
      ApiClient.instance.setAuthToken(token);
      // 设置Token过期回调
      ApiClient.instance.setOnTokenExpired(_handleTokenExpired);
      // 连接 WebSocket
      ChatWebSocketService.instance.connect(token);
      // 连接 RTC 信令
      RtcSignalingService.instance.connect(token);
      CallService().init();

      // 初始化同步服务
      if (responseData.data!.id != null) {
        ChatSyncService().init(responseData.data!.id!);
      }

      // 存储用户信息
      final userInfo = <String, dynamic>{
        'id': responseData.data!.id,
        'userAccount': responseData.data!.userAccount,
        'userName': responseData.data!.userName,
        'userAvatar': responseData.data!.userAvatar,
        'userProfile': responseData.data!.userProfile,
        'userRole': responseData.data!.userRole,
        'userGender': responseData.data!.userGender,
        'level': responseData.data!.level,
      };
      await _saveUserInfo(userInfo);
    }
  }

  // 保存用户信息
  Future<void> _saveUserInfo(Map<String, dynamic> userInfo) async {
    _cachedUserInfo = userInfo;
    final jsonStr = userInfo.entries
        .map((e) => '${e.key}:${e.value ?? ""}')
        .join('|');
    await _storage.write(key: _userInfoKey, value: jsonStr);
  }

  // 获取用户信息
  Future<Map<String, dynamic>?> getUserInfo() async {
    if (_cachedUserInfo != null) return _cachedUserInfo;
    
    final jsonStr = await _storage.read(key: _userInfoKey);
    if (jsonStr == null || jsonStr.isEmpty) return null;
    
    final userInfo = <String, dynamic>{};
    for (final part in jsonStr.split('|')) {
      final idx = part.indexOf(':');
      if (idx > 0) {
        final key = part.substring(0, idx);
        final value = part.substring(idx + 1);
        userInfo[key] = value.isEmpty ? null : value;
      }
    }
    _cachedUserInfo = userInfo;
    return userInfo;
  }

  // 退出登录
  Future<void> logout() async {
    // 断开 WebSocket 连接
    ChatWebSocketService.instance.disconnect();
    // 断开 RTC 信令
    RtcSignalingService.instance.disconnect();
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _userInfoKey);
    _cachedUserInfo = null;
    ApiClient.instance.clearAuthToken();
  }

  // 获取Refresh Token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // 刷新用户公开资料（通过用户ID获取最新信息）
  Future<Map<String, dynamic>?> refreshUserPublicInfo() async {
    final currentInfo = await getUserInfo();
    if (currentInfo == null || currentInfo['id'] == null) return null;
    
    try {
      final userId = int.tryParse(currentInfo['id'].toString());
      if (userId == null) return currentInfo;
      
      final response = await _api.getUserPublicInfo(id: userId);
      if (response.data?.data != null) {
        final publicInfo = response.data!.data!;
        // 更新用户信息（保留原有的 userAccount 等字段）
        final updatedInfo = <String, dynamic>{
          ...currentInfo,
          'userName': publicInfo.userName ?? currentInfo['userName'],
          'userAvatar': publicInfo.userAvatar ?? currentInfo['userAvatar'],
          'userProfile': publicInfo.userProfile ?? currentInfo['userProfile'],
          'userRole': publicInfo.role ?? currentInfo['userRole'],
          'userGender': publicInfo.userGender ?? currentInfo['userGender'],
          'level': publicInfo.level ?? currentInfo['level'],
        };
        await _saveUserInfo(updatedInfo);
        return updatedInfo;
      }
    } catch (e) {
      // 获取失败时返回缓存的信息
    }
    return currentInfo;
  }

  // 获取用户详细信息（包含更多字段如手机号、邮箱、地址等）
  Future<BaseResponseUserDetailResponse> getUserDetailInfo() async {
    final currentInfo = await getUserInfo();
    if (currentInfo == null || currentInfo['id'] == null) {
      throw Exception('用户未登录');
    }
    
    final userId = int.tryParse(currentInfo['id'].toString());
    if (userId == null) {
      throw Exception('用户ID无效');
    }
    
    try {
      final response = await _api.getUserDetailInfo(id: userId);
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  // 更新个人资料（不包含手机号）
  Future<BaseResponseBoolean> updateProfile({
    String? userName,
    String? userAvatar,
    String? userProfile,
    int? userGender,
    String? userEmail,
    String? userAddress,
    Date? birthday,
  }) async {
    try {
      final response = await _api.updateProfile(
        updateProfileRequest: UpdateProfileRequest((b) => b
          ..userName = userName
          ..userAvatar = userAvatar
          ..userProfile = userProfile
          ..userGender = userGender
          ..userEmail = userEmail
          ..userAddress = userAddress
          ..birthday = birthday
        ),
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  // 更新手机号（需要验证码）
  Future<BaseResponseBoolean> updatePhone({
    required String userPhone,
    required String phoneSmsCode,
  }) async {
    try {
      final response = await _api.updateProfile(
        updateProfileRequest: UpdateProfileRequest((b) => b
          ..userPhone = userPhone
          ..phoneSmsCode = phoneSmsCode
        ),
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  // 发送验证码
  Future<BaseResponseSendResult> sendVerifyCode(String phone) async {
    try {
      final response = await _api.sendRegisterCode(
        sendCodeRequest: SendCodeRequest((b) => b
          ..phone = phone
        ),
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  // 注册
  Future<BaseResponseLong> register({
    required String account,
    required String password,
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _api.userRegister(
        userRegisterRequest: UserRegisterRequest((b) => b
          ..userAccount = account
          ..userPassword = password
          ..checkPassword = password
          ..phone = phone
          ..smsCode = code
        ),
      );
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  // 上传头像文件
  Future<String?> uploadAvatar(File imageFile) async {
    try {
      final dio = ApiClient.instance.dio;
      final fileName = imageFile.path.split('/').last;
      
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });
      
      // 后端接口路径: /api/file/upload/{businessType}
      final response = await dio.post(
        '/api/file/upload/user/avatar',
        data: formData,
      );
      
      if (response.data != null && response.data['code'] == 0) {
        return response.data['data']?['fileUrl'];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
