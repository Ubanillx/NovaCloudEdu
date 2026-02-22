//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/group_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_group_page_response.g.dart';

/// AdminGroupPageResponse
///
/// Properties:
/// * [list]
/// * [total]
/// * [pageNum]
/// * [pageSize]
/// * [totalPages]
@BuiltValue()
abstract class AdminGroupPageResponse
    implements Built<AdminGroupPageResponse, AdminGroupPageResponseBuilder> {
  @BuiltValueField(wireName: r'list')
  BuiltList<GroupResponse>? get list;

  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  AdminGroupPageResponse._();

  factory AdminGroupPageResponse(
          [void updates(AdminGroupPageResponseBuilder b)]) =
      _$AdminGroupPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminGroupPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminGroupPageResponse> get serializer =>
      _$AdminGroupPageResponseSerializer();
}

class _$AdminGroupPageResponseSerializer
    implements PrimitiveSerializer<AdminGroupPageResponse> {
  @override
  final Iterable<Type> types = const [
    AdminGroupPageResponse,
    _$AdminGroupPageResponse
  ];

  @override
  final String wireName = r'AdminGroupPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminGroupPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.list != null) {
      yield r'list';
      yield serializers.serialize(
        object.list,
        specifiedType: const FullType(BuiltList, [FullType(GroupResponse)]),
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
    AdminGroupPageResponse object, {
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
    required AdminGroupPageResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'list':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GroupResponse)]),
          ) as BuiltList<GroupResponse>;
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
  AdminGroupPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminGroupPageResponseBuilder();
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
