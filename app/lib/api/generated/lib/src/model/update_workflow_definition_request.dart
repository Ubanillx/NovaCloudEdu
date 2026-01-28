//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/workflow_definition.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_workflow_definition_request.g.dart';

/// 更新工作流定义请求
///
/// Properties:
/// * [definition]
@BuiltValue()
abstract class UpdateWorkflowDefinitionRequest
    implements
        Built<UpdateWorkflowDefinitionRequest,
            UpdateWorkflowDefinitionRequestBuilder> {
  @BuiltValueField(wireName: r'definition')
  WorkflowDefinition get definition;

  UpdateWorkflowDefinitionRequest._();

  factory UpdateWorkflowDefinitionRequest(
          [void updates(UpdateWorkflowDefinitionRequestBuilder b)]) =
      _$UpdateWorkflowDefinitionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateWorkflowDefinitionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateWorkflowDefinitionRequest> get serializer =>
      _$UpdateWorkflowDefinitionRequestSerializer();
}

class _$UpdateWorkflowDefinitionRequestSerializer
    implements PrimitiveSerializer<UpdateWorkflowDefinitionRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateWorkflowDefinitionRequest,
    _$UpdateWorkflowDefinitionRequest
  ];

  @override
  final String wireName = r'UpdateWorkflowDefinitionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateWorkflowDefinitionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'definition';
    yield serializers.serialize(
      object.definition,
      specifiedType: const FullType(WorkflowDefinition),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateWorkflowDefinitionRequest object, {
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
    required UpdateWorkflowDefinitionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'definition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkflowDefinition),
          ) as WorkflowDefinition;
          result.definition.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateWorkflowDefinitionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateWorkflowDefinitionRequestBuilder();
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
