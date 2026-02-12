//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/workflow_edge.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'children_definition.g.dart';

/// ChildrenDefinition
///
/// Properties:
/// * [edges]
@BuiltValue()
abstract class ChildrenDefinition
    implements Built<ChildrenDefinition, ChildrenDefinitionBuilder> {
  @BuiltValueField(wireName: r'edges')
  BuiltList<WorkflowEdge>? get edges;

  ChildrenDefinition._();

  factory ChildrenDefinition([void updates(ChildrenDefinitionBuilder b)]) =
      _$ChildrenDefinition;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChildrenDefinitionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChildrenDefinition> get serializer =>
      _$ChildrenDefinitionSerializer();
}

class _$ChildrenDefinitionSerializer
    implements PrimitiveSerializer<ChildrenDefinition> {
  @override
  final Iterable<Type> types = const [ChildrenDefinition, _$ChildrenDefinition];

  @override
  final String wireName = r'ChildrenDefinition';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChildrenDefinition object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.edges != null) {
      yield r'edges';
      yield serializers.serialize(
        object.edges,
        specifiedType: const FullType(BuiltList, [FullType(WorkflowEdge)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChildrenDefinition object, {
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
    required ChildrenDefinitionBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'edges':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(WorkflowEdge)]),
          ) as BuiltList<WorkflowEdge>;
          result.edges.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChildrenDefinition deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChildrenDefinitionBuilder();
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
