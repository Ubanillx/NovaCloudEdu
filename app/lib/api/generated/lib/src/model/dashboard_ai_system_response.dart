//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_ai_system_response.g.dart';

/// DashboardAiSystemResponse
///
/// Properties:
/// * [totalAiSessions]
/// * [todayAiSessions]
/// * [totalAiMessages]
/// * [todayAiMessages]
/// * [totalSubmissions]
/// * [todaySubmissions]
/// * [submissionsByStatus]
/// * [submissionsBySubject]
/// * [totalPptSessions]
/// * [todayPptSessions]
/// * [completedPptSessions]
/// * [aiUsageToday]
/// * [aiUsageTotal]
/// * [totalWorkflows]
/// * [totalWorkflowExecutions]
/// * [completedWorkflowExecutions]
@BuiltValue()
abstract class DashboardAiSystemResponse
    implements
        Built<DashboardAiSystemResponse, DashboardAiSystemResponseBuilder> {
  @BuiltValueField(wireName: r'totalAiSessions')
  int? get totalAiSessions;

  @BuiltValueField(wireName: r'todayAiSessions')
  int? get todayAiSessions;

  @BuiltValueField(wireName: r'totalAiMessages')
  int? get totalAiMessages;

  @BuiltValueField(wireName: r'todayAiMessages')
  int? get todayAiMessages;

  @BuiltValueField(wireName: r'totalSubmissions')
  int? get totalSubmissions;

  @BuiltValueField(wireName: r'todaySubmissions')
  int? get todaySubmissions;

  @BuiltValueField(wireName: r'submissionsByStatus')
  BuiltList<BuiltMap<String, JsonObject>>? get submissionsByStatus;

  @BuiltValueField(wireName: r'submissionsBySubject')
  BuiltList<BuiltMap<String, JsonObject>>? get submissionsBySubject;

  @BuiltValueField(wireName: r'totalPptSessions')
  int? get totalPptSessions;

  @BuiltValueField(wireName: r'todayPptSessions')
  int? get todayPptSessions;

  @BuiltValueField(wireName: r'completedPptSessions')
  int? get completedPptSessions;

  @BuiltValueField(wireName: r'aiUsageToday')
  BuiltList<BuiltMap<String, JsonObject>>? get aiUsageToday;

  @BuiltValueField(wireName: r'aiUsageTotal')
  BuiltList<BuiltMap<String, JsonObject>>? get aiUsageTotal;

  @BuiltValueField(wireName: r'totalWorkflows')
  int? get totalWorkflows;

  @BuiltValueField(wireName: r'totalWorkflowExecutions')
  int? get totalWorkflowExecutions;

  @BuiltValueField(wireName: r'completedWorkflowExecutions')
  int? get completedWorkflowExecutions;

  DashboardAiSystemResponse._();

  factory DashboardAiSystemResponse(
          [void updates(DashboardAiSystemResponseBuilder b)]) =
      _$DashboardAiSystemResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardAiSystemResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardAiSystemResponse> get serializer =>
      _$DashboardAiSystemResponseSerializer();
}

class _$DashboardAiSystemResponseSerializer
    implements PrimitiveSerializer<DashboardAiSystemResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardAiSystemResponse,
    _$DashboardAiSystemResponse
  ];

  @override
  final String wireName = r'DashboardAiSystemResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardAiSystemResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalAiSessions != null) {
      yield r'totalAiSessions';
      yield serializers.serialize(
        object.totalAiSessions,
        specifiedType: const FullType(int),
      );
    }
    if (object.todayAiSessions != null) {
      yield r'todayAiSessions';
      yield serializers.serialize(
        object.todayAiSessions,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalAiMessages != null) {
      yield r'totalAiMessages';
      yield serializers.serialize(
        object.totalAiMessages,
        specifiedType: const FullType(int),
      );
    }
    if (object.todayAiMessages != null) {
      yield r'todayAiMessages';
      yield serializers.serialize(
        object.todayAiMessages,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalSubmissions != null) {
      yield r'totalSubmissions';
      yield serializers.serialize(
        object.totalSubmissions,
        specifiedType: const FullType(int),
      );
    }
    if (object.todaySubmissions != null) {
      yield r'todaySubmissions';
      yield serializers.serialize(
        object.todaySubmissions,
        specifiedType: const FullType(int),
      );
    }
    if (object.submissionsByStatus != null) {
      yield r'submissionsByStatus';
      yield serializers.serialize(
        object.submissionsByStatus,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.submissionsBySubject != null) {
      yield r'submissionsBySubject';
      yield serializers.serialize(
        object.submissionsBySubject,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.totalPptSessions != null) {
      yield r'totalPptSessions';
      yield serializers.serialize(
        object.totalPptSessions,
        specifiedType: const FullType(int),
      );
    }
    if (object.todayPptSessions != null) {
      yield r'todayPptSessions';
      yield serializers.serialize(
        object.todayPptSessions,
        specifiedType: const FullType(int),
      );
    }
    if (object.completedPptSessions != null) {
      yield r'completedPptSessions';
      yield serializers.serialize(
        object.completedPptSessions,
        specifiedType: const FullType(int),
      );
    }
    if (object.aiUsageToday != null) {
      yield r'aiUsageToday';
      yield serializers.serialize(
        object.aiUsageToday,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.aiUsageTotal != null) {
      yield r'aiUsageTotal';
      yield serializers.serialize(
        object.aiUsageTotal,
        specifiedType: const FullType(BuiltList, [
          FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
        ]),
      );
    }
    if (object.totalWorkflows != null) {
      yield r'totalWorkflows';
      yield serializers.serialize(
        object.totalWorkflows,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalWorkflowExecutions != null) {
      yield r'totalWorkflowExecutions';
      yield serializers.serialize(
        object.totalWorkflowExecutions,
        specifiedType: const FullType(int),
      );
    }
    if (object.completedWorkflowExecutions != null) {
      yield r'completedWorkflowExecutions';
      yield serializers.serialize(
        object.completedWorkflowExecutions,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardAiSystemResponse object, {
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
    required DashboardAiSystemResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalAiSessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalAiSessions = valueDes;
          break;
        case r'todayAiSessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayAiSessions = valueDes;
          break;
        case r'totalAiMessages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalAiMessages = valueDes;
          break;
        case r'todayAiMessages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayAiMessages = valueDes;
          break;
        case r'totalSubmissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalSubmissions = valueDes;
          break;
        case r'todaySubmissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todaySubmissions = valueDes;
          break;
        case r'submissionsByStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.submissionsByStatus.replace(valueDes);
          break;
        case r'submissionsBySubject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.submissionsBySubject.replace(valueDes);
          break;
        case r'totalPptSessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPptSessions = valueDes;
          break;
        case r'todayPptSessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayPptSessions = valueDes;
          break;
        case r'completedPptSessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.completedPptSessions = valueDes;
          break;
        case r'aiUsageToday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.aiUsageToday.replace(valueDes);
          break;
        case r'aiUsageTotal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [
              FullType(BuiltMap, [FullType(String), FullType(JsonObject)])
            ]),
          ) as BuiltList<BuiltMap<String, JsonObject>>;
          result.aiUsageTotal.replace(valueDes);
          break;
        case r'totalWorkflows':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalWorkflows = valueDes;
          break;
        case r'totalWorkflowExecutions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalWorkflowExecutions = valueDes;
          break;
        case r'completedWorkflowExecutions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.completedWorkflowExecutions = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardAiSystemResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardAiSystemResponseBuilder();
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
