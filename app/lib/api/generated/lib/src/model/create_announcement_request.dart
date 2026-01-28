//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_announcement_request.g.dart';

/// CreateAnnouncementRequest
///
/// Properties:
/// * [title]
/// * [content]
/// * [sort]
/// * [startTime]
/// * [endTime]
/// * [coverImage]
@BuiltValue()
abstract class CreateAnnouncementRequest
    implements
        Built<CreateAnnouncementRequest, CreateAnnouncementRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'sort')
  int? get sort;

  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  @BuiltValueField(wireName: r'endTime')
  DateTime? get endTime;

  @BuiltValueField(wireName: r'coverImage')
  String? get coverImage;

  CreateAnnouncementRequest._();

  factory CreateAnnouncementRequest(
          [void updates(CreateAnnouncementRequestBuilder b)]) =
      _$CreateAnnouncementRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAnnouncementRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAnnouncementRequest> get serializer =>
      _$CreateAnnouncementRequestSerializer();
}

class _$CreateAnnouncementRequestSerializer
    implements PrimitiveSerializer<CreateAnnouncementRequest> {
  @override
  final Iterable<Type> types = const [
    CreateAnnouncementRequest,
    _$CreateAnnouncementRequest
  ];

  @override
  final String wireName = r'CreateAnnouncementRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAnnouncementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    if (object.sort != null) {
      yield r'sort';
      yield serializers.serialize(
        object.sort,
        specifiedType: const FullType(int),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.endTime != null) {
      yield r'endTime';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.coverImage != null) {
      yield r'coverImage';
      yield serializers.serialize(
        object.coverImage,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAnnouncementRequest object, {
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
    required CreateAnnouncementRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'sort':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sort = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endTime = valueDes;
          break;
        case r'coverImage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverImage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAnnouncementRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAnnouncementRequestBuilder();
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
