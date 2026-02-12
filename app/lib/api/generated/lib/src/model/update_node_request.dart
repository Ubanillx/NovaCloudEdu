//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/error_handling_config_dto.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_node_request.g.dart';

/// 更新工作流节点请求
///
/// Properties:
/// * [type] - 节点类型
/// * [name] - 节点名称
/// * [positionX] - 节点位置X坐标
/// * [positionY] - 节点位置Y坐标
/// * [config] - 节点配置参数
/// * [errorHandling]
@BuiltValue()
abstract class UpdateNodeRequest
    implements Built<UpdateNodeRequest, UpdateNodeRequestBuilder> {
  /// 节点类型
  @BuiltValueField(wireName: r'type')
  UpdateNodeRequestTypeEnum? get type;
  // enum typeEnum {  START,  WEBHOOK,  SCHEDULE,  LLM,  KNOWLEDGE_RETRIEVAL,  TEXT_EMBEDDING,  INTENT_RECOGNITION,  ENTITY_EXTRACTION,  CONDITION,  SWITCH,  LOOP,  LOOP_START,  LOOP_END,  PARALLEL,  MERGE,  VARIABLE_SET,  VARIABLE_GET,  JSON_PARSE,  TEMPLATE,  CODE,  HTTP_REQUEST,  DATABASE_QUERY,  FILE_READ,  FILE_WRITE,  RESPONSE,  END,  };

  /// 节点名称
  @BuiltValueField(wireName: r'name')
  String? get name;

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

  UpdateNodeRequest._();

  factory UpdateNodeRequest([void updates(UpdateNodeRequestBuilder b)]) =
      _$UpdateNodeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateNodeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateNodeRequest> get serializer =>
      _$UpdateNodeRequestSerializer();
}

class _$UpdateNodeRequestSerializer
    implements PrimitiveSerializer<UpdateNodeRequest> {
  @override
  final Iterable<Type> types = const [UpdateNodeRequest, _$UpdateNodeRequest];

  @override
  final String wireName = r'UpdateNodeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateNodeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(UpdateNodeRequestTypeEnum),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
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
    UpdateNodeRequest object, {
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
    required UpdateNodeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateNodeRequestTypeEnum),
          ) as UpdateNodeRequestTypeEnum;
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
  UpdateNodeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateNodeRequestBuilder();
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

class UpdateNodeRequestTypeEnum extends EnumClass {
  /// 节点类型
  @BuiltValueEnumConst(wireName: r'START')
  static const UpdateNodeRequestTypeEnum START =
      _$updateNodeRequestTypeEnum_START;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'WEBHOOK')
  static const UpdateNodeRequestTypeEnum WEBHOOK =
      _$updateNodeRequestTypeEnum_WEBHOOK;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'SCHEDULE')
  static const UpdateNodeRequestTypeEnum SCHEDULE =
      _$updateNodeRequestTypeEnum_SCHEDULE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LLM')
  static const UpdateNodeRequestTypeEnum LLM = _$updateNodeRequestTypeEnum_LLM;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'KNOWLEDGE_RETRIEVAL')
  static const UpdateNodeRequestTypeEnum KNOWLEDGE_RETRIEVAL =
      _$updateNodeRequestTypeEnum_KNOWLEDGE_RETRIEVAL;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'TEXT_EMBEDDING')
  static const UpdateNodeRequestTypeEnum TEXT_EMBEDDING =
      _$updateNodeRequestTypeEnum_TEXT_EMBEDDING;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'INTENT_RECOGNITION')
  static const UpdateNodeRequestTypeEnum INTENT_RECOGNITION =
      _$updateNodeRequestTypeEnum_INTENT_RECOGNITION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'ENTITY_EXTRACTION')
  static const UpdateNodeRequestTypeEnum ENTITY_EXTRACTION =
      _$updateNodeRequestTypeEnum_ENTITY_EXTRACTION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'CONDITION')
  static const UpdateNodeRequestTypeEnum CONDITION =
      _$updateNodeRequestTypeEnum_CONDITION;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'SWITCH')
  static const UpdateNodeRequestTypeEnum SWITCH =
      _$updateNodeRequestTypeEnum_SWITCH;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LOOP')
  static const UpdateNodeRequestTypeEnum LOOP =
      _$updateNodeRequestTypeEnum_LOOP;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LOOP_START')
  static const UpdateNodeRequestTypeEnum LOOP_START =
      _$updateNodeRequestTypeEnum_LOOP_START;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'LOOP_END')
  static const UpdateNodeRequestTypeEnum LOOP_END =
      _$updateNodeRequestTypeEnum_LOOP_END;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'PARALLEL')
  static const UpdateNodeRequestTypeEnum PARALLEL =
      _$updateNodeRequestTypeEnum_PARALLEL;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'MERGE')
  static const UpdateNodeRequestTypeEnum MERGE =
      _$updateNodeRequestTypeEnum_MERGE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'VARIABLE_SET')
  static const UpdateNodeRequestTypeEnum VARIABLE_SET =
      _$updateNodeRequestTypeEnum_VARIABLE_SET;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'VARIABLE_GET')
  static const UpdateNodeRequestTypeEnum VARIABLE_GET =
      _$updateNodeRequestTypeEnum_VARIABLE_GET;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'JSON_PARSE')
  static const UpdateNodeRequestTypeEnum JSON_PARSE =
      _$updateNodeRequestTypeEnum_JSON_PARSE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'TEMPLATE')
  static const UpdateNodeRequestTypeEnum TEMPLATE =
      _$updateNodeRequestTypeEnum_TEMPLATE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'CODE')
  static const UpdateNodeRequestTypeEnum CODE =
      _$updateNodeRequestTypeEnum_CODE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'HTTP_REQUEST')
  static const UpdateNodeRequestTypeEnum HTTP_REQUEST =
      _$updateNodeRequestTypeEnum_HTTP_REQUEST;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'DATABASE_QUERY')
  static const UpdateNodeRequestTypeEnum DATABASE_QUERY =
      _$updateNodeRequestTypeEnum_DATABASE_QUERY;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'FILE_READ')
  static const UpdateNodeRequestTypeEnum FILE_READ =
      _$updateNodeRequestTypeEnum_FILE_READ;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'FILE_WRITE')
  static const UpdateNodeRequestTypeEnum FILE_WRITE =
      _$updateNodeRequestTypeEnum_FILE_WRITE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'RESPONSE')
  static const UpdateNodeRequestTypeEnum RESPONSE =
      _$updateNodeRequestTypeEnum_RESPONSE;

  /// 节点类型
  @BuiltValueEnumConst(wireName: r'END')
  static const UpdateNodeRequestTypeEnum END = _$updateNodeRequestTypeEnum_END;

  static Serializer<UpdateNodeRequestTypeEnum> get serializer =>
      _$updateNodeRequestTypeEnumSerializer;

  const UpdateNodeRequestTypeEnum._(String name) : super(name);

  static BuiltSet<UpdateNodeRequestTypeEnum> get values =>
      _$updateNodeRequestTypeEnumValues;
  static UpdateNodeRequestTypeEnum valueOf(String name) =>
      _$updateNodeRequestTypeEnumValueOf(name);
}
