//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ai_process_article_request.g.dart';

/// AI 处理文章请求
///
/// Properties:
/// * [articleId] - 文章ID
/// * [formatContent] - 是否格式化内容为 Markdown
/// * [generateSummary] - 是否生成摘要
/// * [summaryMaxLength] - 摘要最大长度
@BuiltValue()
abstract class AiProcessArticleRequest
    implements Built<AiProcessArticleRequest, AiProcessArticleRequestBuilder> {
  /// 文章ID
  @BuiltValueField(wireName: r'articleId')
  int get articleId;

  /// 是否格式化内容为 Markdown
  @BuiltValueField(wireName: r'formatContent')
  bool? get formatContent;

  /// 是否生成摘要
  @BuiltValueField(wireName: r'generateSummary')
  bool? get generateSummary;

  /// 摘要最大长度
  @BuiltValueField(wireName: r'summaryMaxLength')
  int? get summaryMaxLength;

  AiProcessArticleRequest._();

  factory AiProcessArticleRequest(
          [void updates(AiProcessArticleRequestBuilder b)]) =
      _$AiProcessArticleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AiProcessArticleRequestBuilder b) => b
    ..formatContent = true
    ..generateSummary = true
    ..summaryMaxLength = 150;

  @BuiltValueSerializer(custom: true)
  static Serializer<AiProcessArticleRequest> get serializer =>
      _$AiProcessArticleRequestSerializer();
}

class _$AiProcessArticleRequestSerializer
    implements PrimitiveSerializer<AiProcessArticleRequest> {
  @override
  final Iterable<Type> types = const [
    AiProcessArticleRequest,
    _$AiProcessArticleRequest
  ];

  @override
  final String wireName = r'AiProcessArticleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AiProcessArticleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'articleId';
    yield serializers.serialize(
      object.articleId,
      specifiedType: const FullType(int),
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
    if (object.summaryMaxLength != null) {
      yield r'summaryMaxLength';
      yield serializers.serialize(
        object.summaryMaxLength,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AiProcessArticleRequest object, {
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
    required AiProcessArticleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'articleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.articleId = valueDes;
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
        case r'summaryMaxLength':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.summaryMaxLength = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AiProcessArticleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AiProcessArticleRequestBuilder();
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
