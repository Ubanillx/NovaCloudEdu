//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/class_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'page_response_class_response.g.dart';

/// 分页响应
///
/// Properties:
/// * [list] - 数据列表
/// * [total] - 总记录数
/// * [pageNum] - 当前页码
/// * [pageSize] - 每页大小
/// * [totalPages] - 总页数
@BuiltValue()
abstract class PageResponseClassResponse
    implements
        Built<PageResponseClassResponse, PageResponseClassResponseBuilder> {
  /// 数据列表
  @BuiltValueField(wireName: r'list')
  BuiltList<ClassResponse>? get list;

  /// 总记录数
  @BuiltValueField(wireName: r'total')
  int? get total;

  /// 当前页码
  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  /// 每页大小
  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  /// 总页数
  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  PageResponseClassResponse._();

  factory PageResponseClassResponse(
          [void updates(PageResponseClassResponseBuilder b)]) =
      _$PageResponseClassResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PageResponseClassResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PageResponseClassResponse> get serializer =>
      _$PageResponseClassResponseSerializer();
}

class _$PageResponseClassResponseSerializer
    implements PrimitiveSerializer<PageResponseClassResponse> {
  @override
  final Iterable<Type> types = const [
    PageResponseClassResponse,
    _$PageResponseClassResponse
  ];

  @override
  final String wireName = r'PageResponseClassResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PageResponseClassResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.list != null) {
      yield r'list';
      yield serializers.serialize(
        object.list,
        specifiedType: const FullType(BuiltList, [FullType(ClassResponse)]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
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
    if (object.totalPages != null) {
      yield r'totalPages';
      yield serializers.serialize(
        object.totalPages,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PageResponseClassResponse object, {
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
    required PageResponseClassResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'list':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ClassResponse)]),
          ) as BuiltList<ClassResponse>;
          result.list.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
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
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPages = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PageResponseClassResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PageResponseClassResponseBuilder();
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
