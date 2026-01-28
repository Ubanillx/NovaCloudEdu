//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/validation_error_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/validation_warning_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_validation_response.g.dart';

/// 工作流验证响应
///
/// Properties:
/// * [valid] - 是否验证通过
/// * [errors] - 错误列表
/// * [warnings] - 警告列表
@BuiltValue()
abstract class WorkflowValidationResponse
    implements
        Built<WorkflowValidationResponse, WorkflowValidationResponseBuilder> {
  /// 是否验证通过
  @BuiltValueField(wireName: r'valid')
  bool? get valid;

  /// 错误列表
  @BuiltValueField(wireName: r'errors')
  BuiltList<ValidationErrorDTO>? get errors;

  /// 警告列表
  @BuiltValueField(wireName: r'warnings')
  BuiltList<ValidationWarningDTO>? get warnings;

  WorkflowValidationResponse._();

  factory WorkflowValidationResponse(
          [void updates(WorkflowValidationResponseBuilder b)]) =
      _$WorkflowValidationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowValidationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowValidationResponse> get serializer =>
      _$WorkflowValidationResponseSerializer();
}

class _$WorkflowValidationResponseSerializer
    implements PrimitiveSerializer<WorkflowValidationResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowValidationResponse,
    _$WorkflowValidationResponse
  ];

  @override
  final String wireName = r'WorkflowValidationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowValidationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.valid != null) {
      yield r'valid';
      yield serializers.serialize(
        object.valid,
        specifiedType: const FullType(bool),
      );
    }
    if (object.errors != null) {
      yield r'errors';
      yield serializers.serialize(
        object.errors,
        specifiedType:
            const FullType(BuiltList, [FullType(ValidationErrorDTO)]),
      );
    }
    if (object.warnings != null) {
      yield r'warnings';
      yield serializers.serialize(
        object.warnings,
        specifiedType:
            const FullType(BuiltList, [FullType(ValidationWarningDTO)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowValidationResponse object, {
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
    required WorkflowValidationResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'valid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.valid = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ValidationErrorDTO)]),
          ) as BuiltList<ValidationErrorDTO>;
          result.errors.replace(valueDes);
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ValidationWarningDTO)]),
          ) as BuiltList<ValidationWarningDTO>;
          result.warnings.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowValidationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowValidationResponseBuilder();
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
