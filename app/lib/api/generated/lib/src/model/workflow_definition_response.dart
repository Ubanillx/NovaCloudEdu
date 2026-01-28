//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/workflow_node_response.dart';
import 'package:nova_api/src/model/workflow_variable_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/workflow_edge_response.dart';
import 'package:nova_api/src/model/workflow_settings_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_definition_response.g.dart';

/// 工作流定义详情响应
///
/// Properties:
/// * [workflowId] - 工作流ID
/// * [workflowName] - 工作流名称
/// * [version] - 定义版本
/// * [nodes] - 节点列表
/// * [edges] - 连接线列表
/// * [variables] - 变量定义
/// * [settings]
@BuiltValue()
abstract class WorkflowDefinitionResponse
    implements
        Built<WorkflowDefinitionResponse, WorkflowDefinitionResponseBuilder> {
  /// 工作流ID
  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  /// 工作流名称
  @BuiltValueField(wireName: r'workflowName')
  String? get workflowName;

  /// 定义版本
  @BuiltValueField(wireName: r'version')
  String? get version;

  /// 节点列表
  @BuiltValueField(wireName: r'nodes')
  BuiltList<WorkflowNodeResponse>? get nodes;

  /// 连接线列表
  @BuiltValueField(wireName: r'edges')
  BuiltList<WorkflowEdgeResponse>? get edges;

  /// 变量定义
  @BuiltValueField(wireName: r'variables')
  BuiltMap<String, WorkflowVariableResponse>? get variables;

  @BuiltValueField(wireName: r'settings')
  WorkflowSettingsDTO? get settings;

  WorkflowDefinitionResponse._();

  factory WorkflowDefinitionResponse(
          [void updates(WorkflowDefinitionResponseBuilder b)]) =
      _$WorkflowDefinitionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowDefinitionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowDefinitionResponse> get serializer =>
      _$WorkflowDefinitionResponseSerializer();
}

class _$WorkflowDefinitionResponseSerializer
    implements PrimitiveSerializer<WorkflowDefinitionResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowDefinitionResponse,
    _$WorkflowDefinitionResponse
  ];

  @override
  final String wireName = r'WorkflowDefinitionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowDefinitionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(int),
      );
    }
    if (object.workflowName != null) {
      yield r'workflowName';
      yield serializers.serialize(
        object.workflowName,
        specifiedType: const FullType(String),
      );
    }
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType(String),
      );
    }
    if (object.nodes != null) {
      yield r'nodes';
      yield serializers.serialize(
        object.nodes,
        specifiedType:
            const FullType(BuiltList, [FullType(WorkflowNodeResponse)]),
      );
    }
    if (object.edges != null) {
      yield r'edges';
      yield serializers.serialize(
        object.edges,
        specifiedType:
            const FullType(BuiltList, [FullType(WorkflowEdgeResponse)]),
      );
    }
    if (object.variables != null) {
      yield r'variables';
      yield serializers.serialize(
        object.variables,
        specifiedType: const FullType(
            BuiltMap, [FullType(String), FullType(WorkflowVariableResponse)]),
      );
    }
    if (object.settings != null) {
      yield r'settings';
      yield serializers.serialize(
        object.settings,
        specifiedType: const FullType(WorkflowSettingsDTO),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowDefinitionResponse object, {
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
    required WorkflowDefinitionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowId = valueDes;
          break;
        case r'workflowName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workflowName = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.version = valueDes;
          break;
        case r'nodes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(WorkflowNodeResponse)]),
          ) as BuiltList<WorkflowNodeResponse>;
          result.nodes.replace(valueDes);
          break;
        case r'edges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(WorkflowEdgeResponse)]),
          ) as BuiltList<WorkflowEdgeResponse>;
          result.edges.replace(valueDes);
          break;
        case r'variables':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap,
                [FullType(String), FullType(WorkflowVariableResponse)]),
          ) as BuiltMap<String, WorkflowVariableResponse>;
          result.variables.replace(valueDes);
          break;
        case r'settings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkflowSettingsDTO),
          ) as WorkflowSettingsDTO;
          result.settings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowDefinitionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowDefinitionResponseBuilder();
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
