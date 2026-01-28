//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'async_execution_response.g.dart';

/// 异步执行工作流响应
///
/// Properties:
/// * [executionId] - 执行ID，用于后续查询执行状态
/// * [message] - 提示消息
@BuiltValue()
abstract class AsyncExecutionResponse
    implements Built<AsyncExecutionResponse, AsyncExecutionResponseBuilder> {
  /// 执行ID，用于后续查询执行状态
  @BuiltValueField(wireName: r'executionId')
  String? get executionId;

  /// 提示消息
  @BuiltValueField(wireName: r'message')
  String? get message;

  AsyncExecutionResponse._();

  factory AsyncExecutionResponse(
          [void updates(AsyncExecutionResponseBuilder b)]) =
      _$AsyncExecutionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AsyncExecutionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AsyncExecutionResponse> get serializer =>
      _$AsyncExecutionResponseSerializer();
}

class _$AsyncExecutionResponseSerializer
    implements PrimitiveSerializer<AsyncExecutionResponse> {
  @override
  final Iterable<Type> types = const [
    AsyncExecutionResponse,
    _$AsyncExecutionResponse
  ];

  @override
  final String wireName = r'AsyncExecutionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AsyncExecutionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.executionId != null) {
      yield r'executionId';
      yield serializers.serialize(
        object.executionId,
        specifiedType: const FullType(String),
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
    AsyncExecutionResponse object, {
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
    required AsyncExecutionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'executionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.executionId = valueDes;
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
  AsyncExecutionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AsyncExecutionResponseBuilder();
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
