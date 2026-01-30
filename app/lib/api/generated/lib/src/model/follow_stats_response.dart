//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'follow_stats_response.g.dart';

/// 关注统计响应
///
/// Properties:
/// * [followingCount] - 关注数
/// * [followerCount] - 粉丝数
@BuiltValue()
abstract class FollowStatsResponse
    implements Built<FollowStatsResponse, FollowStatsResponseBuilder> {
  /// 关注数
  @BuiltValueField(wireName: r'followingCount')
  int? get followingCount;

  /// 粉丝数
  @BuiltValueField(wireName: r'followerCount')
  int? get followerCount;

  FollowStatsResponse._();

  factory FollowStatsResponse([void updates(FollowStatsResponseBuilder b)]) =
      _$FollowStatsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FollowStatsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FollowStatsResponse> get serializer =>
      _$FollowStatsResponseSerializer();
}

class _$FollowStatsResponseSerializer
    implements PrimitiveSerializer<FollowStatsResponse> {
  @override
  final Iterable<Type> types = const [
    FollowStatsResponse,
    _$FollowStatsResponse
  ];

  @override
  final String wireName = r'FollowStatsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FollowStatsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.followingCount != null) {
      yield r'followingCount';
      yield serializers.serialize(
        object.followingCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.followerCount != null) {
      yield r'followerCount';
      yield serializers.serialize(
        object.followerCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FollowStatsResponse object, {
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
    required FollowStatsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'followingCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.followingCount = valueDes;
          break;
        case r'followerCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.followerCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FollowStatsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FollowStatsResponseBuilder();
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
