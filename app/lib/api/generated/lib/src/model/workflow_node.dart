//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/error_handling_config.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:nova_api/src/model/position.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_node.g.dart';

/// WorkflowNode
///
/// Properties:
/// * [id]
/// * [type]
/// * [name]
/// * [position]
/// * [config]
/// * [errorHandling]
@BuiltValue()
abstract class WorkflowNode
    implements Built<WorkflowNode, WorkflowNodeBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'type')
  WorkflowNodeTypeEnum? get type;
  // enum typeEnum {  START,  WEBHOOK,  SCHEDULE,  LLM,  KNOWLEDGE_RETRIEVAL,  TEXT_EMBEDDING,  INTENT_RECOGNITION,  ENTITY_EXTRACTION,  CONDITION,  SWITCH,  LOOP,  PARALLEL,  MERGE,  VARIABLE_SET,  VARIABLE_GET,  JSON_PARSE,  TEMPLATE,  CODE,  HTTP_REQUEST,  DATABASE_QUERY,  FILE_READ,  FILE_WRITE,  RESPONSE,  END,  };

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'position')
  Position? get position;

  @BuiltValueField(wireName: r'config')
  BuiltMap<String, JsonObject>? get config;

  @BuiltValueField(wireName: r'errorHandling')
  ErrorHandlingConfig? get errorHandling;

  WorkflowNode._();

  factory WorkflowNode([void updates(WorkflowNodeBuilder b)]) = _$WorkflowNode;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowNodeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowNode> get serializer => _$WorkflowNodeSerializer();
}

class _$WorkflowNodeSerializer implements PrimitiveSerializer<WorkflowNode> {
  @override
  final Iterable<Type> types = const [WorkflowNode, _$WorkflowNode];

  @override
  final String wireName = r'WorkflowNode';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowNode object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(WorkflowNodeTypeEnum),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.position != null) {
      yield r'position';
      yield serializers.serialize(
        object.position,
        specifiedType: const FullType(Position),
      );
    }
    if (object.config != null) {
      yield r'config';
      yield serializers.serialize(
        object.config,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
    if (object.errorHandling != null) {
      yield r'errorHandling';
      yield serializers.serialize(
        object.errorHandling,
        specifiedType: const FullType(ErrorHandlingConfig),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowNode object, {
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
    required WorkflowNodeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkflowNodeTypeEnum),
          ) as WorkflowNodeTypeEnum;
          result.type = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Position),
          ) as Position;
          result.position.replace(valueDes);
          break;
        case r'config':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.config.replace(valueDes);
          break;
        case r'errorHandling':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ErrorHandlingConfig),
          ) as ErrorHandlingConfig;
          result.errorHandling.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowNode deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowNodeBuilder();
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

class WorkflowNodeTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'START')
  static const WorkflowNodeTypeEnum START = _$workflowNodeTypeEnum_START;
  @BuiltValueEnumConst(wireName: r'WEBHOOK')
  static const WorkflowNodeTypeEnum WEBHOOK = _$workflowNodeTypeEnum_WEBHOOK;
  @BuiltValueEnumConst(wireName: r'SCHEDULE')
  static const WorkflowNodeTypeEnum SCHEDULE = _$workflowNodeTypeEnum_SCHEDULE;
  @BuiltValueEnumConst(wireName: r'LLM')
  static const WorkflowNodeTypeEnum LLM = _$workflowNodeTypeEnum_LLM;
  @BuiltValueEnumConst(wireName: r'KNOWLEDGE_RETRIEVAL')
  static const WorkflowNodeTypeEnum KNOWLEDGE_RETRIEVAL =
      _$workflowNodeTypeEnum_KNOWLEDGE_RETRIEVAL;
  @BuiltValueEnumConst(wireName: r'TEXT_EMBEDDING')
  static const WorkflowNodeTypeEnum TEXT_EMBEDDING =
      _$workflowNodeTypeEnum_TEXT_EMBEDDING;
  @BuiltValueEnumConst(wireName: r'INTENT_RECOGNITION')
  static const WorkflowNodeTypeEnum INTENT_RECOGNITION =
      _$workflowNodeTypeEnum_INTENT_RECOGNITION;
  @BuiltValueEnumConst(wireName: r'ENTITY_EXTRACTION')
  static const WorkflowNodeTypeEnum ENTITY_EXTRACTION =
      _$workflowNodeTypeEnum_ENTITY_EXTRACTION;
  @BuiltValueEnumConst(wireName: r'CONDITION')
  static const WorkflowNodeTypeEnum CONDITION =
      _$workflowNodeTypeEnum_CONDITION;
  @BuiltValueEnumConst(wireName: r'SWITCH')
  static const WorkflowNodeTypeEnum SWITCH = _$workflowNodeTypeEnum_SWITCH;
  @BuiltValueEnumConst(wireName: r'LOOP')
  static const WorkflowNodeTypeEnum LOOP = _$workflowNodeTypeEnum_LOOP;
  @BuiltValueEnumConst(wireName: r'PARALLEL')
  static const WorkflowNodeTypeEnum PARALLEL = _$workflowNodeTypeEnum_PARALLEL;
  @BuiltValueEnumConst(wireName: r'MERGE')
  static const WorkflowNodeTypeEnum MERGE = _$workflowNodeTypeEnum_MERGE;
  @BuiltValueEnumConst(wireName: r'VARIABLE_SET')
  static const WorkflowNodeTypeEnum VARIABLE_SET =
      _$workflowNodeTypeEnum_VARIABLE_SET;
  @BuiltValueEnumConst(wireName: r'VARIABLE_GET')
  static const WorkflowNodeTypeEnum VARIABLE_GET =
      _$workflowNodeTypeEnum_VARIABLE_GET;
  @BuiltValueEnumConst(wireName: r'JSON_PARSE')
  static const WorkflowNodeTypeEnum JSON_PARSE =
      _$workflowNodeTypeEnum_JSON_PARSE;
  @BuiltValueEnumConst(wireName: r'TEMPLATE')
  static const WorkflowNodeTypeEnum TEMPLATE = _$workflowNodeTypeEnum_TEMPLATE;
  @BuiltValueEnumConst(wireName: r'CODE')
  static const WorkflowNodeTypeEnum CODE = _$workflowNodeTypeEnum_CODE;
  @BuiltValueEnumConst(wireName: r'HTTP_REQUEST')
  static const WorkflowNodeTypeEnum HTTP_REQUEST =
      _$workflowNodeTypeEnum_HTTP_REQUEST;
  @BuiltValueEnumConst(wireName: r'DATABASE_QUERY')
  static const WorkflowNodeTypeEnum DATABASE_QUERY =
      _$workflowNodeTypeEnum_DATABASE_QUERY;
  @BuiltValueEnumConst(wireName: r'FILE_READ')
  static const WorkflowNodeTypeEnum FILE_READ =
      _$workflowNodeTypeEnum_FILE_READ;
  @BuiltValueEnumConst(wireName: r'FILE_WRITE')
  static const WorkflowNodeTypeEnum FILE_WRITE =
      _$workflowNodeTypeEnum_FILE_WRITE;
  @BuiltValueEnumConst(wireName: r'RESPONSE')
  static const WorkflowNodeTypeEnum RESPONSE = _$workflowNodeTypeEnum_RESPONSE;
  @BuiltValueEnumConst(wireName: r'END')
  static const WorkflowNodeTypeEnum END = _$workflowNodeTypeEnum_END;

  static Serializer<WorkflowNodeTypeEnum> get serializer =>
      _$workflowNodeTypeEnumSerializer;

  const WorkflowNodeTypeEnum._(String name) : super(name);

  static BuiltSet<WorkflowNodeTypeEnum> get values =>
      _$workflowNodeTypeEnumValues;
  static WorkflowNodeTypeEnum valueOf(String name) =>
      _$workflowNodeTypeEnumValueOf(name);
}
