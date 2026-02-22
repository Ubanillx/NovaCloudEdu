//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_trends_response.g.dart';

/// DashboardTrendsResponse
///
/// Properties:
/// * [userGrowth]
/// * [activeTrend]
/// * [revenueTrend]
@BuiltValue()
abstract class DashboardTrendsResponse
    implements Built<DashboardTrendsResponse, DashboardTrendsResponseBuilder> {
  @BuiltValueField(wireName: r'userGrowth')
  BuiltList<BuiltMap<String, JsonObject>>? get userGrowth;

  @BuiltValueField(wireName: r'activeTrend')
  BuiltList<BuiltMap<String, JsonObject>>? get activeTrend;

  @BuiltValueField(wireName: r'revenueTrend')
  BuiltList<BuiltMap<String, JsonObject>>? get revenueTrend;

  DashboardTrendsResponse._();

  factory DashboardTrendsResponse(
          [void updates(DashboardTrendsResponseBuilder b)]) =
      _$DashboardTrendsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardTrendsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardTrendsResponse> get serializer =>
      _$DashboardTrendsResponseSerializer();
}

class _$DashboardTrendsResponseSerializer
    implements PrimitiveSerializer<DashboardTrendsResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardTrendsResponse,
    _$DashboardTrendsResponse
  ];

  @override
  final String wireName = r'DashboardTrendsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardTrendsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userGrowth != null) {
      yield r'userGrowth';
      yield serializers.serialize(
        object.userGrowth,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.activeTrend != null) {
      yield r'activeTrend';
      yield serializers.serialize(
        object.activeTrend,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.revenueTrend != null) {
      yield r'revenueTrend';
      yield serializers.serialize(
        object.revenueTrend,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardTrendsResponse object, {
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
    required DashboardTrendsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userGrowth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.userGrowth.replace(valueDes);
          break;
        case r'activeTrend':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.activeTrend.replace(valueDes);
          break;
        case r'revenueTrend':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.revenueTrend.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardTrendsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardTrendsResponseBuilder();
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
