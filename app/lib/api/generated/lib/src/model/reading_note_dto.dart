//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reading_note_dto.g.dart';

/// ReadingNoteDTO
///
/// Properties:
/// * [id]
/// * [userId]
/// * [bookId]
/// * [chapterId]
/// * [chapterIndex]
/// * [noteContent]
/// * [selectedText]
/// * [startPosition]
/// * [endPosition]
/// * [noteColor]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class ReadingNoteDTO
    implements Built<ReadingNoteDTO, ReadingNoteDTOBuilder> {
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

  @BuiltValueField(wireName: r'noteContent')
  String? get noteContent;

  @BuiltValueField(wireName: r'selectedText')
  String? get selectedText;

  @BuiltValueField(wireName: r'startPosition')
  int? get startPosition;

  @BuiltValueField(wireName: r'endPosition')
  int? get endPosition;

  @BuiltValueField(wireName: r'noteColor')
  String? get noteColor;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  ReadingNoteDTO._();

  factory ReadingNoteDTO([void updates(ReadingNoteDTOBuilder b)]) =
      _$ReadingNoteDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReadingNoteDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReadingNoteDTO> get serializer =>
      _$ReadingNoteDTOSerializer();
}

class _$ReadingNoteDTOSerializer
    implements PrimitiveSerializer<ReadingNoteDTO> {
  @override
  final Iterable<Type> types = const [ReadingNoteDTO, _$ReadingNoteDTO];

  @override
  final String wireName = r'ReadingNoteDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReadingNoteDTO object, {
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
    if (object.noteContent != null) {
      yield r'noteContent';
      yield serializers.serialize(
        object.noteContent,
        specifiedType: const FullType(String),
      );
    }
    if (object.selectedText != null) {
      yield r'selectedText';
      yield serializers.serialize(
        object.selectedText,
        specifiedType: const FullType(String),
      );
    }
    if (object.startPosition != null) {
      yield r'startPosition';
      yield serializers.serialize(
        object.startPosition,
        specifiedType: const FullType(int),
      );
    }
    if (object.endPosition != null) {
      yield r'endPosition';
      yield serializers.serialize(
        object.endPosition,
        specifiedType: const FullType(int),
      );
    }
    if (object.noteColor != null) {
      yield r'noteColor';
      yield serializers.serialize(
        object.noteColor,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ReadingNoteDTO object, {
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
    required ReadingNoteDTOBuilder result,
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
        case r'noteContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.noteContent = valueDes;
          break;
        case r'selectedText':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.selectedText = valueDes;
          break;
        case r'startPosition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.startPosition = valueDes;
          break;
        case r'endPosition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.endPosition = valueDes;
          break;
        case r'noteColor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.noteColor = valueDes;
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
  ReadingNoteDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReadingNoteDTOBuilder();
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
