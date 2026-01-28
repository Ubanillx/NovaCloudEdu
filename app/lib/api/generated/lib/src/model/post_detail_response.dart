//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'post_detail_response.g.dart';

/// PostDetailResponse
///
/// Properties:
/// * [id]
/// * [title]
/// * [content]
/// * [tags]
/// * [thumbNum]
/// * [favourNum]
/// * [commentNum]
/// * [userId]
/// * [ipAddress]
/// * [postType]
/// * [createTime]
/// * [updateTime]
/// * [hasThumb]
/// * [hasFavour]
@BuiltValue()
abstract class PostDetailResponse
    implements Built<PostDetailResponse, PostDetailResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  @BuiltValueField(wireName: r'thumbNum')
  int? get thumbNum;

  @BuiltValueField(wireName: r'favourNum')
  int? get favourNum;

  @BuiltValueField(wireName: r'commentNum')
  int? get commentNum;

  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'ipAddress')
  String? get ipAddress;

  @BuiltValueField(wireName: r'postType')
  String? get postType;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'hasThumb')
  bool? get hasThumb;

  @BuiltValueField(wireName: r'hasFavour')
  bool? get hasFavour;

  PostDetailResponse._();

  factory PostDetailResponse([void updates(PostDetailResponseBuilder b)]) =
      _$PostDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PostDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PostDetailResponse> get serializer =>
      _$PostDetailResponseSerializer();
}

class _$PostDetailResponseSerializer
    implements PrimitiveSerializer<PostDetailResponse> {
  @override
  final Iterable<Type> types = const [PostDetailResponse, _$PostDetailResponse];

  @override
  final String wireName = r'PostDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PostDetailResponse object, {
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
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.thumbNum != null) {
      yield r'thumbNum';
      yield serializers.serialize(
        object.thumbNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.favourNum != null) {
      yield r'favourNum';
      yield serializers.serialize(
        object.favourNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.commentNum != null) {
      yield r'commentNum';
      yield serializers.serialize(
        object.commentNum,
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
    if (object.ipAddress != null) {
      yield r'ipAddress';
      yield serializers.serialize(
        object.ipAddress,
        specifiedType: const FullType(String),
      );
    }
    if (object.postType != null) {
      yield r'postType';
      yield serializers.serialize(
        object.postType,
        specifiedType: const FullType(String),
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
    if (object.hasThumb != null) {
      yield r'hasThumb';
      yield serializers.serialize(
        object.hasThumb,
        specifiedType: const FullType(bool),
      );
    }
    if (object.hasFavour != null) {
      yield r'hasFavour';
      yield serializers.serialize(
        object.hasFavour,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PostDetailResponse object, {
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
    required PostDetailResponseBuilder result,
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
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'thumbNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.thumbNum = valueDes;
          break;
        case r'favourNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.favourNum = valueDes;
          break;
        case r'commentNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.commentNum = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'ipAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ipAddress = valueDes;
          break;
        case r'postType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.postType = valueDes;
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
        case r'hasThumb':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasThumb = valueDes;
          break;
        case r'hasFavour':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasFavour = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PostDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PostDetailResponseBuilder();
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
