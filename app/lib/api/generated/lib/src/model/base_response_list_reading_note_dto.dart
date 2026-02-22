//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/reading_note_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_reading_note_dto.g.dart';

/// BaseResponseListReadingNoteDTO
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListReadingNoteDTO
    implements
        Built<BaseResponseListReadingNoteDTO,
            BaseResponseListReadingNoteDTOBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<ReadingNoteDTO>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListReadingNoteDTO._();

  factory BaseResponseListReadingNoteDTO(
          [void updates(BaseResponseListReadingNoteDTOBuilder b)]) =
      _$BaseResponseListReadingNoteDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListReadingNoteDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListReadingNoteDTO> get serializer =>
      _$BaseResponseListReadingNoteDTOSerializer();
}

class _$BaseResponseListReadingNoteDTOSerializer
    implements PrimitiveSerializer<BaseResponseListReadingNoteDTO> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListReadingNoteDTO,
    _$BaseResponseListReadingNoteDTO
  ];

  @override
  final String wireName = r'BaseResponseListReadingNoteDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListReadingNoteDTO object, {
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
        specifiedType: const FullType(BuiltList, [FullType(ReadingNoteDTO)]),
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
    BaseResponseListReadingNoteDTO object, {
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
    required BaseResponseListReadingNoteDTOBuilder result,
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
            specifiedType:
                const FullType(BuiltList, [FullType(ReadingNoteDTO)]),
          ) as BuiltList<ReadingNoteDTO>;
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
  BaseResponseListReadingNoteDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListReadingNoteDTOBuilder();
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
