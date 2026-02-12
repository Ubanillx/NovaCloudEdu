//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/skill_param_vo.dart';
import 'package:nova_api/src/model/skill_output_vo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_skill_vo.g.dart';

/// WorkflowSkillVO
///
/// Properties:
/// * [workflowId]
/// * [name]
/// * [description]
/// * [status]
/// * [inputParameters]
/// * [outputVariables]
@BuiltValue()
abstract class WorkflowSkillVO
    implements Built<WorkflowSkillVO, WorkflowSkillVOBuilder> {
  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'inputParameters')
  BuiltList<SkillParamVO>? get inputParameters;

  @BuiltValueField(wireName: r'outputVariables')
  BuiltList<SkillOutputVO>? get outputVariables;

  WorkflowSkillVO._();

  factory WorkflowSkillVO([void updates(WorkflowSkillVOBuilder b)]) =
      _$WorkflowSkillVO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowSkillVOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowSkillVO> get serializer =>
      _$WorkflowSkillVOSerializer();
}

class _$WorkflowSkillVOSerializer
    implements PrimitiveSerializer<WorkflowSkillVO> {
  @override
  final Iterable<Type> types = const [WorkflowSkillVO, _$WorkflowSkillVO];

  @override
  final String wireName = r'WorkflowSkillVO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowSkillVO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.inputParameters != null) {
      yield r'inputParameters';
      yield serializers.serialize(
        object.inputParameters,
        specifiedType: const FullType(BuiltList, [FullType(SkillParamVO)]),
      );
    }
    if (object.outputVariables != null) {
      yield r'outputVariables';
      yield serializers.serialize(
        object.outputVariables,
        specifiedType: const FullType(BuiltList, [FullType(SkillOutputVO)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowSkillVO object, {
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
    required WorkflowSkillVOBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'inputParameters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SkillParamVO)]),
          ) as BuiltList<SkillParamVO>;
          result.inputParameters.replace(valueDes);
          break;
        case r'outputVariables':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SkillOutputVO)]),
          ) as BuiltList<SkillOutputVO>;
          result.outputVariables.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowSkillVO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowSkillVOBuilder();
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
