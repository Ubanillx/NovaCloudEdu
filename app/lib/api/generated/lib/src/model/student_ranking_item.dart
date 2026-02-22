//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_ranking_item.g.dart';

/// StudentRankingItem
///
/// Properties:
/// * [rank]
/// * [userId]
/// * [userName]
/// * [totalDurationSec]
/// * [durationText]
/// * [activityCount]
/// * [scoreRate]
/// * [compositeScore]
@BuiltValue()
abstract class StudentRankingItem
    implements Built<StudentRankingItem, StudentRankingItemBuilder> {
  @BuiltValueField(wireName: r'rank')
  int? get rank;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'totalDurationSec')
  int? get totalDurationSec;

  @BuiltValueField(wireName: r'durationText')
  String? get durationText;

  @BuiltValueField(wireName: r'activityCount')
  int? get activityCount;

  @BuiltValueField(wireName: r'scoreRate')
  double? get scoreRate;

  @BuiltValueField(wireName: r'compositeScore')
  double? get compositeScore;

  StudentRankingItem._();

  factory StudentRankingItem([void updates(StudentRankingItemBuilder b)]) =
      _$StudentRankingItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentRankingItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentRankingItem> get serializer =>
      _$StudentRankingItemSerializer();
}

class _$StudentRankingItemSerializer
    implements PrimitiveSerializer<StudentRankingItem> {
  @override
  final Iterable<Type> types = const [StudentRankingItem, _$StudentRankingItem];

  @override
  final String wireName = r'StudentRankingItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentRankingItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.rank != null) {
      yield r'rank';
      yield serializers.serialize(
        object.rank,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalDurationSec != null) {
      yield r'totalDurationSec';
      yield serializers.serialize(
        object.totalDurationSec,
        specifiedType: const FullType(int),
      );
    }
    if (object.durationText != null) {
      yield r'durationText';
      yield serializers.serialize(
        object.durationText,
        specifiedType: const FullType(String),
      );
    }
    if (object.activityCount != null) {
      yield r'activityCount';
      yield serializers.serialize(
        object.activityCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.scoreRate != null) {
      yield r'scoreRate';
      yield serializers.serialize(
        object.scoreRate,
        specifiedType: const FullType(double),
      );
    }
    if (object.compositeScore != null) {
      yield r'compositeScore';
      yield serializers.serialize(
        object.compositeScore,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentRankingItem object, {
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
    required StudentRankingItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rank = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'totalDurationSec':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDurationSec = valueDes;
          break;
        case r'durationText':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.durationText = valueDes;
          break;
        case r'activityCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activityCount = valueDes;
          break;
        case r'scoreRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.scoreRate = valueDes;
          break;
        case r'compositeScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.compositeScore = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentRankingItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentRankingItemBuilder();
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
