//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/reading_note_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_reading_note_dto.g.dart';

/// BaseResponseReadingNoteDTO
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseReadingNoteDTO
    implements
        Built<BaseResponseReadingNoteDTO, BaseResponseReadingNoteDTOBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  ReadingNoteDTO? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseReadingNoteDTO._();

  factory BaseResponseReadingNoteDTO(
          [void updates(BaseResponseReadingNoteDTOBuilder b)]) =
      _$BaseResponseReadingNoteDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseReadingNoteDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseReadingNoteDTO> get serializer =>
      _$BaseResponseReadingNoteDTOSerializer();
}

class _$BaseResponseReadingNoteDTOSerializer
    implements PrimitiveSerializer<BaseResponseReadingNoteDTO> {
  @override
  final Iterable<Type> types = const [
    BaseResponseReadingNoteDTO,
    _$BaseResponseReadingNoteDTO
  ];

  @override
  final String wireName = r'BaseResponseReadingNoteDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseReadingNoteDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(ReadingNoteDTO),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseReadingNoteDTO object, {
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
    required BaseResponseReadingNoteDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ReadingNoteDTO),
          ) as ReadingNoteDTO;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseReadingNoteDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseReadingNoteDTOBuilder();
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
