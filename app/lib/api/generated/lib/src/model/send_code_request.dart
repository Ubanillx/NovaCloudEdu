//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_code_request.g.dart';

/// 发送验证码请求
///
/// Properties:
/// * [phone] - 手机号
@BuiltValue()
abstract class SendCodeRequest
    implements Built<SendCodeRequest, SendCodeRequestBuilder> {
  /// 手机号
  @BuiltValueField(wireName: r'phone')
  String get phone;

  SendCodeRequest._();

  factory SendCodeRequest([void updates(SendCodeRequestBuilder b)]) =
      _$SendCodeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendCodeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendCodeRequest> get serializer =>
      _$SendCodeRequestSerializer();
}

class _$SendCodeRequestSerializer
    implements PrimitiveSerializer<SendCodeRequest> {
  @override
  final Iterable<Type> types = const [SendCodeRequest, _$SendCodeRequest];

  @override
  final String wireName = r'SendCodeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendCodeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SendCodeRequest object, {
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
    required SendCodeRequestBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendCodeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendCodeRequestBuilder();
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
