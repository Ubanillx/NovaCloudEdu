//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'book_dto.g.dart';

/// BookDTO
///
/// Properties:
/// * [id]
/// * [title]
/// * [author]
/// * [coverUrl]
/// * [fileType]
/// * [status]
/// * [totalChapters]
/// * [wordCount]
/// * [fileSize]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class BookDTO implements Built<BookDTO, BookDTOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'author')
  String? get author;

  @BuiltValueField(wireName: r'coverUrl')
  String? get coverUrl;

  @BuiltValueField(wireName: r'fileType')
  String? get fileType;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'totalChapters')
  int? get totalChapters;

  @BuiltValueField(wireName: r'wordCount')
  int? get wordCount;

  @BuiltValueField(wireName: r'fileSize')
  int? get fileSize;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  BookDTO._();

  factory BookDTO([void updates(BookDTOBuilder b)]) = _$BookDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BookDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BookDTO> get serializer => _$BookDTOSerializer();
}

class _$BookDTOSerializer implements PrimitiveSerializer<BookDTO> {
  @override
  final Iterable<Type> types = const [BookDTO, _$BookDTO];

  @override
  final String wireName = r'BookDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BookDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
    if (object.coverUrl != null) {
      yield r'coverUrl';
      yield serializers.serialize(
        object.coverUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileType != null) {
      yield r'fileType';
      yield serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalChapters != null) {
      yield r'totalChapters';
      yield serializers.serialize(
        object.totalChapters,
        specifiedType: const FullType(int),
      );
    }
    if (object.wordCount != null) {
      yield r'wordCount';
      yield serializers.serialize(
        object.wordCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.fileSize != null) {
      yield r'fileSize';
      yield serializers.serialize(
        object.fileSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BookDTO object, {
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
    required BookDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        case r'coverUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverUrl = valueDes;
          break;
        case r'fileType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'totalChapters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalChapters = valueDes;
          break;
        case r'wordCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wordCount = valueDes;
          break;
        case r'fileSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fileSize = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BookDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BookDTOBuilder();
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
