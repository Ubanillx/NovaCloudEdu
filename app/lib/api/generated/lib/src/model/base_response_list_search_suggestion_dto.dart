//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/search_suggestion_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_search_suggestion_dto.g.dart';

/// BaseResponseListSearchSuggestionDTO
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListSearchSuggestionDTO
    implements
        Built<BaseResponseListSearchSuggestionDTO,
            BaseResponseListSearchSuggestionDTOBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<SearchSuggestionDTO>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListSearchSuggestionDTO._();

  factory BaseResponseListSearchSuggestionDTO(
          [void updates(BaseResponseListSearchSuggestionDTOBuilder b)]) =
      _$BaseResponseListSearchSuggestionDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListSearchSuggestionDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListSearchSuggestionDTO> get serializer =>
      _$BaseResponseListSearchSuggestionDTOSerializer();
}

class _$BaseResponseListSearchSuggestionDTOSerializer
    implements PrimitiveSerializer<BaseResponseListSearchSuggestionDTO> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListSearchSuggestionDTO,
    _$BaseResponseListSearchSuggestionDTO
  ];

  @override
  final String wireName = r'BaseResponseListSearchSuggestionDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListSearchSuggestionDTO object, {
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
        specifiedType:
            const FullType(BuiltList, [FullType(SearchSuggestionDTO)]),
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
    BaseResponseListSearchSuggestionDTO object, {
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
    required BaseResponseListSearchSuggestionDTOBuilder result,
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
                const FullType(BuiltList, [FullType(SearchSuggestionDTO)]),
          ) as BuiltList<SearchSuggestionDTO>;
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
  BaseResponseListSearchSuggestionDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListSearchSuggestionDTOBuilder();
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
