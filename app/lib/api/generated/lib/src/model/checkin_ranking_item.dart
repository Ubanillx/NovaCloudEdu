//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checkin_ranking_item.g.dart';

/// CheckinRankingItem
///
/// Properties:
/// * [userId]
/// * [userName]
/// * [userAvatar]
/// * [totalCheckinDays]
/// * [currentStreak]
/// * [rank]
@BuiltValue()
abstract class CheckinRankingItem
    implements Built<CheckinRankingItem, CheckinRankingItemBuilder> {
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  @BuiltValueField(wireName: r'totalCheckinDays')
  int? get totalCheckinDays;

  @BuiltValueField(wireName: r'currentStreak')
  int? get currentStreak;

  @BuiltValueField(wireName: r'rank')
  int? get rank;

  CheckinRankingItem._();

  factory CheckinRankingItem([void updates(CheckinRankingItemBuilder b)]) =
      _$CheckinRankingItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckinRankingItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckinRankingItem> get serializer =>
      _$CheckinRankingItemSerializer();
}

class _$CheckinRankingItemSerializer
    implements PrimitiveSerializer<CheckinRankingItem> {
  @override
  final Iterable<Type> types = const [CheckinRankingItem, _$CheckinRankingItem];

  @override
  final String wireName = r'CheckinRankingItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckinRankingItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userAvatar != null) {
      yield r'userAvatar';
      yield serializers.serialize(
        object.userAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalCheckinDays != null) {
      yield r'totalCheckinDays';
      yield serializers.serialize(
        object.totalCheckinDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.currentStreak != null) {
      yield r'currentStreak';
      yield serializers.serialize(
        object.currentStreak,
        specifiedType: const FullType(int),
      );
    }
    if (object.rank != null) {
      yield r'rank';
      yield serializers.serialize(
        object.rank,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckinRankingItem object, {
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
    required CheckinRankingItemBuilder result,
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
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'userAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAvatar = valueDes;
          break;
        case r'totalCheckinDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCheckinDays = valueDes;
          break;
        case r'currentStreak':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentStreak = valueDes;
          break;
        case r'rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rank = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckinRankingItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckinRankingItemBuilder();
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
