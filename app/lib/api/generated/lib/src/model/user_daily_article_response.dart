//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/daily_article_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_daily_article_response.g.dart';

/// 用户每日文章响应
///
/// Properties:
/// * [id] - ID
/// * [userId] - 用户ID
/// * [articleId] - 文章ID
/// * [read] - 是否阅读
/// * [liked] - 是否点赞
/// * [collected] - 是否收藏
/// * [commentContent] - 评论内容
/// * [commentTime] - 评论时间
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
/// * [article]
@BuiltValue()
abstract class UserDailyArticleResponse
    implements
        Built<UserDailyArticleResponse, UserDailyArticleResponseBuilder> {
  /// ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 文章ID
  @BuiltValueField(wireName: r'articleId')
  int? get articleId;

  /// 是否阅读
  @BuiltValueField(wireName: r'read')
  bool? get read;

  /// 是否点赞
  @BuiltValueField(wireName: r'liked')
  bool? get liked;

  /// 是否收藏
  @BuiltValueField(wireName: r'collected')
  bool? get collected;

  /// 评论内容
  @BuiltValueField(wireName: r'commentContent')
  String? get commentContent;

  /// 评论时间
  @BuiltValueField(wireName: r'commentTime')
  DateTime? get commentTime;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'article')
  DailyArticleResponse? get article;

  UserDailyArticleResponse._();

  factory UserDailyArticleResponse(
          [void updates(UserDailyArticleResponseBuilder b)]) =
      _$UserDailyArticleResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserDailyArticleResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserDailyArticleResponse> get serializer =>
      _$UserDailyArticleResponseSerializer();
}

class _$UserDailyArticleResponseSerializer
    implements PrimitiveSerializer<UserDailyArticleResponse> {
  @override
  final Iterable<Type> types = const [
    UserDailyArticleResponse,
    _$UserDailyArticleResponse
  ];

  @override
  final String wireName = r'UserDailyArticleResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserDailyArticleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.articleId != null) {
      yield r'articleId';
      yield serializers.serialize(
        object.articleId,
        specifiedType: const FullType(int),
      );
    }
    if (object.read != null) {
      yield r'read';
      yield serializers.serialize(
        object.read,
        specifiedType: const FullType(bool),
      );
    }
    if (object.liked != null) {
      yield r'liked';
      yield serializers.serialize(
        object.liked,
        specifiedType: const FullType(bool),
      );
    }
    if (object.collected != null) {
      yield r'collected';
      yield serializers.serialize(
        object.collected,
        specifiedType: const FullType(bool),
      );
    }
    if (object.commentContent != null) {
      yield r'commentContent';
      yield serializers.serialize(
        object.commentContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.commentTime != null) {
      yield r'commentTime';
      yield serializers.serialize(
        object.commentTime,
        specifiedType: const FullType(DateTime),
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
    if (object.article != null) {
      yield r'article';
      yield serializers.serialize(
        object.article,
        specifiedType: const FullType(DailyArticleResponse),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserDailyArticleResponse object, {
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
    required UserDailyArticleResponseBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'articleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.articleId = valueDes;
          break;
        case r'read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.read = valueDes;
          break;
        case r'liked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.liked = valueDes;
          break;
        case r'collected':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.collected = valueDes;
          break;
        case r'commentContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.commentContent = valueDes;
          break;
        case r'commentTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.commentTime = valueDes;
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
        case r'article':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DailyArticleResponse),
          ) as DailyArticleResponse;
          result.article.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserDailyArticleResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserDailyArticleResponseBuilder();
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
