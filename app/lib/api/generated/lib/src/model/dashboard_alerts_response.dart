//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_alerts_response.g.dart';

/// DashboardAlertsResponse
///
/// Properties:
/// * [pendingFeedbackCount]
/// * [recentPendingFeedbacks]
/// * [expiringMemberCount]
/// * [failedScraperTaskCount]
/// * [todayCheckinCount]
/// * [totalUserCount]
@BuiltValue()
abstract class DashboardAlertsResponse
    implements Built<DashboardAlertsResponse, DashboardAlertsResponseBuilder> {
  @BuiltValueField(wireName: r'pendingFeedbackCount')
  int? get pendingFeedbackCount;

  @BuiltValueField(wireName: r'recentPendingFeedbacks')
  BuiltList<BuiltMap<String, JsonObject>>? get recentPendingFeedbacks;

  @BuiltValueField(wireName: r'expiringMemberCount')
  int? get expiringMemberCount;

  @BuiltValueField(wireName: r'failedScraperTaskCount')
  int? get failedScraperTaskCount;

  @BuiltValueField(wireName: r'todayCheckinCount')
  int? get todayCheckinCount;

  @BuiltValueField(wireName: r'totalUserCount')
  int? get totalUserCount;

  DashboardAlertsResponse._();

  factory DashboardAlertsResponse(
          [void updates(DashboardAlertsResponseBuilder b)]) =
      _$DashboardAlertsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardAlertsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardAlertsResponse> get serializer =>
      _$DashboardAlertsResponseSerializer();
}

class _$DashboardAlertsResponseSerializer
    implements PrimitiveSerializer<DashboardAlertsResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardAlertsResponse,
    _$DashboardAlertsResponse
  ];

  @override
  final String wireName = r'DashboardAlertsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardAlertsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.pendingFeedbackCount != null) {
      yield r'pendingFeedbackCount';
      yield serializers.serialize(
        object.pendingFeedbackCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.recentPendingFeedbacks != null) {
      yield r'recentPendingFeedbacks';
      yield serializers.serialize(
        object.recentPendingFeedbacks,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.expiringMemberCount != null) {
      yield r'expiringMemberCount';
      yield serializers.serialize(
        object.expiringMemberCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.failedScraperTaskCount != null) {
      yield r'failedScraperTaskCount';
      yield serializers.serialize(
        object.failedScraperTaskCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.todayCheckinCount != null) {
      yield r'todayCheckinCount';
      yield serializers.serialize(
        object.todayCheckinCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalUserCount != null) {
      yield r'totalUserCount';
      yield serializers.serialize(
        object.totalUserCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardAlertsResponse object, {
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
    required DashboardAlertsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'pendingFeedbackCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingFeedbackCount = valueDes;
          break;
        case r'recentPendingFeedbacks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.recentPendingFeedbacks.replace(valueDes);
          break;
        case r'expiringMemberCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiringMemberCount = valueDes;
          break;
        case r'failedScraperTaskCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failedScraperTaskCount = valueDes;
          break;
        case r'todayCheckinCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayCheckinCount = valueDes;
          break;
        case r'totalUserCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalUserCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardAlertsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardAlertsResponseBuilder();
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
