//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_ai_process_request.g.dart';

/// 批量 AI 处理文章请求
///
/// Properties:
/// * [articleIds] - 文章ID列表
/// * [formatContent] - 是否格式化内容为 Markdown
/// * [generateSummary] - 是否生成摘要
@BuiltValue()
abstract class BatchAiProcessRequest
    implements Built<BatchAiProcessRequest, BatchAiProcessRequestBuilder> {
  /// 文章ID列表
  @BuiltValueField(wireName: r'articleIds')
  BuiltList<int> get articleIds;

  /// 是否格式化内容为 Markdown
  @BuiltValueField(wireName: r'formatContent')
  bool? get formatContent;

  /// 是否生成摘要
  @BuiltValueField(wireName: r'generateSummary')
  bool? get generateSummary;

  BatchAiProcessRequest._();

  factory BatchAiProcessRequest(
      [void updates(BatchAiProcessRequestBuilder b)]) = _$BatchAiProcessRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BatchAiProcessRequestBuilder b) => b
    ..formatContent = true
    ..generateSummary = true;

  @BuiltValueSerializer(custom: true)
  static Serializer<BatchAiProcessRequest> get serializer =>
      _$BatchAiProcessRequestSerializer();
}

class _$BatchAiProcessRequestSerializer
    implements PrimitiveSerializer<BatchAiProcessRequest> {
  @override
  final Iterable<Type> types = const [
    BatchAiProcessRequest,
    _$BatchAiProcessRequest
  ];

  @override
  final String wireName = r'BatchAiProcessRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BatchAiProcessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'articleIds';
    yield serializers.serialize(
      object.articleIds,
      specifiedType: const FullType(BuiltList, [FullType(int)]),
    );
    if (object.formatContent != null) {
      yield r'formatContent';
      yield serializers.serialize(
        object.formatContent,
        specifiedType: const FullType(bool),
      );
    }
    if (object.generateSummary != null) {
      yield r'generateSummary';
      yield serializers.serialize(
        object.generateSummary,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BatchAiProcessRequest object, {
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
    required BatchAiProcessRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'articleIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.articleIds.replace(valueDes);
          break;
        case r'formatContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.formatContent = valueDes;
          break;
        case r'generateSummary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.generateSummary = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BatchAiProcessRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BatchAiProcessRequestBuilder();
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
