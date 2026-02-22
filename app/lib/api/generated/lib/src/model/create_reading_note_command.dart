//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_reading_note_command.g.dart';

/// CreateReadingNoteCommand
///
/// Properties:
/// * [userId]
/// * [chapterId]
/// * [noteContent]
/// * [chapterIndex]
/// * [selectedText]
/// * [startPosition]
/// * [endPosition]
/// * [noteColor]
@BuiltValue()
abstract class CreateReadingNoteCommand
    implements
        Built<CreateReadingNoteCommand, CreateReadingNoteCommandBuilder> {
  @BuiltValueField(wireName: r'userId')
  int get userId;

  @BuiltValueField(wireName: r'chapterId')
  int get chapterId;

  @BuiltValueField(wireName: r'noteContent')
  String get noteContent;

  @BuiltValueField(wireName: r'chapterIndex')
  int? get chapterIndex;

  @BuiltValueField(wireName: r'selectedText')
  String? get selectedText;

  @BuiltValueField(wireName: r'startPosition')
  int? get startPosition;

  @BuiltValueField(wireName: r'endPosition')
  int? get endPosition;

  @BuiltValueField(wireName: r'noteColor')
  String? get noteColor;

  CreateReadingNoteCommand._();

  factory CreateReadingNoteCommand(
          [void updates(CreateReadingNoteCommandBuilder b)]) =
      _$CreateReadingNoteCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReadingNoteCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReadingNoteCommand> get serializer =>
      _$CreateReadingNoteCommandSerializer();
}

class _$CreateReadingNoteCommandSerializer
    implements PrimitiveSerializer<CreateReadingNoteCommand> {
  @override
  final Iterable<Type> types = const [
    CreateReadingNoteCommand,
    _$CreateReadingNoteCommand
  ];

  @override
  final String wireName = r'CreateReadingNoteCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReadingNoteCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'chapterId';
    yield serializers.serialize(
      object.chapterId,
      specifiedType: const FullType(int),
    );
    yield r'noteContent';
    yield serializers.serialize(
      object.noteContent,
      specifiedType: const FullType(String),
    );
    if (object.chapterIndex != null) {
      yield r'chapterIndex';
      yield serializers.serialize(
        object.chapterIndex,
        specifiedType: const FullType(int),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReadingNoteCommand object, {
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
    required CreateReadingNoteCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterId = valueDes;
          break;
        case r'noteContent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.noteContent = valueDes;
          break;
        case r'chapterIndex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterIndex = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReadingNoteCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReadingNoteCommandBuilder();
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
