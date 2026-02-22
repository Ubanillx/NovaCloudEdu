//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/reading_bookmark_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_reading_bookmark_dto.g.dart';

/// BaseResponseReadingBookmarkDTO
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseReadingBookmarkDTO
    implements
        Built<BaseResponseReadingBookmarkDTO,
            BaseResponseReadingBookmarkDTOBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  ReadingBookmarkDTO? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseReadingBookmarkDTO._();

  factory BaseResponseReadingBookmarkDTO(
          [void updates(BaseResponseReadingBookmarkDTOBuilder b)]) =
      _$BaseResponseReadingBookmarkDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseReadingBookmarkDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseReadingBookmarkDTO> get serializer =>
      _$BaseResponseReadingBookmarkDTOSerializer();
}

class _$BaseResponseReadingBookmarkDTOSerializer
    implements PrimitiveSerializer<BaseResponseReadingBookmarkDTO> {
  @override
  final Iterable<Type> types = const [
    BaseResponseReadingBookmarkDTO,
    _$BaseResponseReadingBookmarkDTO
  ];

  @override
  final String wireName = r'BaseResponseReadingBookmarkDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseReadingBookmarkDTO object, {
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
        specifiedType: const FullType(ReadingBookmarkDTO),
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
    BaseResponseReadingBookmarkDTO object, {
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
    required BaseResponseReadingBookmarkDTOBuilder result,
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
            specifiedType: const FullType(ReadingBookmarkDTO),
          ) as ReadingBookmarkDTO;
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
  BaseResponseReadingBookmarkDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseReadingBookmarkDTOBuilder();
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
