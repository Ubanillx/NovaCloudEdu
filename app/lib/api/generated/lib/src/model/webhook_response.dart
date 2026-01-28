//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'webhook_response.g.dart';

/// WebhookResponse
///
/// Properties:
/// * [executionId]
/// * [workflowId]
/// * [status]
/// * [message]
@BuiltValue()
abstract class WebhookResponse
    implements Built<WebhookResponse, WebhookResponseBuilder> {
  @BuiltValueField(wireName: r'executionId')
  String? get executionId;

  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'message')
  String? get message;

  WebhookResponse._();

  factory WebhookResponse([void updates(WebhookResponseBuilder b)]) =
      _$WebhookResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WebhookResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WebhookResponse> get serializer =>
      _$WebhookResponseSerializer();
}

class _$WebhookResponseSerializer
    implements PrimitiveSerializer<WebhookResponse> {
  @override
  final Iterable<Type> types = const [WebhookResponse, _$WebhookResponse];

  @override
  final String wireName = r'WebhookResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WebhookResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.executionId != null) {
      yield r'executionId';
      yield serializers.serialize(
        object.executionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WebhookResponse object, {
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
    required WebhookResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'executionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.executionId = valueDes;
          break;
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WebhookResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WebhookResponseBuilder();
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
