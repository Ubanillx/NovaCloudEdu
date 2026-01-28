//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_shelf_dto.g.dart';

/// UserShelfDTO
///
/// Properties:
/// * [userId]
/// * [bookId]
/// * [bookTitle]
/// * [bookAuthor]
/// * [bookCoverUrl]
/// * [lastChapterIndex]
/// * [lastPosition]
/// * [readingProgress]
/// * [addedTime]
/// * [lastReadTime]
@BuiltValue()
abstract class UserShelfDTO
    implements Built<UserShelfDTO, UserShelfDTOBuilder> {
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'bookId')
  int? get bookId;

  @BuiltValueField(wireName: r'bookTitle')
  String? get bookTitle;

  @BuiltValueField(wireName: r'bookAuthor')
  String? get bookAuthor;

  @BuiltValueField(wireName: r'bookCoverUrl')
  String? get bookCoverUrl;

  @BuiltValueField(wireName: r'lastChapterIndex')
  int? get lastChapterIndex;

  @BuiltValueField(wireName: r'lastPosition')
  int? get lastPosition;

  @BuiltValueField(wireName: r'readingProgress')
  num? get readingProgress;

  @BuiltValueField(wireName: r'addedTime')
  DateTime? get addedTime;

  @BuiltValueField(wireName: r'lastReadTime')
  DateTime? get lastReadTime;

  UserShelfDTO._();

  factory UserShelfDTO([void updates(UserShelfDTOBuilder b)]) = _$UserShelfDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserShelfDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserShelfDTO> get serializer => _$UserShelfDTOSerializer();
}

class _$UserShelfDTOSerializer implements PrimitiveSerializer<UserShelfDTO> {
  @override
  final Iterable<Type> types = const [UserShelfDTO, _$UserShelfDTO];

  @override
  final String wireName = r'UserShelfDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserShelfDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.bookId != null) {
      yield r'bookId';
      yield serializers.serialize(
        object.bookId,
        specifiedType: const FullType(int),
      );
    }
    if (object.bookTitle != null) {
      yield r'bookTitle';
      yield serializers.serialize(
        object.bookTitle,
        specifiedType: const FullType(String),
      );
    }
    if (object.bookAuthor != null) {
      yield r'bookAuthor';
      yield serializers.serialize(
        object.bookAuthor,
        specifiedType: const FullType(String),
      );
    }
    if (object.bookCoverUrl != null) {
      yield r'bookCoverUrl';
      yield serializers.serialize(
        object.bookCoverUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastChapterIndex != null) {
      yield r'lastChapterIndex';
      yield serializers.serialize(
        object.lastChapterIndex,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastPosition != null) {
      yield r'lastPosition';
      yield serializers.serialize(
        object.lastPosition,
        specifiedType: const FullType(int),
      );
    }
    if (object.readingProgress != null) {
      yield r'readingProgress';
      yield serializers.serialize(
        object.readingProgress,
        specifiedType: const FullType(num),
      );
    }
    if (object.addedTime != null) {
      yield r'addedTime';
      yield serializers.serialize(
        object.addedTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.lastReadTime != null) {
      yield r'lastReadTime';
      yield serializers.serialize(
        object.lastReadTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserShelfDTO object, {
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
    required UserShelfDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'bookId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.bookId = valueDes;
          break;
        case r'bookTitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bookTitle = valueDes;
          break;
        case r'bookAuthor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bookAuthor = valueDes;
          break;
        case r'bookCoverUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.bookCoverUrl = valueDes;
          break;
        case r'lastChapterIndex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastChapterIndex = valueDes;
          break;
        case r'lastPosition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPosition = valueDes;
          break;
        case r'readingProgress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.readingProgress = valueDes;
          break;
        case r'addedTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.addedTime = valueDes;
          break;
        case r'lastReadTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastReadTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserShelfDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserShelfDTOBuilder();
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
