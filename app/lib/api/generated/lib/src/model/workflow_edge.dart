//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_edge.g.dart';

/// WorkflowEdge
///
/// Properties:
/// * [id]
/// * [sourceNodeId]
/// * [targetNodeId]
/// * [sourceHandle]
/// * [targetHandle]
/// * [condition]
/// * [label]
@BuiltValue()
abstract class WorkflowEdge
    implements Built<WorkflowEdge, WorkflowEdgeBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'sourceNodeId')
  String? get sourceNodeId;

  @BuiltValueField(wireName: r'targetNodeId')
  String? get targetNodeId;

  @BuiltValueField(wireName: r'sourceHandle')
  String? get sourceHandle;

  @BuiltValueField(wireName: r'targetHandle')
  String? get targetHandle;

  @BuiltValueField(wireName: r'condition')
  String? get condition;

  @BuiltValueField(wireName: r'label')
  String? get label;

  WorkflowEdge._();

  factory WorkflowEdge([void updates(WorkflowEdgeBuilder b)]) = _$WorkflowEdge;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowEdgeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowEdge> get serializer => _$WorkflowEdgeSerializer();
}

class _$WorkflowEdgeSerializer implements PrimitiveSerializer<WorkflowEdge> {
  @override
  final Iterable<Type> types = const [WorkflowEdge, _$WorkflowEdge];

  @override
  final String wireName = r'WorkflowEdge';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowEdge object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceNodeId != null) {
      yield r'sourceNodeId';
      yield serializers.serialize(
        object.sourceNodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetNodeId != null) {
      yield r'targetNodeId';
      yield serializers.serialize(
        object.targetNodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceHandle != null) {
      yield r'sourceHandle';
      yield serializers.serialize(
        object.sourceHandle,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetHandle != null) {
      yield r'targetHandle';
      yield serializers.serialize(
        object.targetHandle,
        specifiedType: const FullType(String),
      );
    }
    if (object.condition != null) {
      yield r'condition';
      yield serializers.serialize(
        object.condition,
        specifiedType: const FullType(String),
      );
    }
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowEdge object, {
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
    required WorkflowEdgeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'sourceNodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceNodeId = valueDes;
          break;
        case r'targetNodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetNodeId = valueDes;
          break;
        case r'sourceHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceHandle = valueDes;
          break;
        case r'targetHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetHandle = valueDes;
          break;
        case r'condition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.condition = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowEdge deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowEdgeBuilder();
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
