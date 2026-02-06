//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'article_chat_request.g.dart';

/// 文章对话请求
///
/// Properties:
/// * [articleId] - 文章ID
/// * [message] - 用户消息
/// * [history] - 对话历史
@BuiltValue()
abstract class ArticleChatRequest
    implements Built<ArticleChatRequest, ArticleChatRequestBuilder> {
  /// 文章ID
  @BuiltValueField(wireName: r'articleId')
  int get articleId;

  /// 用户消息
  @BuiltValueField(wireName: r'message')
  String get message;

  /// 对话历史
  @BuiltValueField(wireName: r'history')
  BuiltList<BuiltMap<String, String>>? get history;

  ArticleChatRequest._();

  factory ArticleChatRequest([void updates(ArticleChatRequestBuilder b)]) =
      _$ArticleChatRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ArticleChatRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ArticleChatRequest> get serializer =>
      _$ArticleChatRequestSerializer();
}

class _$ArticleChatRequestSerializer
    implements PrimitiveSerializer<ArticleChatRequest> {
  @override
  final Iterable<Type> types = const [ArticleChatRequest, _$ArticleChatRequest];

  @override
  final String wireName = r'ArticleChatRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ArticleChatRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'articleId';
    yield serializers.serialize(
      object.articleId,
      specifiedType: const FullType(int),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.history != null) {
      yield r'history';
      yield serializers.serialize(
        object.history,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(String)])
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ArticleChatRequest object, {
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
    required ArticleChatRequestBuilder result,
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
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'history':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(String)])
            ]),
          ) as BuiltList<BuiltMap<String, String>>;
          result.history.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ArticleChatRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ArticleChatRequestBuilder();
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
