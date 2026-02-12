//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_trigger_response.g.dart';

/// 工作流触发器响应
///
/// Properties:
/// * [id] - 触发器ID
/// * [workflowId] - 工作流ID
/// * [type] - 触发器类型：SCHEDULE/WEBHOOK/EVENT
/// * [name] - 触发器名称
/// * [enabled] - 是否启用
/// * [config] - 配置JSON
/// * [lastTriggeredAt] - 最后触发时间
/// * [triggerCount] - 触发次数
/// * [createTime] - 创建时间
@BuiltValue()
abstract class WorkflowTriggerResponse
    implements Built<WorkflowTriggerResponse, WorkflowTriggerResponseBuilder> {
  /// 触发器ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 工作流ID
  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  /// 触发器类型：SCHEDULE/WEBHOOK/EVENT
  @BuiltValueField(wireName: r'type')
  String? get type;

  /// 触发器名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 是否启用
  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  /// 配置JSON
  @BuiltValueField(wireName: r'config')
  BuiltMap<String, JsonObject>? get config;

  /// 最后触发时间
  @BuiltValueField(wireName: r'lastTriggeredAt')
  DateTime? get lastTriggeredAt;

  /// 触发次数
  @BuiltValueField(wireName: r'triggerCount')
  int? get triggerCount;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  WorkflowTriggerResponse._();

  factory WorkflowTriggerResponse(
          [void updates(WorkflowTriggerResponseBuilder b)]) =
      _$WorkflowTriggerResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowTriggerResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowTriggerResponse> get serializer =>
      _$WorkflowTriggerResponseSerializer();
}

class _$WorkflowTriggerResponseSerializer
    implements PrimitiveSerializer<WorkflowTriggerResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowTriggerResponse,
    _$WorkflowTriggerResponse
  ];

  @override
  final String wireName = r'WorkflowTriggerResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowTriggerResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(int),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    if (object.config != null) {
      yield r'config';
      yield serializers.serialize(
        object.config,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
    if (object.lastTriggeredAt != null) {
      yield r'lastTriggeredAt';
      yield serializers.serialize(
        object.lastTriggeredAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.triggerCount != null) {
      yield r'triggerCount';
      yield serializers.serialize(
        object.triggerCount,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowTriggerResponse object, {
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
    required WorkflowTriggerResponseBuilder result,
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
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'config':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.config.replace(valueDes);
          break;
        case r'lastTriggeredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastTriggeredAt = valueDes;
          break;
        case r'triggerCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.triggerCount = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowTriggerResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowTriggerResponseBuilder();
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
