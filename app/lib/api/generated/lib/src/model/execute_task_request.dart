//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'execute_task_request.g.dart';

/// ExecuteTaskRequest
///
/// Properties:
/// * [configId]
/// * [maxArticles]
@BuiltValue()
abstract class ExecuteTaskRequest
    implements Built<ExecuteTaskRequest, ExecuteTaskRequestBuilder> {
  @BuiltValueField(wireName: r'configId')
  int get configId;

  @BuiltValueField(wireName: r'maxArticles')
  int? get maxArticles;

  ExecuteTaskRequest._();

  factory ExecuteTaskRequest([void updates(ExecuteTaskRequestBuilder b)]) =
      _$ExecuteTaskRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExecuteTaskRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExecuteTaskRequest> get serializer =>
      _$ExecuteTaskRequestSerializer();
}

class _$ExecuteTaskRequestSerializer
    implements PrimitiveSerializer<ExecuteTaskRequest> {
  @override
  final Iterable<Type> types = const [ExecuteTaskRequest, _$ExecuteTaskRequest];

  @override
  final String wireName = r'ExecuteTaskRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExecuteTaskRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'configId';
    yield serializers.serialize(
      object.configId,
      specifiedType: const FullType(int),
    );
    if (object.maxArticles != null) {
      yield r'maxArticles';
      yield serializers.serialize(
        object.maxArticles,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExecuteTaskRequest object, {
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
    required ExecuteTaskRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'configId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.configId = valueDes;
          break;
        case r'maxArticles':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxArticles = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExecuteTaskRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExecuteTaskRequestBuilder();
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
