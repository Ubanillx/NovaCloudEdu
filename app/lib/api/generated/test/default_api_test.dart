import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for DefaultApi
void main() {
  final instance = NovaApi().getDefaultApi();

  group(DefaultApi, () {
    // 批量封禁/解封用户
    //
    // 管理员批量封禁或解封用户
    //
    //Future<BaseResponseBoolean> batchBanUsers(BatchBanUserRequest batchBanUserRequest) async
    test('test batchBanUsers', () async {
      // TODO
    });

    // 批量创建用户
    //
    // 管理员批量创建用户
    //
    //Future<BaseResponseListLong> batchCreateUsers(BatchCreateUserRequest batchCreateUserRequest) async
    test('test batchCreateUsers', () async {
      // TODO
    });

    // 修改密码
    //
    // 用户修改自己的密码，需要验证旧密码
    //
    //Future<BaseResponseBoolean> changePassword(ChangePasswordRequest changePasswordRequest) async
    test('test changePassword', () async {
      // TODO
    });

    // 创建用户
    //
    // 管理员创建单个用户
    //
    //Future<BaseResponseLong> createUser(CreateUserRequest createUserRequest) async
    test('test createUser', () async {
      // TODO
    });

    // 获取当前用户
    //
    // 获取当前登录用户信息
    //
    //Future<BaseResponseLoginUserResponse> getLoginUser() async
    test('test getLoginUser', () async {
      // TODO
    });

    // 获取用户详情
    //
    // 管理员获取用户详细信息
    //
    //Future<BaseResponseUserDetailResponse> getUserDetail(int id) async
    test('test getUserDetail', () async {
      // TODO
    });

    // 获取用户公开信息
    //
    // 获取其他用户的公开信息（非敏感）
    //
    //Future<BaseResponseUserPublicResponse> getUserPublicInfo(int id) async
    test('test getUserPublicInfo', () async {
      // TODO
    });

    // 健康检查
    //
    // 检查服务是否正常运行
    //
    //Future<BaseResponseString> health() async
    test('test health', () async {
      // TODO
    });

    // 分页查询用户
    //
    // 管理员分页查询用户，支持模糊搜索
    //
    //Future<BaseResponseUserPageResponse> queryUsers(QueryUserRequest queryUserRequest) async
    test('test queryUsers', () async {
      // TODO
    });

    // 重置用户密码
    //
    // 管理员重置指定用户的密码
    //
    //Future<BaseResponseBoolean> resetPassword(ResetPasswordRequest resetPasswordRequest) async
    test('test resetPassword', () async {
      // TODO
    });

    // 发送注册验证码
    //
    // 发送短信验证码用于注册
    //
    //Future<BaseResponseSendResult> sendRegisterCode(SendCodeRequest sendCodeRequest) async
    test('test sendRegisterCode', () async {
      // TODO
    });

    // 发送短信验证码
    //
    // 管理员手动发送短信验证码
    //
    //Future<BaseResponseSendResult> sendSms(SendSmsRequest sendSmsRequest) async
    test('test sendSms', () async {
      // TODO
    });

    // 更新个人资料
    //
    // 用户更新自己的个人资料
    //
    //Future<BaseResponseBoolean> updateProfile(UpdateProfileRequest updateProfileRequest) async
    test('test updateProfile', () async {
      // TODO
    });

    // 更新用户
    //
    // 管理员更新用户信息
    //
    //Future<BaseResponseBoolean> updateUser(UpdateUserRequest updateUserRequest) async
    test('test updateUser', () async {
      // TODO
    });

    // 用户登录
    //
    // 用户登录并获取 JWT Token
    //
    //Future<BaseResponseLoginUserResponse> userLogin(UserLoginRequest userLoginRequest) async
    test('test userLogin', () async {
      // TODO
    });

    // 用户注册
    //
    // 新用户注册接口，需先获取短信验证码
    //
    //Future<BaseResponseLong> userRegister(UserRegisterRequest userRegisterRequest) async
    test('test userRegister', () async {
      // TODO
    });
  });
}
