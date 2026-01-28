//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/position_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/error_handling_config_dto.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_node_response.g.dart';

/// 工作流节点响应
///
/// Properties:
/// * [id] - 节点ID
/// * [type] - 节点类型
/// * [typeDescription] - 节点类型描述
/// * [name] - 节点名称
/// * [position]
/// * [config] - 节点配置参数
/// * [errorHandling]
@BuiltValue()
abstract class WorkflowNodeResponse
    implements Built<WorkflowNodeResponse, WorkflowNodeResponseBuilder> {
  /// 节点ID
  @BuiltValueField(wireName: r'id')
  String? get id;

  /// 节点类型
  @BuiltValueField(wireName: r'type')
  String? get type;

  /// 节点类型描述
  @BuiltValueField(wireName: r'typeDescription')
  String? get typeDescription;

  /// 节点名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'position')
  PositionDTO? get position;

  /// 节点配置参数
  @BuiltValueField(wireName: r'config')
  BuiltMap<String, JsonObject>? get config;

  @BuiltValueField(wireName: r'errorHandling')
  ErrorHandlingConfigDTO? get errorHandling;

  WorkflowNodeResponse._();

  factory WorkflowNodeResponse([void updates(WorkflowNodeResponseBuilder b)]) =
      _$WorkflowNodeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowNodeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowNodeResponse> get serializer =>
      _$WorkflowNodeResponseSerializer();
}

class _$WorkflowNodeResponseSerializer
    implements PrimitiveSerializer<WorkflowNodeResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowNodeResponse,
    _$WorkflowNodeResponse
  ];

  @override
  final String wireName = r'WorkflowNodeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowNodeResponse object, {
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
        specifiedType: const FullType(String),
      );
    }
    if (object.typeDescription != null) {
      yield r'typeDescription';
      yield serializers.serialize(
        object.typeDescription,
        specifiedType: const FullType(String),
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
        specifiedType: const FullType(PositionDTO),
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
    WorkflowNodeResponse object, {
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
    required WorkflowNodeResponseBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'typeDescription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.typeDescription = valueDes;
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
            specifiedType: const FullType(PositionDTO),
          ) as PositionDTO;
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
  WorkflowNodeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowNodeResponseBuilder();
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
