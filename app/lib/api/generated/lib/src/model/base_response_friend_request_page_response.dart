//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/friend_request_page_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_friend_request_page_response.g.dart';

/// BaseResponseFriendRequestPageResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseFriendRequestPageResponse
    implements
        Built<BaseResponseFriendRequestPageResponse,
            BaseResponseFriendRequestPageResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  FriendRequestPageResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseFriendRequestPageResponse._();

  factory BaseResponseFriendRequestPageResponse(
          [void updates(BaseResponseFriendRequestPageResponseBuilder b)]) =
      _$BaseResponseFriendRequestPageResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseFriendRequestPageResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseFriendRequestPageResponse> get serializer =>
      _$BaseResponseFriendRequestPageResponseSerializer();
}

class _$BaseResponseFriendRequestPageResponseSerializer
    implements PrimitiveSerializer<BaseResponseFriendRequestPageResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseFriendRequestPageResponse,
    _$BaseResponseFriendRequestPageResponse
  ];

  @override
  final String wireName = r'BaseResponseFriendRequestPageResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseFriendRequestPageResponse object, {
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
        specifiedType: const FullType(FriendRequestPageResponse),
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
    BaseResponseFriendRequestPageResponse object, {
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
    required BaseResponseFriendRequestPageResponseBuilder result,
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
            specifiedType: const FullType(FriendRequestPageResponse),
          ) as FriendRequestPageResponse;
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
  BaseResponseFriendRequestPageResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseFriendRequestPageResponseBuilder();
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
