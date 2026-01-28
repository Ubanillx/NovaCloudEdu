//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/workflow_variable_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_workflow_variable_response.g.dart';

/// BaseResponseWorkflowVariableResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseWorkflowVariableResponse
    implements
        Built<BaseResponseWorkflowVariableResponse,
            BaseResponseWorkflowVariableResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  WorkflowVariableResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseWorkflowVariableResponse._();

  factory BaseResponseWorkflowVariableResponse(
          [void updates(BaseResponseWorkflowVariableResponseBuilder b)]) =
      _$BaseResponseWorkflowVariableResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseWorkflowVariableResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseWorkflowVariableResponse> get serializer =>
      _$BaseResponseWorkflowVariableResponseSerializer();
}

class _$BaseResponseWorkflowVariableResponseSerializer
    implements PrimitiveSerializer<BaseResponseWorkflowVariableResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseWorkflowVariableResponse,
    _$BaseResponseWorkflowVariableResponse
  ];

  @override
  final String wireName = r'BaseResponseWorkflowVariableResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseWorkflowVariableResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(WorkflowVariableResponse),
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
    BaseResponseWorkflowVariableResponse object, {
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
    required BaseResponseWorkflowVariableResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkflowVariableResponse),
          ) as WorkflowVariableResponse;
          result.data.replace(valueDes);
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
  BaseResponseWorkflowVariableResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseWorkflowVariableResponseBuilder();
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
