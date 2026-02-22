//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/dashboard_learning_response.dart';
import 'package:nova_api/src/model/dashboard_ai_system_response.dart';
import 'package:nova_api/src/model/dashboard_alerts_response.dart';
import 'package:nova_api/src/model/dashboard_overview_response.dart';
import 'package:nova_api/src/model/dashboard_content_response.dart';
import 'package:nova_api/src/model/dashboard_trends_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_full_response.g.dart';

/// DashboardFullResponse
///
/// Properties:
/// * [overview]
/// * [trends]
/// * [learning]
/// * [content]
/// * [aiSystem]
/// * [alerts]
@BuiltValue()
abstract class DashboardFullResponse
    implements Built<DashboardFullResponse, DashboardFullResponseBuilder> {
  @BuiltValueField(wireName: r'overview')
  DashboardOverviewResponse? get overview;

  @BuiltValueField(wireName: r'trends')
  DashboardTrendsResponse? get trends;

  @BuiltValueField(wireName: r'learning')
  DashboardLearningResponse? get learning;

  @BuiltValueField(wireName: r'content')
  DashboardContentResponse? get content;

  @BuiltValueField(wireName: r'aiSystem')
  DashboardAiSystemResponse? get aiSystem;

  @BuiltValueField(wireName: r'alerts')
  DashboardAlertsResponse? get alerts;

  DashboardFullResponse._();

  factory DashboardFullResponse(
      [void updates(DashboardFullResponseBuilder b)]) = _$DashboardFullResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardFullResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardFullResponse> get serializer =>
      _$DashboardFullResponseSerializer();
}

class _$DashboardFullResponseSerializer
    implements PrimitiveSerializer<DashboardFullResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardFullResponse,
    _$DashboardFullResponse
  ];

  @override
  final String wireName = r'DashboardFullResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardFullResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.overview != null) {
      yield r'overview';
      yield serializers.serialize(
        object.overview,
        specifiedType: const FullType(DashboardOverviewResponse),
      );
    }
    if (object.trends != null) {
      yield r'trends';
      yield serializers.serialize(
        object.trends,
        specifiedType: const FullType(DashboardTrendsResponse),
      );
    }
    if (object.learning != null) {
      yield r'learning';
      yield serializers.serialize(
        object.learning,
        specifiedType: const FullType(DashboardLearningResponse),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(DashboardContentResponse),
      );
    }
    if (object.aiSystem != null) {
      yield r'aiSystem';
      yield serializers.serialize(
        object.aiSystem,
        specifiedType: const FullType(DashboardAiSystemResponse),
      );
    }
    if (object.alerts != null) {
      yield r'alerts';
      yield serializers.serialize(
        object.alerts,
        specifiedType: const FullType(DashboardAlertsResponse),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardFullResponse object, {
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
    required DashboardFullResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'overview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DashboardOverviewResponse),
          ) as DashboardOverviewResponse;
          result.overview.replace(valueDes);
          break;
        case r'trends':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DashboardTrendsResponse),
          ) as DashboardTrendsResponse;
          result.trends.replace(valueDes);
          break;
        case r'learning':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DashboardLearningResponse),
          ) as DashboardLearningResponse;
          result.learning.replace(valueDes);
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DashboardContentResponse),
          ) as DashboardContentResponse;
          result.content.replace(valueDes);
          break;
        case r'aiSystem':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DashboardAiSystemResponse),
          ) as DashboardAiSystemResponse;
          result.aiSystem.replace(valueDes);
          break;
        case r'alerts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DashboardAlertsResponse),
          ) as DashboardAlertsResponse;
          result.alerts.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardFullResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardFullResponseBuilder();
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
