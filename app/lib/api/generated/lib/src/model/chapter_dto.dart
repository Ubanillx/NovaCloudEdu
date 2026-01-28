//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chapter_dto.g.dart';

/// ChapterDTO
///
/// Properties:
/// * [id]
/// * [bookId]
/// * [title]
/// * [chapterIndex]
/// * [wordCount]
@BuiltValue()
abstract class ChapterDTO implements Built<ChapterDTO, ChapterDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'bookId')
  int? get bookId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'chapterIndex')
  int? get chapterIndex;

  @BuiltValueField(wireName: r'wordCount')
  int? get wordCount;

  ChapterDTO._();

  factory ChapterDTO([void updates(ChapterDTOBuilder b)]) = _$ChapterDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChapterDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChapterDTO> get serializer => _$ChapterDTOSerializer();
}

class _$ChapterDTOSerializer implements PrimitiveSerializer<ChapterDTO> {
  @override
  final Iterable<Type> types = const [ChapterDTO, _$ChapterDTO];

  @override
  final String wireName = r'ChapterDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChapterDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
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
    if (object.wordCount != null) {
      yield r'wordCount';
      yield serializers.serialize(
        object.wordCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChapterDTO object, {
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
    required ChapterDTOBuilder result,
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
        case r'bookId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bookId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'chapterIndex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterIndex = valueDes;
          break;
        case r'wordCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wordCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChapterDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChapterDTOBuilder();
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
