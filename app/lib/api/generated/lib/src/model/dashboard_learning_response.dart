//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_learning_response.g.dart';

/// DashboardLearningResponse
///
/// Properties:
/// * [activityDistribution]
/// * [totalDurationSec]
/// * [avgHomeworkScoreRate]
/// * [topActiveUsers]
/// * [topActiveClasses]
/// * [dailyActiveTrend]
@BuiltValue()
abstract class DashboardLearningResponse
    implements
        Built<DashboardLearningResponse, DashboardLearningResponseBuilder> {
  @BuiltValueField(wireName: r'activityDistribution')
  BuiltList<BuiltMap<String, JsonObject>>? get activityDistribution;

  @BuiltValueField(wireName: r'totalDurationSec')
  int? get totalDurationSec;

  @BuiltValueField(wireName: r'avgHomeworkScoreRate')
  double? get avgHomeworkScoreRate;

  @BuiltValueField(wireName: r'topActiveUsers')
  BuiltList<BuiltMap<String, JsonObject>>? get topActiveUsers;

  @BuiltValueField(wireName: r'topActiveClasses')
  BuiltList<BuiltMap<String, JsonObject>>? get topActiveClasses;

  @BuiltValueField(wireName: r'dailyActiveTrend')
  BuiltList<BuiltMap<String, JsonObject>>? get dailyActiveTrend;

  DashboardLearningResponse._();

  factory DashboardLearningResponse(
          [void updates(DashboardLearningResponseBuilder b)]) =
      _$DashboardLearningResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardLearningResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardLearningResponse> get serializer =>
      _$DashboardLearningResponseSerializer();
}

class _$DashboardLearningResponseSerializer
    implements PrimitiveSerializer<DashboardLearningResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardLearningResponse,
    _$DashboardLearningResponse
  ];

  @override
  final String wireName = r'DashboardLearningResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardLearningResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.activityDistribution != null) {
      yield r'activityDistribution';
      yield serializers.serialize(
        object.activityDistribution,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.totalDurationSec != null) {
      yield r'totalDurationSec';
      yield serializers.serialize(
        object.totalDurationSec,
        specifiedType: const FullType(int),
      );
    }
    if (object.avgHomeworkScoreRate != null) {
      yield r'avgHomeworkScoreRate';
      yield serializers.serialize(
        object.avgHomeworkScoreRate,
        specifiedType: const FullType(double),
      );
    }
    if (object.topActiveUsers != null) {
      yield r'topActiveUsers';
      yield serializers.serialize(
        object.topActiveUsers,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.topActiveClasses != null) {
      yield r'topActiveClasses';
      yield serializers.serialize(
        object.topActiveClasses,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.dailyActiveTrend != null) {
      yield r'dailyActiveTrend';
      yield serializers.serialize(
        object.dailyActiveTrend,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardLearningResponse object, {
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
    required DashboardLearningResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'activityDistribution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.activityDistribution.replace(valueDes);
          break;
        case r'totalDurationSec':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDurationSec = valueDes;
          break;
        case r'avgHomeworkScoreRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.avgHomeworkScoreRate = valueDes;
          break;
        case r'topActiveUsers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.topActiveUsers.replace(valueDes);
          break;
        case r'topActiveClasses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.topActiveClasses.replace(valueDes);
          break;
        case r'dailyActiveTrend':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.dailyActiveTrend.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardLearningResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardLearningResponseBuilder();
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
