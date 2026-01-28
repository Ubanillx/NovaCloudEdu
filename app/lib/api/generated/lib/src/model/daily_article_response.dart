//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_article_response.g.dart';

/// 每日文章响应
///
/// Properties:
/// * [id] - ID
/// * [title] - 文章标题
/// * [content] - 文章内容
/// * [summary] - 文章摘要
/// * [coverImage] - 封面图片URL
/// * [author] - 作者
/// * [source_] - 来源
/// * [sourceUrl] - 原文链接
/// * [category] - 文章分类
/// * [tags] - 标签列表
/// * [difficulty] - 难度等级
/// * [difficultyDesc] - 难度描述
/// * [readTime] - 预计阅读时间(分钟)
/// * [publishDate] - 发布日期
/// * [viewCount] - 查看次数
/// * [likeCount] - 点赞次数
/// * [collectCount] - 收藏次数
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class DailyArticleResponse
    implements Built<DailyArticleResponse, DailyArticleResponseBuilder> {
  /// ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 文章标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 文章内容
  @BuiltValueField(wireName: r'content')
  String? get content;

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

  /// 难度等级
  @BuiltValueField(wireName: r'difficulty')
  int? get difficulty;

  /// 难度描述
  @BuiltValueField(wireName: r'difficultyDesc')
  String? get difficultyDesc;

  /// 预计阅读时间(分钟)
  @BuiltValueField(wireName: r'readTime')
  int? get readTime;

  /// 发布日期
  @BuiltValueField(wireName: r'publishDate')
  Date? get publishDate;

  /// 查看次数
  @BuiltValueField(wireName: r'viewCount')
  int? get viewCount;

  /// 点赞次数
  @BuiltValueField(wireName: r'likeCount')
  int? get likeCount;

  /// 收藏次数
  @BuiltValueField(wireName: r'collectCount')
  int? get collectCount;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  DailyArticleResponse._();

  factory DailyArticleResponse([void updates(DailyArticleResponseBuilder b)]) =
      _$DailyArticleResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyArticleResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyArticleResponse> get serializer =>
      _$DailyArticleResponseSerializer();
}

class _$DailyArticleResponseSerializer
    implements PrimitiveSerializer<DailyArticleResponse> {
  @override
  final Iterable<Type> types = const [
    DailyArticleResponse,
    _$DailyArticleResponse
  ];

  @override
  final String wireName = r'DailyArticleResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyArticleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(int),
      );
    }
    if (object.difficultyDesc != null) {
      yield r'difficultyDesc';
      yield serializers.serialize(
        object.difficultyDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.readTime != null) {
      yield r'readTime';
      yield serializers.serialize(
        object.readTime,
        specifiedType: const FullType(int),
      );
    }
    if (object.publishDate != null) {
      yield r'publishDate';
      yield serializers.serialize(
        object.publishDate,
        specifiedType: const FullType(Date),
      );
    }
    if (object.viewCount != null) {
      yield r'viewCount';
      yield serializers.serialize(
        object.viewCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.likeCount != null) {
      yield r'likeCount';
      yield serializers.serialize(
        object.likeCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.collectCount != null) {
      yield r'collectCount';
      yield serializers.serialize(
        object.collectCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DailyArticleResponse object, {
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
    required DailyArticleResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
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
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'difficultyDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.difficultyDesc = valueDes;
          break;
        case r'readTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.readTime = valueDes;
          break;
        case r'publishDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.publishDate = valueDes;
          break;
        case r'viewCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.viewCount = valueDes;
          break;
        case r'likeCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.likeCount = valueDes;
          break;
        case r'collectCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.collectCount = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DailyArticleResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyArticleResponseBuilder();
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
