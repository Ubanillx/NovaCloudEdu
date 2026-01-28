import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nova_api/nova_api.dart';
import '../../../core/network/api_client.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final DefaultApi _api = ApiClient.instance.defaultApi;
  final _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userInfoKey = 'user_info';

  // 缓存的用户信息
  Map<String, dynamic>? _cachedUserInfo;

  // 初始化：检查本地Token
  Future<bool> init() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null && token.isNotEmpty) {
      ApiClient.instance.setAuthToken(token);
      return true;
    }
    return false;
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
      if (response.data != null) {
        await _handleLoginSuccess(response.data!);
      }
      return response.data!;
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
      if (response.data != null) {
        await _handleLoginSuccess(response.data!);
      }
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _handleLoginSuccess(BaseResponseLoginUserResponse responseData) async {
    if (responseData.data != null && responseData.data!.token != null) {
      final token = responseData.data!.token!;
      await _storage.write(key: _tokenKey, value: token);
      ApiClient.instance.setAuthToken(token);

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
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userInfoKey);
    _cachedUserInfo = null;
    ApiClient.instance.clearAuthToken();
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
