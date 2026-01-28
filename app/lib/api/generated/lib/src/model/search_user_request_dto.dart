//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_user_request_dto.g.dart';

/// 搜索用户请求
///
/// Properties:
/// * [keyword] - 搜索关键词（用户名或账号）
/// * [pageNum] - 页码
/// * [pageSize] - 每页数量
@BuiltValue()
abstract class SearchUserRequestDTO
    implements Built<SearchUserRequestDTO, SearchUserRequestDTOBuilder> {
  /// 搜索关键词（用户名或账号）
  @BuiltValueField(wireName: r'keyword')
  String? get keyword;

  /// 页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页数量
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  SearchUserRequestDTO._();

  factory SearchUserRequestDTO([void updates(SearchUserRequestDTOBuilder b)]) =
      _$SearchUserRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchUserRequestDTOBuilder b) => b
    ..pageNum = 1
    ..pageSize = 10;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchUserRequestDTO> get serializer =>
      _$SearchUserRequestDTOSerializer();
}

class _$SearchUserRequestDTOSerializer
    implements PrimitiveSerializer<SearchUserRequestDTO> {
  @override
  final Iterable<Type> types = const [
    SearchUserRequestDTO,
    _$SearchUserRequestDTO
  ];

  @override
  final String wireName = r'SearchUserRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchUserRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.keyword != null) {
      yield r'keyword';
      yield serializers.serialize(
        object.keyword,
        specifiedType: const FullType(String),
      );
    }
    if (object.pageNum != null) {
      yield r'pageNum';
      yield serializers.serialize(
        object.pageNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageSize != null) {
      yield r'pageSize';
      yield serializers.serialize(
        object.pageSize,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchUserRequestDTO object, {
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
    required SearchUserRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'keyword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.keyword = valueDes;
          break;
        case r'pageNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageNum = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchUserRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchUserRequestDTOBuilder();
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
