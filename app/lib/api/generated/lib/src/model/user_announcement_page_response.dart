//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/announcement_list_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_announcement_page_response.g.dart';

/// UserAnnouncementPageResponse
///
/// Properties:
/// * [records]
/// * [total]
/// * [pageNum]
/// * [pageSize]
/// * [totalPages]
/// * [unreadCount]
@BuiltValue()
abstract class UserAnnouncementPageResponse
    implements
        Built<UserAnnouncementPageResponse,
            UserAnnouncementPageResponseBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<AnnouncementListResponse>? get records;

  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  @BuiltValueField(wireName: r'unreadCount')
  int? get unreadCount;

  UserAnnouncementPageResponse._();

  factory UserAnnouncementPageResponse(
          [void updates(UserAnnouncementPageResponseBuilder b)]) =
      _$UserAnnouncementPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserAnnouncementPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserAnnouncementPageResponse> get serializer =>
      _$UserAnnouncementPageResponseSerializer();
}

class _$UserAnnouncementPageResponseSerializer
    implements PrimitiveSerializer<UserAnnouncementPageResponse> {
  @override
  final Iterable<Type> types = const [
    UserAnnouncementPageResponse,
    _$UserAnnouncementPageResponse
  ];

  @override
  final String wireName = r'UserAnnouncementPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserAnnouncementPageResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.records != null) {
      yield r'records';
      yield serializers.serialize(
        object.records,
        specifiedType:
            const FullType(BuiltList, [FullType(AnnouncementListResponse)]),
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
    if (object.unreadCount != null) {
      yield r'unreadCount';
      yield serializers.serialize(
        object.unreadCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserAnnouncementPageResponse object, {
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
    required UserAnnouncementPageResponseBuilder result,
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
                const FullType(BuiltList, [FullType(AnnouncementListResponse)]),
          ) as BuiltList<AnnouncementListResponse>;
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
        case r'unreadCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserAnnouncementPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserAnnouncementPageResponseBuilder();
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
