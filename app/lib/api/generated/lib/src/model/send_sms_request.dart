//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_sms_request.g.dart';

/// SendSmsRequest
///
/// Properties:
/// * [phone]
/// * [code]
/// * [expireMinutes]
@BuiltValue()
abstract class SendSmsRequest
    implements Built<SendSmsRequest, SendSmsRequestBuilder> {
  @BuiltValueField(wireName: r'phone')
  String get phone;

  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'expireMinutes')
  int? get expireMinutes;

  SendSmsRequest._();

  factory SendSmsRequest([void updates(SendSmsRequestBuilder b)]) =
      _$SendSmsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendSmsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendSmsRequest> get serializer =>
      _$SendSmsRequestSerializer();
}

class _$SendSmsRequestSerializer
    implements PrimitiveSerializer<SendSmsRequest> {
  @override
  final Iterable<Type> types = const [SendSmsRequest, _$SendSmsRequest];

  @override
  final String wireName = r'SendSmsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendSmsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.expireMinutes != null) {
      yield r'expireMinutes';
      yield serializers.serialize(
        object.expireMinutes,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendSmsRequest object, {
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
    required SendSmsRequestBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'expireMinutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expireMinutes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendSmsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendSmsRequestBuilder();
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
