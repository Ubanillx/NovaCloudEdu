//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/user_announcement_page_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_user_announcement_page_response.g.dart';

/// BaseResponseUserAnnouncementPageResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseUserAnnouncementPageResponse
    implements
        Built<BaseResponseUserAnnouncementPageResponse,
            BaseResponseUserAnnouncementPageResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  UserAnnouncementPageResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseUserAnnouncementPageResponse._();

  factory BaseResponseUserAnnouncementPageResponse(
          [void updates(BaseResponseUserAnnouncementPageResponseBuilder b)]) =
      _$BaseResponseUserAnnouncementPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseUserAnnouncementPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseUserAnnouncementPageResponse> get serializer =>
      _$BaseResponseUserAnnouncementPageResponseSerializer();
}

class _$BaseResponseUserAnnouncementPageResponseSerializer
    implements PrimitiveSerializer<BaseResponseUserAnnouncementPageResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseUserAnnouncementPageResponse,
    _$BaseResponseUserAnnouncementPageResponse
  ];

  @override
  final String wireName = r'BaseResponseUserAnnouncementPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseUserAnnouncementPageResponse object, {
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
        specifiedType: const FullType(UserAnnouncementPageResponse),
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
    BaseResponseUserAnnouncementPageResponse object, {
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
    required BaseResponseUserAnnouncementPageResponseBuilder result,
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
            specifiedType: const FullType(UserAnnouncementPageResponse),
          ) as UserAnnouncementPageResponse;
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
  BaseResponseUserAnnouncementPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseUserAnnouncementPageResponseBuilder();
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
