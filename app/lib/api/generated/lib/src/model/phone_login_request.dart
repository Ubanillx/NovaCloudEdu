//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'phone_login_request.g.dart';

/// 手机验证码登录请求
///
/// Properties:
/// * [phone] - 手机号
/// * [smsCode] - 短信验证码
@BuiltValue()
abstract class PhoneLoginRequest
    implements Built<PhoneLoginRequest, PhoneLoginRequestBuilder> {
  /// 手机号
  @BuiltValueField(wireName: r'phone')
  String get phone;

  /// 短信验证码
  @BuiltValueField(wireName: r'smsCode')
  String get smsCode;

  PhoneLoginRequest._();

  factory PhoneLoginRequest([void updates(PhoneLoginRequestBuilder b)]) =
      _$PhoneLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PhoneLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PhoneLoginRequest> get serializer =>
      _$PhoneLoginRequestSerializer();
}

class _$PhoneLoginRequestSerializer
    implements PrimitiveSerializer<PhoneLoginRequest> {
  @override
  final Iterable<Type> types = const [PhoneLoginRequest, _$PhoneLoginRequest];

  @override
  final String wireName = r'PhoneLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PhoneLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    PhoneLoginRequest object, {
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
    required PhoneLoginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  PhoneLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PhoneLoginRequestBuilder();
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
