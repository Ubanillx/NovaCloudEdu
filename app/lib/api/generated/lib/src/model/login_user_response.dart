//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_user_response.g.dart';

/// 登录用户信息
///
/// Properties:
/// * [id] - 用户ID
/// * [userAccount] - 用户账号
/// * [userName] - 用户昵称
/// * [userAvatar] - 用户头像
/// * [userProfile] - 用户简介
/// * [userRole] - 用户角色
/// * [userGender] - 用户性别
/// * [userPhone] - 用户手机
/// * [userEmail] - 用户邮箱
/// * [level] - 等级
/// * [createTime] - 创建时间
/// * [token] - JWT Token
@BuiltValue()
abstract class LoginUserResponse
    implements Built<LoginUserResponse, LoginUserResponseBuilder> {
  /// 用户ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户账号
  @BuiltValueField(wireName: r'userAccount')
  String? get userAccount;

  /// 用户昵称
  @BuiltValueField(wireName: r'userName')
  String? get userName;

  /// 用户头像
  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  /// 用户简介
  @BuiltValueField(wireName: r'userProfile')
  String? get userProfile;

  /// 用户角色
  @BuiltValueField(wireName: r'userRole')
  String? get userRole;

  /// 用户性别
  @BuiltValueField(wireName: r'userGender')
  int? get userGender;

  /// 用户手机
  @BuiltValueField(wireName: r'userPhone')
  String? get userPhone;

  /// 用户邮箱
  @BuiltValueField(wireName: r'userEmail')
  String? get userEmail;

  /// 等级
  @BuiltValueField(wireName: r'level')
  int? get level;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// JWT Token
  @BuiltValueField(wireName: r'token')
  String? get token;

  LoginUserResponse._();

  factory LoginUserResponse([void updates(LoginUserResponseBuilder b)]) =
      _$LoginUserResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginUserResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginUserResponse> get serializer =>
      _$LoginUserResponseSerializer();
}

class _$LoginUserResponseSerializer
    implements PrimitiveSerializer<LoginUserResponse> {
  @override
  final Iterable<Type> types = const [LoginUserResponse, _$LoginUserResponse];

  @override
  final String wireName = r'LoginUserResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userAccount != null) {
      yield r'userAccount';
      yield serializers.serialize(
        object.userAccount,
        specifiedType: const FullType(String),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userAvatar != null) {
      yield r'userAvatar';
      yield serializers.serialize(
        object.userAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.userProfile != null) {
      yield r'userProfile';
      yield serializers.serialize(
        object.userProfile,
        specifiedType: const FullType(String),
      );
    }
    if (object.userRole != null) {
      yield r'userRole';
      yield serializers.serialize(
        object.userRole,
        specifiedType: const FullType(String),
      );
    }
    if (object.userGender != null) {
      yield r'userGender';
      yield serializers.serialize(
        object.userGender,
        specifiedType: const FullType(int),
      );
    }
    if (object.userPhone != null) {
      yield r'userPhone';
      yield serializers.serialize(
        object.userPhone,
        specifiedType: const FullType(String),
      );
    }
    if (object.userEmail != null) {
      yield r'userEmail';
      yield serializers.serialize(
        object.userEmail,
        specifiedType: const FullType(String),
      );
    }
    if (object.level != null) {
      yield r'level';
      yield serializers.serialize(
        object.level,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginUserResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'userAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAccount = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'userAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAvatar = valueDes;
          break;
        case r'userProfile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userProfile = valueDes;
          break;
        case r'userRole':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userRole = valueDes;
          break;
        case r'userGender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userGender = valueDes;
          break;
        case r'userPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userPhone = valueDes;
          break;
        case r'userEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userEmail = valueDes;
          break;
        case r'level':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.level = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginUserResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginUserResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
