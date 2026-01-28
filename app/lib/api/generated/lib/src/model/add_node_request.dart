//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/error_handling_config_dto.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_node_request.g.dart';

/// 添加工作流节点请求
///
/// Properties:
/// * [nodeId] - 节点唯一标识
/// * [type] - 节点类型
/// * [name] - 节点名称
/// * [positionX] - 节点位置X坐标
/// * [positionY] - 节点位置Y坐标
/// * [config] - 节点配置参数
/// * [errorHandling]
@BuiltValue()
abstract class AddNodeRequest
    implements Built<AddNodeRequest, AddNodeRequestBuilder> {
  /// 节点唯一标识
  @BuiltValueField(wireName: r'nodeId')
  String get nodeId;

  /// 节点类型
  @BuiltValueField(wireName: r'type')
  AddNodeRequestTypeEnum get type;
  // enum typeEnum {  START,  WEBHOOK,  SCHEDULE,  LLM,  KNOWLEDGE_RETRIEVAL,  TEXT_EMBEDDING,  INTENT_RECOGNITION,  ENTITY_EXTRACTION,  CONDITION,  SWITCH,  LOOP,  PARALLEL,  MERGE,  VARIABLE_SET,  VARIABLE_GET,  JSON_PARSE,  TEMPLATE,  CODE,  HTTP_REQUEST,  DATABASE_QUERY,  FILE_READ,  FILE_WRITE,  RESPONSE,  END,  };

  /// 节点名称
  @BuiltValueField(wireName: r'name')
  String get name;

  /// 节点位置X坐标
  @BuiltValueField(wireName: r'positionX')
  int? get positionX;

  /// 节点位置Y坐标
  @BuiltValueField(wireName: r'positionY')
  int? get positionY;

  /// 节点配置参数
  @BuiltValueField(wireName: r'config')
  BuiltMap<String, JsonObject>? get config;

  @BuiltValueField(wireName: r'errorHandling')
  ErrorHandlingConfigDTO? get errorHandling;

  AddNodeRequest._();

  factory AddNodeRequest([void updates(AddNodeRequestBuilder b)]) =
      _$AddNodeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddNodeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddNodeRequest> get serializer =>
      _$AddNodeRequestSerializer();
}

class _$AddNodeRequestSerializer
    implements PrimitiveSerializer<AddNodeRequest> {
  @override
  final Iterable<Type> types = const [AddNodeRequest, _$AddNodeRequest];

  @override
  final String wireName = r'AddNodeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddNodeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'nodeId';
    yield serializers.serialize(
      object.nodeId,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(AddNodeRequestTypeEnum),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.positionX != null) {
      yield r'positionX';
      yield serializers.serialize(
        object.positionX,
        specifiedType: const FullType(int),
      );
    }
    if (object.positionY != null) {
      yield r'positionY';
      yield serializers.serialize(
        object.positionY,
        specifiedType: const FullType(int),
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
        specifiedType: const FullType(ErrorHandlingConfigDTO),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AddNodeRequest object, {
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
    required AddNodeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'nodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nodeId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AddNodeRequestTypeEnum),
          ) as AddNodeRequestTypeEnum;
          result.type = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'positionX':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.positionX = valueDes;
          break;
        case r'positionY':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.positionY = valueDes;
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
            specifiedType: const FullType(ErrorHandlingConfigDTO),
          ) as ErrorHandlingConfigDTO;
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
  AddNodeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddNodeRequestBuilder();
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

class AddNodeRequestTypeEnum extends EnumClass {
  /// 节点类型
  @BuiltValueEnumConst(wireName: r'START')
  static const AddNodeRequestTypeEnum START = _$addNodeRequestTypeEnum_START;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'WEBHOOK')
  static const AddNodeRequestTypeEnum WEBHOOK =
      _$addNodeRequestTypeEnum_WEBHOOK;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'SCHEDULE')
  static const AddNodeRequestTypeEnum SCHEDULE =
      _$addNodeRequestTypeEnum_SCHEDULE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LLM')
  static const AddNodeRequestTypeEnum LLM = _$addNodeRequestTypeEnum_LLM;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'KNOWLEDGE_RETRIEVAL')
  static const AddNodeRequestTypeEnum KNOWLEDGE_RETRIEVAL =
      _$addNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'TEXT_EMBEDDING')
  static const AddNodeRequestTypeEnum TEXT_EMBEDDING =
      _$addNodeRequestTypeEnum_TEXT_EMBEDDING;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'INTENT_RECOGNITION')
  static const AddNodeRequestTypeEnum INTENT_RECOGNITION =
      _$addNodeRequestTypeEnum_INTENT_RECOGNITION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'ENTITY_EXTRACTION')
  static const AddNodeRequestTypeEnum ENTITY_EXTRACTION =
      _$addNodeRequestTypeEnum_ENTITY_EXTRACTION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'CONDITION')
  static const AddNodeRequestTypeEnum CONDITION =
      _$addNodeRequestTypeEnum_CONDITION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'SWITCH')
  static const AddNodeRequestTypeEnum SWITCH = _$addNodeRequestTypeEnum_SWITCH;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LOOP')
  static const AddNodeRequestTypeEnum LOOP = _$addNodeRequestTypeEnum_LOOP;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'PARALLEL')
  static const AddNodeRequestTypeEnum PARALLEL =
      _$addNodeRequestTypeEnum_PARALLEL;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'MERGE')
  static const AddNodeRequestTypeEnum MERGE = _$addNodeRequestTypeEnum_MERGE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'VARIABLE_SET')
  static const AddNodeRequestTypeEnum VARIABLE_SET =
      _$addNodeRequestTypeEnum_VARIABLE_SET;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'VARIABLE_GET')
  static const AddNodeRequestTypeEnum VARIABLE_GET =
      _$addNodeRequestTypeEnum_VARIABLE_GET;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'JSON_PARSE')
  static const AddNodeRequestTypeEnum JSON_PARSE =
      _$addNodeRequestTypeEnum_JSON_PARSE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'TEMPLATE')
  static const AddNodeRequestTypeEnum TEMPLATE =
      _$addNodeRequestTypeEnum_TEMPLATE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'CODE')
  static const AddNodeRequestTypeEnum CODE = _$addNodeRequestTypeEnum_CODE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'HTTP_REQUEST')
  static const AddNodeRequestTypeEnum HTTP_REQUEST =
      _$addNodeRequestTypeEnum_HTTP_REQUEST;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'DATABASE_QUERY')
  static const AddNodeRequestTypeEnum DATABASE_QUERY =
      _$addNodeRequestTypeEnum_DATABASE_QUERY;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'FILE_READ')
  static const AddNodeRequestTypeEnum FILE_READ =
      _$addNodeRequestTypeEnum_FILE_READ;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'FILE_WRITE')
  static const AddNodeRequestTypeEnum FILE_WRITE =
      _$addNodeRequestTypeEnum_FILE_WRITE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'RESPONSE')
  static const AddNodeRequestTypeEnum RESPONSE =
      _$addNodeRequestTypeEnum_RESPONSE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'END')
  static const AddNodeRequestTypeEnum END = _$addNodeRequestTypeEnum_END;

  static Serializer<AddNodeRequestTypeEnum> get serializer =>
      _$addNodeRequestTypeEnumSerializer;

  const AddNodeRequestTypeEnum._(String name) : super(name);

  static BuiltSet<AddNodeRequestTypeEnum> get values =>
      _$addNodeRequestTypeEnumValues;
  static AddNodeRequestTypeEnum valueOf(String name) =>
      _$addNodeRequestTypeEnumValueOf(name);
}
