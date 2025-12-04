# nova_api.api.DefaultApi

## Load the API package
```dart
import 'package:nova_api/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**batchBanUsers**](DefaultApi.md#batchbanusers) | **POST** /api/user/admin/ban | 批量封禁/解封用户
[**batchCreateUsers**](DefaultApi.md#batchcreateusers) | **POST** /api/user/admin/batch-create | 批量创建用户
[**changePassword**](DefaultApi.md#changepassword) | **POST** /api/user/password | 修改密码
[**createUser**](DefaultApi.md#createuser) | **POST** /api/user/admin/create | 创建用户
[**getLoginUser**](DefaultApi.md#getloginuser) | **GET** /api/auth/current | 获取当前用户
[**getUserDetail**](DefaultApi.md#getuserdetail) | **GET** /api/user/admin/{id} | 获取用户详情
[**getUserPublicInfo**](DefaultApi.md#getuserpublicinfo) | **GET** /api/user/public/{id} | 获取用户公开信息
[**health**](DefaultApi.md#health) | **GET** /api/health | 健康检查
[**queryUsers**](DefaultApi.md#queryusers) | **POST** /api/user/admin/list | 分页查询用户
[**resetPassword**](DefaultApi.md#resetpassword) | **POST** /api/user/admin/reset-password | 重置用户密码
[**sendRegisterCode**](DefaultApi.md#sendregistercode) | **POST** /api/auth/send-code | 发送注册验证码
[**sendSms**](DefaultApi.md#sendsms) | **POST** /api/user/admin/send-sms | 发送短信验证码
[**updateProfile**](DefaultApi.md#updateprofile) | **PUT** /api/user/profile | 更新个人资料
[**updateUser**](DefaultApi.md#updateuser) | **PUT** /api/user/admin/update | 更新用户
[**userLogin**](DefaultApi.md#userlogin) | **POST** /api/auth/login | 用户登录
[**userRegister**](DefaultApi.md#userregister) | **POST** /api/auth/register | 用户注册


# **batchBanUsers**
> BaseResponseBoolean batchBanUsers(batchBanUserRequest)

批量封禁/解封用户

管理员批量封禁或解封用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final BatchBanUserRequest batchBanUserRequest = ; // BatchBanUserRequest | 

try {
    final response = api.batchBanUsers(batchBanUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchBanUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchBanUserRequest** | [**BatchBanUserRequest**](BatchBanUserRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **batchCreateUsers**
> BaseResponseListLong batchCreateUsers(batchCreateUserRequest)

批量创建用户

管理员批量创建用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final BatchCreateUserRequest batchCreateUserRequest = ; // BatchCreateUserRequest | 

try {
    final response = api.batchCreateUsers(batchCreateUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->batchCreateUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **batchCreateUserRequest** | [**BatchCreateUserRequest**](BatchCreateUserRequest.md)|  | 

### Return type

[**BaseResponseListLong**](BaseResponseListLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **changePassword**
> BaseResponseBoolean changePassword(changePasswordRequest)

修改密码

用户修改自己的密码，需要验证旧密码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | 

try {
    final response = api.changePassword(changePasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->changePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createUser**
> BaseResponseLong createUser(createUserRequest)

创建用户

管理员创建单个用户

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final CreateUserRequest createUserRequest = ; // CreateUserRequest | 

try {
    final response = api.createUser(createUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->createUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createUserRequest** | [**CreateUserRequest**](CreateUserRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLoginUser**
> BaseResponseLoginUserResponse getLoginUser()

获取当前用户

获取当前登录用户信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.getLoginUser();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getLoginUser: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseLoginUserResponse**](BaseResponseLoginUserResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDetail**
> BaseResponseUserDetailResponse getUserDetail(id)

获取用户详情

管理员获取用户详细信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getUserDetail(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseUserDetailResponse**](BaseResponseUserDetailResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPublicInfo**
> BaseResponseUserPublicResponse getUserPublicInfo(id)

获取用户公开信息

获取其他用户的公开信息（非敏感）

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final int id = 789; // int | 

try {
    final response = api.getUserPublicInfo(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->getUserPublicInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**BaseResponseUserPublicResponse**](BaseResponseUserPublicResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **health**
> BaseResponseString health()

健康检查

检查服务是否正常运行

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();

try {
    final response = api.health();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->health: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BaseResponseString**](BaseResponseString.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryUsers**
> BaseResponseUserPageResponse queryUsers(queryUserRequest)

分页查询用户

管理员分页查询用户，支持模糊搜索

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final QueryUserRequest queryUserRequest = ; // QueryUserRequest | 

try {
    final response = api.queryUsers(queryUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->queryUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queryUserRequest** | [**QueryUserRequest**](QueryUserRequest.md)|  | 

### Return type

[**BaseResponseUserPageResponse**](BaseResponseUserPageResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetPassword**
> BaseResponseBoolean resetPassword(resetPasswordRequest)

重置用户密码

管理员重置指定用户的密码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final ResetPasswordRequest resetPasswordRequest = ; // ResetPasswordRequest | 

try {
    final response = api.resetPassword(resetPasswordRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->resetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordRequest** | [**ResetPasswordRequest**](ResetPasswordRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendRegisterCode**
> BaseResponseSendResult sendRegisterCode(sendCodeRequest)

发送注册验证码

发送短信验证码用于注册

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SendCodeRequest sendCodeRequest = ; // SendCodeRequest | 

try {
    final response = api.sendRegisterCode(sendCodeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->sendRegisterCode: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendCodeRequest** | [**SendCodeRequest**](SendCodeRequest.md)|  | 

### Return type

[**BaseResponseSendResult**](BaseResponseSendResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendSms**
> BaseResponseSendResult sendSms(sendSmsRequest)

发送短信验证码

管理员手动发送短信验证码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final SendSmsRequest sendSmsRequest = ; // SendSmsRequest | 

try {
    final response = api.sendSms(sendSmsRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->sendSms: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendSmsRequest** | [**SendSmsRequest**](SendSmsRequest.md)|  | 

### Return type

[**BaseResponseSendResult**](BaseResponseSendResult.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateProfile**
> BaseResponseBoolean updateProfile(updateProfileRequest)

更新个人资料

用户更新自己的个人资料

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateProfileRequest updateProfileRequest = ; // UpdateProfileRequest | 

try {
    final response = api.updateProfile(updateProfileRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProfileRequest** | [**UpdateProfileRequest**](UpdateProfileRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> BaseResponseBoolean updateUser(updateUserRequest)

更新用户

管理员更新用户信息

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UpdateUserRequest updateUserRequest = ; // UpdateUserRequest | 

try {
    final response = api.updateUser(updateUserRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->updateUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUserRequest** | [**UpdateUserRequest**](UpdateUserRequest.md)|  | 

### Return type

[**BaseResponseBoolean**](BaseResponseBoolean.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userLogin**
> BaseResponseLoginUserResponse userLogin(userLoginRequest)

用户登录

用户登录并获取 JWT Token

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UserLoginRequest userLoginRequest = ; // UserLoginRequest | 

try {
    final response = api.userLogin(userLoginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->userLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userLoginRequest** | [**UserLoginRequest**](UserLoginRequest.md)|  | 

### Return type

[**BaseResponseLoginUserResponse**](BaseResponseLoginUserResponse.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **userRegister**
> BaseResponseLong userRegister(userRegisterRequest)

用户注册

新用户注册接口，需先获取短信验证码

### Example
```dart
import 'package:nova_api/api.dart';

final api = NovaApi().getDefaultApi();
final UserRegisterRequest userRegisterRequest = ; // UserRegisterRequest | 

try {
    final response = api.userRegister(userRegisterRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DefaultApi->userRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userRegisterRequest** | [**UserRegisterRequest**](UserRegisterRequest.md)|  | 

### Return type

[**BaseResponseLong**](BaseResponseLong.md)

### Authorization

[Bearer Token](../README.md#Bearer Token)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

