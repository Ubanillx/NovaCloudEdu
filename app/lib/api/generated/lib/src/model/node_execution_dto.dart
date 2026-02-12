//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'node_execution_dto.g.dart';

/// 节点执行详情
///
/// Properties:
/// * [nodeId] - 节点ID
/// * [nodeName] - 节点名称
/// * [nodeType] - 节点类型
/// * [status] - 执行状态
/// * [input] - 节点输入数据
/// * [output] - 节点输出数据
/// * [errorMessage] - 错误信息
/// * [startTime] - 开始时间
/// * [endTime] - 结束时间
/// * [durationMs] - 耗时（毫秒）
@BuiltValue()
abstract class NodeExecutionDTO
    implements Built<NodeExecutionDTO, NodeExecutionDTOBuilder> {
  /// 节点ID
  @BuiltValueField(wireName: r'nodeId')
  String? get nodeId;

  /// 节点名称
  @BuiltValueField(wireName: r'nodeName')
  String? get nodeName;

  /// 节点类型
  @BuiltValueField(wireName: r'nodeType')
  String? get nodeType;

  /// 执行状态
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 节点输入数据
  @BuiltValueField(wireName: r'input')
  BuiltMap<String, JsonObject>? get input;

  /// 节点输出数据
  @BuiltValueField(wireName: r'output')
  BuiltMap<String, JsonObject>? get output;

  /// 错误信息
  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  /// 开始时间
  @BuiltValueField(wireName: r'startTime')
  DateTime? get startTime;

  /// 结束时间
  @BuiltValueField(wireName: r'endTime')
  DateTime? get endTime;

  /// 耗时（毫秒）
  @BuiltValueField(wireName: r'durationMs')
  int? get durationMs;

  NodeExecutionDTO._();

  factory NodeExecutionDTO([void updates(NodeExecutionDTOBuilder b)]) =
      _$NodeExecutionDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NodeExecutionDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NodeExecutionDTO> get serializer =>
      _$NodeExecutionDTOSerializer();
}

class _$NodeExecutionDTOSerializer
    implements PrimitiveSerializer<NodeExecutionDTO> {
  @override
  final Iterable<Type> types = const [NodeExecutionDTO, _$NodeExecutionDTO];

  @override
  final String wireName = r'NodeExecutionDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NodeExecutionDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    NodeExecutionDTO object, {
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
    required NodeExecutionDTOBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
          result.nodeType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NodeExecutionDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NodeExecutionDTOBuilder();
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
