//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'execution_log_response.g.dart';

/// 工作流执行日志响应
///
/// Properties:
/// * [executionId] - 执行ID
/// * [nodeId] - 节点ID
/// * [nodeName] - 节点名称
/// * [nodeType] - 节点类型
/// * [level] - 日志级别
/// * [message] - 日志消息
/// * [durationMs] - 节点执行耗时（毫秒）
/// * [timestamp] - 日志时间戳
@BuiltValue()
abstract class ExecutionLogResponse
    implements Built<ExecutionLogResponse, ExecutionLogResponseBuilder> {
  /// 执行ID
  @BuiltValueField(wireName: r'executionId')
  String? get executionId;

  /// 节点ID
  @BuiltValueField(wireName: r'nodeId')
  String? get nodeId;

  /// 节点名称
  @BuiltValueField(wireName: r'nodeName')
  String? get nodeName;

  /// 节点类型
  @BuiltValueField(wireName: r'nodeType')
  ExecutionLogResponseNodeTypeEnum? get nodeType;
  // enum nodeTypeEnum {  START,  END,  LLM,  KNOWLEDGE_RETRIEVAL,  CODE,  CONDITION,  LOOP,  HTTP,  VARIABLE,  };

  /// 日志级别
  @BuiltValueField(wireName: r'level')
  ExecutionLogResponseLevelEnum? get level;
  // enum levelEnum {  DEBUG,  INFO,  WARN,  ERROR,  };

  /// 日志消息
  @BuiltValueField(wireName: r'message')
  String? get message;

  /// 节点执行耗时（毫秒）
  @BuiltValueField(wireName: r'durationMs')
  int? get durationMs;

  /// 日志时间戳
  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  ExecutionLogResponse._();

  factory ExecutionLogResponse([void updates(ExecutionLogResponseBuilder b)]) =
      _$ExecutionLogResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExecutionLogResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExecutionLogResponse> get serializer =>
      _$ExecutionLogResponseSerializer();
}

class _$ExecutionLogResponseSerializer
    implements PrimitiveSerializer<ExecutionLogResponse> {
  @override
  final Iterable<Type> types = const [
    ExecutionLogResponse,
    _$ExecutionLogResponse
  ];

  @override
  final String wireName = r'ExecutionLogResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExecutionLogResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.executionId != null) {
      yield r'executionId';
      yield serializers.serialize(
        object.executionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.nodeId != null) {
      yield r'nodeId';
      yield serializers.serialize(
        object.nodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.nodeName != null) {
      yield r'nodeName';
      yield serializers.serialize(
        object.nodeName,
        specifiedType: const FullType(String),
      );
    }
    if (object.nodeType != null) {
      yield r'nodeType';
      yield serializers.serialize(
        object.nodeType,
        specifiedType: const FullType(ExecutionLogResponseNodeTypeEnum),
      );
    }
    if (object.level != null) {
      yield r'level';
      yield serializers.serialize(
        object.level,
        specifiedType: const FullType(ExecutionLogResponseLevelEnum),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.durationMs != null) {
      yield r'durationMs';
      yield serializers.serialize(
        object.durationMs,
        specifiedType: const FullType(int),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExecutionLogResponse object, {
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
    required ExecutionLogResponseBuilder result,
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
        case r'nodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nodeId = valueDes;
          break;
        case r'nodeName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nodeName = valueDes;
          break;
        case r'nodeType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExecutionLogResponseNodeTypeEnum),
          ) as ExecutionLogResponseNodeTypeEnum;
          result.nodeType = valueDes;
          break;
        case r'level':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExecutionLogResponseLevelEnum),
          ) as ExecutionLogResponseLevelEnum;
          result.level = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'durationMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationMs = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExecutionLogResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExecutionLogResponseBuilder();
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

class ExecutionLogResponseNodeTypeEnum extends EnumClass {
  /// 节点类型
  @BuiltValueEnumConst(wireName: r'START')
  static const ExecutionLogResponseNodeTypeEnum START =
      _$executionLogResponseNodeTypeEnum_START;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'END')
  static const ExecutionLogResponseNodeTypeEnum END =
      _$executionLogResponseNodeTypeEnum_END;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LLM')
  static const ExecutionLogResponseNodeTypeEnum LLM =
      _$executionLogResponseNodeTypeEnum_LLM;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'KNOWLEDGE_RETRIEVAL')
  static const ExecutionLogResponseNodeTypeEnum KNOWLEDGE_RETRIEVAL =
      _$executionLogResponseNodeTypeEnum_KNOWLEDGE_RETRIEVAL;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'CODE')
  static const ExecutionLogResponseNodeTypeEnum CODE =
      _$executionLogResponseNodeTypeEnum_CODE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'CONDITION')
  static const ExecutionLogResponseNodeTypeEnum CONDITION =
      _$executionLogResponseNodeTypeEnum_CONDITION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LOOP')
  static const ExecutionLogResponseNodeTypeEnum LOOP =
      _$executionLogResponseNodeTypeEnum_LOOP;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'HTTP')
  static const ExecutionLogResponseNodeTypeEnum HTTP =
      _$executionLogResponseNodeTypeEnum_HTTP;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'VARIABLE')
  static const ExecutionLogResponseNodeTypeEnum VARIABLE =
      _$executionLogResponseNodeTypeEnum_VARIABLE;

  static Serializer<ExecutionLogResponseNodeTypeEnum> get serializer =>
      _$executionLogResponseNodeTypeEnumSerializer;

  const ExecutionLogResponseNodeTypeEnum._(String name) : super(name);

  static BuiltSet<ExecutionLogResponseNodeTypeEnum> get values =>
      _$executionLogResponseNodeTypeEnumValues;
  static ExecutionLogResponseNodeTypeEnum valueOf(String name) =>
      _$executionLogResponseNodeTypeEnumValueOf(name);
}

class ExecutionLogResponseLevelEnum extends EnumClass {
  /// 日志级别
  @BuiltValueEnumConst(wireName: r'DEBUG')
  static const ExecutionLogResponseLevelEnum DEBUG =
      _$executionLogResponseLevelEnum_DEBUG;

  /// 日志级别
  @BuiltValueEnumConst(wireName: r'INFO')
  static const ExecutionLogResponseLevelEnum INFO =
      _$executionLogResponseLevelEnum_INFO;

  /// 日志级别
  @BuiltValueEnumConst(wireName: r'WARN')
  static const ExecutionLogResponseLevelEnum WARN =
      _$executionLogResponseLevelEnum_WARN;

  /// 日志级别
  @BuiltValueEnumConst(wireName: r'ERROR')
  static const ExecutionLogResponseLevelEnum ERROR =
      _$executionLogResponseLevelEnum_ERROR;

  static Serializer<ExecutionLogResponseLevelEnum> get serializer =>
      _$executionLogResponseLevelEnumSerializer;

  const ExecutionLogResponseLevelEnum._(String name) : super(name);

  static BuiltSet<ExecutionLogResponseLevelEnum> get values =>
      _$executionLogResponseLevelEnumValues;
  static ExecutionLogResponseLevelEnum valueOf(String name) =>
      _$executionLogResponseLevelEnumValueOf(name);
}
