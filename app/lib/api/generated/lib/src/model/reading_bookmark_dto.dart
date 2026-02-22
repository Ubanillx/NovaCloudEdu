//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reading_bookmark_dto.g.dart';

/// ReadingBookmarkDTO
///
/// Properties:
/// * [id]
/// * [userId]
/// * [bookId]
/// * [chapterId]
/// * [chapterIndex]
/// * [position]
/// * [bookmarkTitle]
/// * [note]
/// * [createTime]
@BuiltValue()
abstract class ReadingBookmarkDTO
    implements Built<ReadingBookmarkDTO, ReadingBookmarkDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'bookId')
  int? get bookId;

  @BuiltValueField(wireName: r'chapterId')
  int? get chapterId;

  @BuiltValueField(wireName: r'chapterIndex')
  int? get chapterIndex;

  @BuiltValueField(wireName: r'position')
  int? get position;

  @BuiltValueField(wireName: r'bookmarkTitle')
  String? get bookmarkTitle;

  @BuiltValueField(wireName: r'note')
  String? get note;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  ReadingBookmarkDTO._();

  factory ReadingBookmarkDTO([void updates(ReadingBookmarkDTOBuilder b)]) =
      _$ReadingBookmarkDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadingBookmarkDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadingBookmarkDTO> get serializer =>
      _$ReadingBookmarkDTOSerializer();
}

class _$ReadingBookmarkDTOSerializer
    implements PrimitiveSerializer<ReadingBookmarkDTO> {
  @override
  final Iterable<Type> types = const [ReadingBookmarkDTO, _$ReadingBookmarkDTO];

  @override
  final String wireName = r'ReadingBookmarkDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadingBookmarkDTO object, {
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
    if (object.bookId != null) {
      yield r'bookId';
      yield serializers.serialize(
        object.bookId,
        specifiedType: const FullType(int),
      );
    }
    if (object.chapterId != null) {
      yield r'chapterId';
      yield serializers.serialize(
        object.chapterId,
        specifiedType: const FullType(int),
      );
    }
    if (object.chapterIndex != null) {
      yield r'chapterIndex';
      yield serializers.serialize(
        object.chapterIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.position != null) {
      yield r'position';
      yield serializers.serialize(
        object.position,
        specifiedType: const FullType(int),
      );
    }
    if (object.bookmarkTitle != null) {
      yield r'bookmarkTitle';
      yield serializers.serialize(
        object.bookmarkTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadingBookmarkDTO object, {
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
    required ReadingBookmarkDTOBuilder result,
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
        case r'bookId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bookId = valueDes;
          break;
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterId = valueDes;
          break;
        case r'chapterIndex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterIndex = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.position = valueDes;
          break;
        case r'bookmarkTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bookmarkTitle = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.note = valueDes;
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
  ReadingBookmarkDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadingBookmarkDTOBuilder();
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
