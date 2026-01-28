//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/workflow_edge_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_workflow_edge_response.g.dart';

/// BaseResponseWorkflowEdgeResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseWorkflowEdgeResponse
    implements
        Built<BaseResponseWorkflowEdgeResponse,
            BaseResponseWorkflowEdgeResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  WorkflowEdgeResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseWorkflowEdgeResponse._();

  factory BaseResponseWorkflowEdgeResponse(
          [void updates(BaseResponseWorkflowEdgeResponseBuilder b)]) =
      _$BaseResponseWorkflowEdgeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseWorkflowEdgeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseWorkflowEdgeResponse> get serializer =>
      _$BaseResponseWorkflowEdgeResponseSerializer();
}

class _$BaseResponseWorkflowEdgeResponseSerializer
    implements PrimitiveSerializer<BaseResponseWorkflowEdgeResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseWorkflowEdgeResponse,
    _$BaseResponseWorkflowEdgeResponse
  ];

  @override
  final String wireName = r'BaseResponseWorkflowEdgeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseWorkflowEdgeResponse object, {
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
        specifiedType: const FullType(WorkflowEdgeResponse),
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
    BaseResponseWorkflowEdgeResponse object, {
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
    required BaseResponseWorkflowEdgeResponseBuilder result,
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
            specifiedType: const FullType(WorkflowEdgeResponse),
          ) as WorkflowEdgeResponse;
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
  BaseResponseWorkflowEdgeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseWorkflowEdgeResponseBuilder();
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
