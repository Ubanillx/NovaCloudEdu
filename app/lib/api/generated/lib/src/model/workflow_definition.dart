//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/variable_definition.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/workflow_settings.dart';
import 'package:nova_api/src/model/workflow_node.dart';
import 'package:nova_api/src/model/workflow_edge.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_definition.g.dart';

/// 工作流定义
///
/// Properties:
/// * [version]
/// * [nodes]
/// * [edges]
/// * [variables]
/// * [settings]
@BuiltValue()
abstract class WorkflowDefinition
    implements Built<WorkflowDefinition, WorkflowDefinitionBuilder> {
  @BuiltValueField(wireName: r'version')
  String? get version;

  @BuiltValueField(wireName: r'nodes')
  BuiltList<WorkflowNode>? get nodes;

  @BuiltValueField(wireName: r'edges')
  BuiltList<WorkflowEdge>? get edges;

  @BuiltValueField(wireName: r'variables')
  BuiltMap<String, VariableDefinition>? get variables;

  @BuiltValueField(wireName: r'settings')
  WorkflowSettings? get settings;

  WorkflowDefinition._();

  factory WorkflowDefinition([void updates(WorkflowDefinitionBuilder b)]) =
      _$WorkflowDefinition;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowDefinitionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowDefinition> get serializer =>
      _$WorkflowDefinitionSerializer();
}

class _$WorkflowDefinitionSerializer
    implements PrimitiveSerializer<WorkflowDefinition> {
  @override
  final Iterable<Type> types = const [WorkflowDefinition, _$WorkflowDefinition];

  @override
  final String wireName = r'WorkflowDefinition';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowDefinition object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(BuiltList, [FullType(WorkflowNode)]),
      );
    }
    if (object.edges != null) {
      yield r'edges';
      yield serializers.serialize(
        object.edges,
        specifiedType: const FullType(BuiltList, [FullType(WorkflowEdge)]),
      );
    }
    if (object.variables != null) {
      yield r'variables';
      yield serializers.serialize(
        object.variables,
        specifiedType: const FullType(
            BuiltMap, [FullType(String), FullType(VariableDefinition)]),
      );
    }
    if (object.settings != null) {
      yield r'settings';
      yield serializers.serialize(
        object.settings,
        specifiedType: const FullType(WorkflowSettings),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowDefinition object, {
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
    required WorkflowDefinitionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(BuiltList, [FullType(WorkflowNode)]),
          ) as BuiltList<WorkflowNode>;
          result.nodes.replace(valueDes);
          break;
        case r'edges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WorkflowEdge)]),
          ) as BuiltList<WorkflowEdge>;
          result.edges.replace(valueDes);
          break;
        case r'variables':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(VariableDefinition)]),
          ) as BuiltMap<String, VariableDefinition>;
          result.variables.replace(valueDes);
          break;
        case r'settings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkflowSettings),
          ) as WorkflowSettings;
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
  WorkflowDefinition deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowDefinitionBuilder();
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
