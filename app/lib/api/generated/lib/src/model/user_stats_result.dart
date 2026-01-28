//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_stats_result.g.dart';

/// UserStatsResult
///
/// Properties:
/// * [registerDays]
/// * [totalCheckinDays]
/// * [currentStreak]
/// * [checkedInToday]
/// * [totalLikes]
@BuiltValue()
abstract class UserStatsResult
    implements Built<UserStatsResult, UserStatsResultBuilder> {
  @BuiltValueField(wireName: r'registerDays')
  int? get registerDays;

  @BuiltValueField(wireName: r'totalCheckinDays')
  int? get totalCheckinDays;

  @BuiltValueField(wireName: r'currentStreak')
  int? get currentStreak;

  @BuiltValueField(wireName: r'checkedInToday')
  bool? get checkedInToday;

  @BuiltValueField(wireName: r'totalLikes')
  int? get totalLikes;

  UserStatsResult._();

  factory UserStatsResult([void updates(UserStatsResultBuilder b)]) =
      _$UserStatsResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserStatsResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserStatsResult> get serializer =>
      _$UserStatsResultSerializer();
}

class _$UserStatsResultSerializer
    implements PrimitiveSerializer<UserStatsResult> {
  @override
  final Iterable<Type> types = const [UserStatsResult, _$UserStatsResult];

  @override
  final String wireName = r'UserStatsResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserStatsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.registerDays != null) {
      yield r'registerDays';
      yield serializers.serialize(
        object.registerDays,
        specifiedType: const FullType(int),
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
    if (object.checkedInToday != null) {
      yield r'checkedInToday';
      yield serializers.serialize(
        object.checkedInToday,
        specifiedType: const FullType(bool),
      );
    }
    if (object.totalLikes != null) {
      yield r'totalLikes';
      yield serializers.serialize(
        object.totalLikes,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserStatsResult object, {
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
    required UserStatsResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'registerDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.registerDays = valueDes;
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
        case r'checkedInToday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.checkedInToday = valueDes;
          break;
        case r'totalLikes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalLikes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserStatsResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserStatsResultBuilder();
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
