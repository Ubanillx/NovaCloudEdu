//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'follow_user_response.g.dart';

/// 关注用户响应
///
/// Properties:
/// * [userId] - 用户ID
/// * [followTime] - 关注时间
@BuiltValue()
abstract class FollowUserResponse
    implements Built<FollowUserResponse, FollowUserResponseBuilder> {
  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 关注时间
  @BuiltValueField(wireName: r'followTime')
  DateTime? get followTime;

  FollowUserResponse._();

  factory FollowUserResponse([void updates(FollowUserResponseBuilder b)]) =
      _$FollowUserResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FollowUserResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FollowUserResponse> get serializer =>
      _$FollowUserResponseSerializer();
}

class _$FollowUserResponseSerializer
    implements PrimitiveSerializer<FollowUserResponse> {
  @override
  final Iterable<Type> types = const [FollowUserResponse, _$FollowUserResponse];

  @override
  final String wireName = r'FollowUserResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FollowUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.followTime != null) {
      yield r'followTime';
      yield serializers.serialize(
        object.followTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FollowUserResponse object, {
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
    required FollowUserResponseBuilder result,
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
        case r'followTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.followTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FollowUserResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FollowUserResponseBuilder();
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
