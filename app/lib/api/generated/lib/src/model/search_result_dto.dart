//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_result_dto.g.dart';

/// SearchResultDTO
///
/// Properties:
/// * [type]
/// * [id]
/// * [title]
/// * [content]
/// * [score]
/// * [highlights]
/// * [author]
/// * [fileType]
/// * [coverUrl]
/// * [totalChapters]
/// * [bookId]
/// * [bookTitle]
/// * [chapterIndex]
/// * [tags]
/// * [postType]
/// * [thumbNum]
/// * [favourNum]
/// * [commentNum]
/// * [createTime]
@BuiltValue()
abstract class SearchResultDTO
    implements Built<SearchResultDTO, SearchResultDTOBuilder> {
  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'content')
  String? get content;

  @BuiltValueField(wireName: r'score')
  double? get score;

  @BuiltValueField(wireName: r'highlights')
  BuiltMap<String, BuiltList<String>>? get highlights;

  @BuiltValueField(wireName: r'author')
  String? get author;

  @BuiltValueField(wireName: r'fileType')
  String? get fileType;

  @BuiltValueField(wireName: r'coverUrl')
  String? get coverUrl;

  @BuiltValueField(wireName: r'totalChapters')
  int? get totalChapters;

  @BuiltValueField(wireName: r'bookId')
  int? get bookId;

  @BuiltValueField(wireName: r'bookTitle')
  String? get bookTitle;

  @BuiltValueField(wireName: r'chapterIndex')
  int? get chapterIndex;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  @BuiltValueField(wireName: r'postType')
  String? get postType;

  @BuiltValueField(wireName: r'thumbNum')
  int? get thumbNum;

  @BuiltValueField(wireName: r'favourNum')
  int? get favourNum;

  @BuiltValueField(wireName: r'commentNum')
  int? get commentNum;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  SearchResultDTO._();

  factory SearchResultDTO([void updates(SearchResultDTOBuilder b)]) =
      _$SearchResultDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchResultDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchResultDTO> get serializer =>
      _$SearchResultDTOSerializer();
}

class _$SearchResultDTOSerializer
    implements PrimitiveSerializer<SearchResultDTO> {
  @override
  final Iterable<Type> types = const [SearchResultDTO, _$SearchResultDTO];

  @override
  final String wireName = r'SearchResultDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchResultDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
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
    if (object.score != null) {
      yield r'score';
      yield serializers.serialize(
        object.score,
        specifiedType: const FullType(double),
      );
    }
    if (object.highlights != null) {
      yield r'highlights';
      yield serializers.serialize(
        object.highlights,
        specifiedType: const FullType(BuiltMap, [
          FullType(String),
          FullType(BuiltList, [FullType(String)])
        ]),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileType != null) {
      yield r'fileType';
      yield serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      );
    }
    if (object.coverUrl != null) {
      yield r'coverUrl';
      yield serializers.serialize(
        object.coverUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalChapters != null) {
      yield r'totalChapters';
      yield serializers.serialize(
        object.totalChapters,
        specifiedType: const FullType(int),
      );
    }
    if (object.bookId != null) {
      yield r'bookId';
      yield serializers.serialize(
        object.bookId,
        specifiedType: const FullType(int),
      );
    }
    if (object.bookTitle != null) {
      yield r'bookTitle';
      yield serializers.serialize(
        object.bookTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.chapterIndex != null) {
      yield r'chapterIndex';
      yield serializers.serialize(
        object.chapterIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.postType != null) {
      yield r'postType';
      yield serializers.serialize(
        object.postType,
        specifiedType: const FullType(String),
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
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchResultDTO object, {
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
    required SearchResultDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
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
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.score = valueDes;
          break;
        case r'highlights':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [
              FullType(String),
              FullType(BuiltList, [FullType(String)])
            ]),
          ) as BuiltMap<String, BuiltList<String>>;
          result.highlights.replace(valueDes);
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        case r'fileType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileType = valueDes;
          break;
        case r'coverUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverUrl = valueDes;
          break;
        case r'totalChapters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalChapters = valueDes;
          break;
        case r'bookId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bookId = valueDes;
          break;
        case r'bookTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bookTitle = valueDes;
          break;
        case r'chapterIndex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterIndex = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'postType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.postType = valueDes;
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
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchResultDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchResultDTOBuilder();
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
