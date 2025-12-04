//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_result.g.dart';

/// SendResult
///
/// Properties:
/// * [success]
/// * [requestId]
/// * [errorMsg]
@BuiltValue()
abstract class SendResult implements Built<SendResult, SendResultBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'requestId')
  String? get requestId;

  @BuiltValueField(wireName: r'errorMsg')
  String? get errorMsg;

  SendResult._();

  factory SendResult([void updates(SendResultBuilder b)]) = _$SendResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendResult> get serializer => _$SendResultSerializer();
}

class _$SendResultSerializer implements PrimitiveSerializer<SendResult> {
  @override
  final Iterable<Type> types = const [SendResult, _$SendResult];

  @override
  final String wireName = r'SendResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.requestId != null) {
      yield r'requestId';
      yield serializers.serialize(
        object.requestId,
        specifiedType: const FullType(String),
      );
    }
    if (object.errorMsg != null) {
      yield r'errorMsg';
      yield serializers.serialize(
        object.errorMsg,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SendResult object, {
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
    required SendResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'requestId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requestId = valueDes;
          break;
        case r'errorMsg':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorMsg = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendResultBuilder();
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
