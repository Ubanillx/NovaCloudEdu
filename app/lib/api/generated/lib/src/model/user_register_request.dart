//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_register_request.g.dart';

/// 用户注册请求
///
/// Properties:
/// * [userAccount] - 用户账号
/// * [userPassword] - 用户密码
/// * [checkPassword] - 确认密码
/// * [phone] - 手机号
/// * [smsCode] - 短信验证码
@BuiltValue()
abstract class UserRegisterRequest
    implements Built<UserRegisterRequest, UserRegisterRequestBuilder> {
  /// 用户账号
  @BuiltValueField(wireName: r'userAccount')
  String get userAccount;

  /// 用户密码
  @BuiltValueField(wireName: r'userPassword')
  String get userPassword;

  /// 确认密码
  @BuiltValueField(wireName: r'checkPassword')
  String get checkPassword;

  /// 手机号
  @BuiltValueField(wireName: r'phone')
  String get phone;

  /// 短信验证码
  @BuiltValueField(wireName: r'smsCode')
  String get smsCode;

  UserRegisterRequest._();

  factory UserRegisterRequest([void updates(UserRegisterRequestBuilder b)]) =
      _$UserRegisterRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserRegisterRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserRegisterRequest> get serializer =>
      _$UserRegisterRequestSerializer();
}

class _$UserRegisterRequestSerializer
    implements PrimitiveSerializer<UserRegisterRequest> {
  @override
  final Iterable<Type> types = const [
    UserRegisterRequest,
    _$UserRegisterRequest
  ];

  @override
  final String wireName = r'UserRegisterRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserRegisterRequest object, {
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
    yield r'checkPassword';
    yield serializers.serialize(
      object.checkPassword,
      specifiedType: const FullType(String),
    );
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
    yield r'smsCode';
    yield serializers.serialize(
      object.smsCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UserRegisterRequest object, {
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
    required UserRegisterRequestBuilder result,
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
        case r'checkPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checkPassword = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        case r'smsCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.smsCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserRegisterRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserRegisterRequestBuilder();
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
