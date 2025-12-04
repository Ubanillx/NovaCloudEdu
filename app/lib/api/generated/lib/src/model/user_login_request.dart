//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_login_request.g.dart';

/// 用户登录请求
///
/// Properties:
/// * [userAccount] - 用户账号
/// * [userPassword] - 用户密码
@BuiltValue()
abstract class UserLoginRequest
    implements Built<UserLoginRequest, UserLoginRequestBuilder> {
  /// 用户账号
  @BuiltValueField(wireName: r'userAccount')
  String get userAccount;

  /// 用户密码
  @BuiltValueField(wireName: r'userPassword')
  String get userPassword;

  UserLoginRequest._();

  factory UserLoginRequest([void updates(UserLoginRequestBuilder b)]) =
      _$UserLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserLoginRequest> get serializer =>
      _$UserLoginRequestSerializer();
}

class _$UserLoginRequestSerializer
    implements PrimitiveSerializer<UserLoginRequest> {
  @override
  final Iterable<Type> types = const [UserLoginRequest, _$UserLoginRequest];

  @override
  final String wireName = r'UserLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userAccount';
    yield serializers.serialize(
      object.userAccount,
      specifiedType: const FullType(String),
    );
    yield r'userPassword';
    yield serializers.serialize(
      object.userPassword,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserLoginRequest object, {
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
    required UserLoginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAccount = valueDes;
          break;
        case r'userPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserLoginRequestBuilder();
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
