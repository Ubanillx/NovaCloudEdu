//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_edge_request.g.dart';

/// 更新工作流连接线请求
///
/// Properties:
/// * [sourceNodeId] - 源节点ID
/// * [targetNodeId] - 目标节点ID
/// * [sourceHandle] - 源节点输出句柄
/// * [targetHandle] - 目标节点输入句柄
/// * [condition] - 条件表达式
/// * [label] - 连接线标签
@BuiltValue()
abstract class UpdateEdgeRequest
    implements Built<UpdateEdgeRequest, UpdateEdgeRequestBuilder> {
  /// 源节点ID
  @BuiltValueField(wireName: r'sourceNodeId')
  String? get sourceNodeId;

  /// 目标节点ID
  @BuiltValueField(wireName: r'targetNodeId')
  String? get targetNodeId;

  /// 源节点输出句柄
  @BuiltValueField(wireName: r'sourceHandle')
  String? get sourceHandle;

  /// 目标节点输入句柄
  @BuiltValueField(wireName: r'targetHandle')
  String? get targetHandle;

  /// 条件表达式
  @BuiltValueField(wireName: r'condition')
  String? get condition;

  /// 连接线标签
  @BuiltValueField(wireName: r'label')
  String? get label;

  UpdateEdgeRequest._();

  factory UpdateEdgeRequest([void updates(UpdateEdgeRequestBuilder b)]) =
      _$UpdateEdgeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateEdgeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateEdgeRequest> get serializer =>
      _$UpdateEdgeRequestSerializer();
}

class _$UpdateEdgeRequestSerializer
    implements PrimitiveSerializer<UpdateEdgeRequest> {
  @override
  final Iterable<Type> types = const [UpdateEdgeRequest, _$UpdateEdgeRequest];

  @override
  final String wireName = r'UpdateEdgeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateEdgeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.sourceNodeId != null) {
      yield r'sourceNodeId';
      yield serializers.serialize(
        object.sourceNodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetNodeId != null) {
      yield r'targetNodeId';
      yield serializers.serialize(
        object.targetNodeId,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceHandle != null) {
      yield r'sourceHandle';
      yield serializers.serialize(
        object.sourceHandle,
        specifiedType: const FullType(String),
      );
    }
    if (object.targetHandle != null) {
      yield r'targetHandle';
      yield serializers.serialize(
        object.targetHandle,
        specifiedType: const FullType(String),
      );
    }
    if (object.condition != null) {
      yield r'condition';
      yield serializers.serialize(
        object.condition,
        specifiedType: const FullType(String),
      );
    }
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateEdgeRequest object, {
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
    required UpdateEdgeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sourceNodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceNodeId = valueDes;
          break;
        case r'targetNodeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetNodeId = valueDes;
          break;
        case r'sourceHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceHandle = valueDes;
          break;
        case r'targetHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetHandle = valueDes;
          break;
        case r'condition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.condition = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateEdgeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateEdgeRequestBuilder();
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
