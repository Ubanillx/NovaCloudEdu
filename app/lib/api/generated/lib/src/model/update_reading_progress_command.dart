//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_reading_progress_command.g.dart';

/// UpdateReadingProgressCommand
///
/// Properties:
/// * [userId]
/// * [bookId]
/// * [chapterIndex]
/// * [position]
@BuiltValue()
abstract class UpdateReadingProgressCommand
    implements
        Built<UpdateReadingProgressCommand,
            UpdateReadingProgressCommandBuilder> {
  @BuiltValueField(wireName: r'userId')
  int get userId;

  @BuiltValueField(wireName: r'bookId')
  int get bookId;

  @BuiltValueField(wireName: r'chapterIndex')
  int get chapterIndex;

  @BuiltValueField(wireName: r'position')
  int get position;

  UpdateReadingProgressCommand._();

  factory UpdateReadingProgressCommand(
          [void updates(UpdateReadingProgressCommandBuilder b)]) =
      _$UpdateReadingProgressCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateReadingProgressCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateReadingProgressCommand> get serializer =>
      _$UpdateReadingProgressCommandSerializer();
}

class _$UpdateReadingProgressCommandSerializer
    implements PrimitiveSerializer<UpdateReadingProgressCommand> {
  @override
  final Iterable<Type> types = const [
    UpdateReadingProgressCommand,
    _$UpdateReadingProgressCommand
  ];

  @override
  final String wireName = r'UpdateReadingProgressCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateReadingProgressCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'bookId';
    yield serializers.serialize(
      object.bookId,
      specifiedType: const FullType(int),
    );
    yield r'chapterIndex';
    yield serializers.serialize(
      object.chapterIndex,
      specifiedType: const FullType(int),
    );
    yield r'position';
    yield serializers.serialize(
      object.position,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateReadingProgressCommand object, {
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
    required UpdateReadingProgressCommandBuilder result,
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
        case r'bookId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bookId = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateReadingProgressCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateReadingProgressCommandBuilder();
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
