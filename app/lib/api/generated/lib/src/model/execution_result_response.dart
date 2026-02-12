//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/node_execution_dto.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'execution_result_response.g.dart';

/// 工作流执行结果响应
///
/// Properties:
/// * [executionId] - 执行ID
/// * [workflowId] - 工作流ID
/// * [workflowName] - 工作流名称
/// * [workflowVersion] - 工作流版本
/// * [status] - 执行状态
/// * [input] - 输入参数
/// * [output] - 输出结果
/// * [variables] - 执行过程中的变量
/// * [currentNodeId] - 当前执行节点ID
/// * [errorMessage] - 错误信息
/// * [startTime] - 开始时间
/// * [endTime] - 结束时间
/// * [durationMs] - 执行耗时（毫秒）
/// * [nodeExecutions] - 各节点执行详情（调试数据）
@BuiltValue()
abstract class ExecutionResultResponse
    implements Built<ExecutionResultResponse, ExecutionResultResponseBuilder> {
  /// 执行ID
  @BuiltValueField(wireName: r'executionId')
  String? get executionId;

  /// 工作流ID
  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  /// 工作流名称
  @BuiltValueField(wireName: r'workflowName')
  String? get workflowName;

  /// 工作流版本
  @BuiltValueField(wireName: r'workflowVersion')
  int? get workflowVersion;

  /// 执行状态
  @BuiltValueField(wireName: r'status')
  ExecutionResultResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  RUNNING,  COMPLETED,  FAILED,  CANCELLED,  };

  /// 输入参数
  @BuiltValueField(wireName: r'input')
  BuiltMap<String, JsonObject>? get input;

  /// 输出结果
  @BuiltValueField(wireName: r'output')
  BuiltMap<String, JsonObject>? get output;

  /// 执行过程中的变量
  @BuiltValueField(wireName: r'variables')
  BuiltMap<String, JsonObject>? get variables;

  /// 当前执行节点ID
  @BuiltValueField(wireName: r'currentNodeId')
  String? get currentNodeId;

  /// 错误信息
  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  /// 开始时间
  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  /// 结束时间
  @BuiltValueField(wireName: r'endTime')
  DateTime? get endTime;

  /// 执行耗时（毫秒）
  @BuiltValueField(wireName: r'durationMs')
  int? get durationMs;

  /// 各节点执行详情（调试数据）
  @BuiltValueField(wireName: r'nodeExecutions')
  BuiltList<NodeExecutionDTO>? get nodeExecutions;

  ExecutionResultResponse._();

  factory ExecutionResultResponse(
          [void updates(ExecutionResultResponseBuilder b)]) =
      _$ExecutionResultResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExecutionResultResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExecutionResultResponse> get serializer =>
      _$ExecutionResultResponseSerializer();
}

class _$ExecutionResultResponseSerializer
    implements PrimitiveSerializer<ExecutionResultResponse> {
  @override
  final Iterable<Type> types = const [
    ExecutionResultResponse,
    _$ExecutionResultResponse
  ];

  @override
  final String wireName = r'ExecutionResultResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExecutionResultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.executionId != null) {
      yield r'executionId';
      yield serializers.serialize(
        object.executionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(int),
      );
    }
    if (object.workflowName != null) {
      yield r'workflowName';
      yield serializers.serialize(
        object.workflowName,
        specifiedType: const FullType(String),
      );
    }
    if (object.workflowVersion != null) {
      yield r'workflowVersion';
      yield serializers.serialize(
        object.workflowVersion,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ExecutionResultResponseStatusEnum),
      );
    }
    if (object.input != null) {
      yield r'input';
      yield serializers.serialize(
        object.input,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
    if (object.output != null) {
      yield r'output';
      yield serializers.serialize(
        object.output,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
    if (object.variables != null) {
      yield r'variables';
      yield serializers.serialize(
        object.variables,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
    if (object.currentNodeId != null) {
      yield r'currentNodeId';
      yield serializers.serialize(
        object.currentNodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.errorMessage != null) {
      yield r'errorMessage';
      yield serializers.serialize(
        object.errorMessage,
        specifiedType: const FullType(String),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.endTime != null) {
      yield r'endTime';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.durationMs != null) {
      yield r'durationMs';
      yield serializers.serialize(
        object.durationMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.nodeExecutions != null) {
      yield r'nodeExecutions';
      yield serializers.serialize(
        object.nodeExecutions,
        specifiedType: const FullType(BuiltList, [FullType(NodeExecutionDTO)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExecutionResultResponse object, {
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
    required ExecutionResultResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'executionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.executionId = valueDes;
          break;
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowId = valueDes;
          break;
        case r'workflowName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workflowName = valueDes;
          break;
        case r'workflowVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowVersion = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExecutionResultResponseStatusEnum),
          ) as ExecutionResultResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'input':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.input.replace(valueDes);
          break;
        case r'output':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.output.replace(valueDes);
          break;
        case r'variables':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.variables.replace(valueDes);
          break;
        case r'currentNodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currentNodeId = valueDes;
          break;
        case r'errorMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorMessage = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endTime = valueDes;
          break;
        case r'durationMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationMs = valueDes;
          break;
        case r'nodeExecutions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(NodeExecutionDTO)]),
          ) as BuiltList<NodeExecutionDTO>;
          result.nodeExecutions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExecutionResultResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExecutionResultResponseBuilder();
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

class ExecutionResultResponseStatusEnum extends EnumClass {
  /// 执行状态
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const ExecutionResultResponseStatusEnum PENDING =
      _$executionResultResponseStatusEnum_PENDING;

  /// 执行状态
  @BuiltValueEnumConst(wireName: r'RUNNING')
  static const ExecutionResultResponseStatusEnum RUNNING =
      _$executionResultResponseStatusEnum_RUNNING;

  /// 执行状态
  @BuiltValueEnumConst(wireName: r'COMPLETED')
  static const ExecutionResultResponseStatusEnum COMPLETED =
      _$executionResultResponseStatusEnum_COMPLETED;

  /// 执行状态
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const ExecutionResultResponseStatusEnum FAILED =
      _$executionResultResponseStatusEnum_FAILED;

  /// 执行状态
  @BuiltValueEnumConst(wireName: r'CANCELLED')
  static const ExecutionResultResponseStatusEnum CANCELLED =
      _$executionResultResponseStatusEnum_CANCELLED;

  static Serializer<ExecutionResultResponseStatusEnum> get serializer =>
      _$executionResultResponseStatusEnumSerializer;

  const ExecutionResultResponseStatusEnum._(String name) : super(name);

  static BuiltSet<ExecutionResultResponseStatusEnum> get values =>
      _$executionResultResponseStatusEnumValues;
  static ExecutionResultResponseStatusEnum valueOf(String name) =>
      _$executionResultResponseStatusEnumValueOf(name);
}
