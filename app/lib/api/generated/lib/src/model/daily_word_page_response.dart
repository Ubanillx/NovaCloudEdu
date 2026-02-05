//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/daily_word_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'daily_word_page_response.g.dart';

/// 每日单词分页响应
///
/// Properties:
/// * [records] - 单词列表
/// * [total] - 总记录数
/// * [pageNum] - 当前页码
/// * [pageSize] - 每页大小
/// * [totalPages] - 总页数
@BuiltValue()
abstract class DailyWordPageResponse
    implements Built<DailyWordPageResponse, DailyWordPageResponseBuilder> {
  /// 单词列表
  @BuiltValueField(wireName: r'records')
  BuiltList<DailyWordResponse>? get records;

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

  DailyWordPageResponse._();

  factory DailyWordPageResponse(
      [void updates(DailyWordPageResponseBuilder b)]) = _$DailyWordPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DailyWordPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DailyWordPageResponse> get serializer =>
      _$DailyWordPageResponseSerializer();
}

class _$DailyWordPageResponseSerializer
    implements PrimitiveSerializer<DailyWordPageResponse> {
  @override
  final Iterable<Type> types = const [
    DailyWordPageResponse,
    _$DailyWordPageResponse
  ];

  @override
  final String wireName = r'DailyWordPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DailyWordPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.records != null) {
      yield r'records';
      yield serializers.serialize(
        object.records,
        specifiedType: const FullType(BuiltList, [FullType(DailyWordResponse)]),
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
    DailyWordPageResponse object, {
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
    required DailyWordPageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(DailyWordResponse)]),
          ) as BuiltList<DailyWordResponse>;
          result.records.replace(valueDes);
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
  DailyWordPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DailyWordPageResponseBuilder();
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
