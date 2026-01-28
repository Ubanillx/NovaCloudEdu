//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'webhook_info.g.dart';

/// WebhookInfo
///
/// Properties:
/// * [triggerId]
/// * [triggerName]
/// * [workflowId]
/// * [webhookPath]
/// * [enabled]
/// * [triggerCount]
/// * [lastTriggeredAt]
@BuiltValue()
abstract class WebhookInfo implements Built<WebhookInfo, WebhookInfoBuilder> {
  @BuiltValueField(wireName: r'triggerId')
  int? get triggerId;

  @BuiltValueField(wireName: r'triggerName')
  String? get triggerName;

  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  @BuiltValueField(wireName: r'webhookPath')
  String? get webhookPath;

  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  @BuiltValueField(wireName: r'triggerCount')
  int? get triggerCount;

  @BuiltValueField(wireName: r'lastTriggeredAt')
  DateTime? get lastTriggeredAt;

  WebhookInfo._();

  factory WebhookInfo([void updates(WebhookInfoBuilder b)]) = _$WebhookInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WebhookInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WebhookInfo> get serializer => _$WebhookInfoSerializer();
}

class _$WebhookInfoSerializer implements PrimitiveSerializer<WebhookInfo> {
  @override
  final Iterable<Type> types = const [WebhookInfo, _$WebhookInfo];

  @override
  final String wireName = r'WebhookInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WebhookInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.triggerId != null) {
      yield r'triggerId';
      yield serializers.serialize(
        object.triggerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.triggerName != null) {
      yield r'triggerName';
      yield serializers.serialize(
        object.triggerName,
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
    if (object.webhookPath != null) {
      yield r'webhookPath';
      yield serializers.serialize(
        object.webhookPath,
        specifiedType: const FullType(String),
      );
    }
    if (object.enabled != null) {
      yield r'enabled';
      yield serializers.serialize(
        object.enabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.triggerCount != null) {
      yield r'triggerCount';
      yield serializers.serialize(
        object.triggerCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastTriggeredAt != null) {
      yield r'lastTriggeredAt';
      yield serializers.serialize(
        object.lastTriggeredAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WebhookInfo object, {
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
    required WebhookInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'triggerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.triggerId = valueDes;
          break;
        case r'triggerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.triggerName = valueDes;
          break;
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowId = valueDes;
          break;
        case r'webhookPath':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.webhookPath = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'triggerCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.triggerCount = valueDes;
          break;
        case r'lastTriggeredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastTriggeredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WebhookInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WebhookInfoBuilder();
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
