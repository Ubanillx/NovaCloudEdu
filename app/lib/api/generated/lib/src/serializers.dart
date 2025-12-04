//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:nova_api/src/date_serializer.dart';
import 'package:nova_api/src/model/date.dart';

import 'package:nova_api/src/model/base_response_boolean.dart';
import 'package:nova_api/src/model/base_response_list_long.dart';
import 'package:nova_api/src/model/base_response_login_user_response.dart';
import 'package:nova_api/src/model/base_response_long.dart';
import 'package:nova_api/src/model/base_response_object.dart';
import 'package:nova_api/src/model/base_response_send_result.dart';
import 'package:nova_api/src/model/base_response_string.dart';
import 'package:nova_api/src/model/base_response_user_detail_response.dart';
import 'package:nova_api/src/model/base_response_user_page_response.dart';
import 'package:nova_api/src/model/base_response_user_public_response.dart';
import 'package:nova_api/src/model/batch_ban_user_request.dart';
import 'package:nova_api/src/model/batch_create_user_request.dart';
import 'package:nova_api/src/model/change_password_request.dart';
import 'package:nova_api/src/model/create_user_request.dart';
import 'package:nova_api/src/model/login_user_response.dart';
import 'package:nova_api/src/model/query_user_request.dart';
import 'package:nova_api/src/model/reset_password_request.dart';
import 'package:nova_api/src/model/send_code_request.dart';
import 'package:nova_api/src/model/send_result.dart';
import 'package:nova_api/src/model/send_sms_request.dart';
import 'package:nova_api/src/model/update_profile_request.dart';
import 'package:nova_api/src/model/update_user_request.dart';
import 'package:nova_api/src/model/user_detail_response.dart';
import 'package:nova_api/src/model/user_login_request.dart';
import 'package:nova_api/src/model/user_page_response.dart';
import 'package:nova_api/src/model/user_public_response.dart';
import 'package:nova_api/src/model/user_register_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  BaseResponseBoolean,
  BaseResponseListLong,
  BaseResponseLoginUserResponse,
  BaseResponseLong,
  BaseResponseObject,
  BaseResponseSendResult,
  BaseResponseString,
  BaseResponseUserDetailResponse,
  BaseResponseUserPageResponse,
  BaseResponseUserPublicResponse,
  BatchBanUserRequest,
  BatchCreateUserRequest,
  ChangePasswordRequest,
  CreateUserRequest,
  LoginUserResponse,
  QueryUserRequest,
  ResetPasswordRequest,
  SendCodeRequest,
  SendResult,
  SendSmsRequest,
  UpdateProfileRequest,
  UpdateUserRequest,
  UserDetailResponse,
  UserLoginRequest,
  UserPageResponse,
  UserPublicResponse,
  UserRegisterRequest,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
