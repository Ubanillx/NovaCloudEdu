//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_daily_article_request.g.dart';

/// 创建每日文章请求
///
/// Properties:
/// * [title] - 文章标题
/// * [content] - 文章内容
/// * [difficulty] - 难度等级：1-简单，2-中等，3-困难
/// * [publishDate] - 发布日期
/// * [summary] - 文章摘要
/// * [coverImage] - 封面图片URL
/// * [author] - 作者
/// * [source_] - 来源
/// * [sourceUrl] - 原文链接
/// * [category] - 文章分类
/// * [tags] - 标签列表
/// * [readTime] - 预计阅读时间(分钟)
@BuiltValue()
abstract class CreateDailyArticleRequest
    implements
        Built<CreateDailyArticleRequest, CreateDailyArticleRequestBuilder> {
  /// 文章标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 文章内容
  @BuiltValueField(wireName: r'content')
  String get content;

  /// 难度等级：1-简单，2-中等，3-困难
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// 发布日期
  @BuiltValueField(wireName: r'publishDate')
  Date get publishDate;

  /// 文章摘要
  @BuiltValueField(wireName: r'summary')
  String? get summary;

  /// 封面图片URL
  @BuiltValueField(wireName: r'coverImage')
  String? get coverImage;

  /// 作者
  @BuiltValueField(wireName: r'author')
  String? get author;

  /// 来源
  @BuiltValueField(wireName: r'source')
  String? get source_;

  /// 原文链接
  @BuiltValueField(wireName: r'sourceUrl')
  String? get sourceUrl;

  /// 文章分类
  @BuiltValueField(wireName: r'category')
  String? get category;

  /// 标签列表
  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  /// 预计阅读时间(分钟)
  @BuiltValueField(wireName: r'readTime')
  int? get readTime;

  CreateDailyArticleRequest._();

  factory CreateDailyArticleRequest(
          [void updates(CreateDailyArticleRequestBuilder b)]) =
      _$CreateDailyArticleRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateDailyArticleRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateDailyArticleRequest> get serializer =>
      _$CreateDailyArticleRequestSerializer();
}

class _$CreateDailyArticleRequestSerializer
    implements PrimitiveSerializer<CreateDailyArticleRequest> {
  @override
  final Iterable<Type> types = const [
    CreateDailyArticleRequest,
    _$CreateDailyArticleRequest
  ];

  @override
  final String wireName = r'CreateDailyArticleRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateDailyArticleRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(int),
    );
    yield r'publishDate';
    yield serializers.serialize(
      object.publishDate,
      specifiedType: const FullType(Date),
    );
    if (object.summary != null) {
      yield r'summary';
      yield serializers.serialize(
        object.summary,
        specifiedType: const FullType(String),
      );
    }
    if (object.coverImage != null) {
      yield r'coverImage';
      yield serializers.serialize(
        object.coverImage,
        specifiedType: const FullType(String),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceUrl != null) {
      yield r'sourceUrl';
      yield serializers.serialize(
        object.sourceUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.readTime != null) {
      yield r'readTime';
      yield serializers.serialize(
        object.readTime,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateDailyArticleRequest object, {
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
    required CreateDailyArticleRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'publishDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.publishDate = valueDes;
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.summary = valueDes;
          break;
        case r'coverImage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverImage = valueDes;
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.source_ = valueDes;
          break;
        case r'sourceUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceUrl = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'readTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateDailyArticleRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateDailyArticleRequestBuilder();
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
