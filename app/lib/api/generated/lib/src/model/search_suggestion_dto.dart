//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_suggestion_dto.g.dart';

/// SearchSuggestionDTO
///
/// Properties:
/// * [text]
/// * [type]
/// * [id]
@BuiltValue()
abstract class SearchSuggestionDTO
    implements Built<SearchSuggestionDTO, SearchSuggestionDTOBuilder> {
  @BuiltValueField(wireName: r'text')
  String? get text;

  @BuiltValueField(wireName: r'type')
  String? get type;

  @BuiltValueField(wireName: r'id')
  int? get id;

  SearchSuggestionDTO._();

  factory SearchSuggestionDTO([void updates(SearchSuggestionDTOBuilder b)]) =
      _$SearchSuggestionDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchSuggestionDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchSuggestionDTO> get serializer =>
      _$SearchSuggestionDTOSerializer();
}

class _$SearchSuggestionDTOSerializer
    implements PrimitiveSerializer<SearchSuggestionDTO> {
  @override
  final Iterable<Type> types = const [
    SearchSuggestionDTO,
    _$SearchSuggestionDTO
  ];

  @override
  final String wireName = r'SearchSuggestionDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchSuggestionDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.text != null) {
      yield r'text';
      yield serializers.serialize(
        object.text,
        specifiedType: const FullType(String),
      );
    }
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchSuggestionDTO object, {
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
    required SearchSuggestionDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.text = valueDes;
          break;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchSuggestionDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchSuggestionDTOBuilder();
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
