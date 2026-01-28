//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'execute_workflow_request.g.dart';

/// 执行工作流请求
///
/// Properties:
/// * [userId] - 执行用户ID
/// * [input] - 工作流输入参数
@BuiltValue()
abstract class ExecuteWorkflowRequest
    implements Built<ExecuteWorkflowRequest, ExecuteWorkflowRequestBuilder> {
  /// 执行用户ID
  @BuiltValueField(wireName: r'userId')
  int get userId;

  /// 工作流输入参数
  @BuiltValueField(wireName: r'input')
  BuiltMap<String, JsonObject>? get input;

  ExecuteWorkflowRequest._();

  factory ExecuteWorkflowRequest(
          [void updates(ExecuteWorkflowRequestBuilder b)]) =
      _$ExecuteWorkflowRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExecuteWorkflowRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExecuteWorkflowRequest> get serializer =>
      _$ExecuteWorkflowRequestSerializer();
}

class _$ExecuteWorkflowRequestSerializer
    implements PrimitiveSerializer<ExecuteWorkflowRequest> {
  @override
  final Iterable<Type> types = const [
    ExecuteWorkflowRequest,
    _$ExecuteWorkflowRequest
  ];

  @override
  final String wireName = r'ExecuteWorkflowRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExecuteWorkflowRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    if (object.input != null) {
      yield r'input';
      yield serializers.serialize(
        object.input,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExecuteWorkflowRequest object, {
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
    required ExecuteWorkflowRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'input':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.input.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExecuteWorkflowRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExecuteWorkflowRequestBuilder();
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
