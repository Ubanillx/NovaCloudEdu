//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/config_field_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'node_type_response.g.dart';

/// 节点类型响应
///
/// Properties:
/// * [type] - 节点类型枚举值
/// * [description] - 节点类型描述
/// * [category] - 节点分类
/// * [icon] - 节点图标
/// * [configFields] - 配置参数模板
@BuiltValue()
abstract class NodeTypeResponse
    implements Built<NodeTypeResponse, NodeTypeResponseBuilder> {
  /// 节点类型枚举值
  @BuiltValueField(wireName: r'type')
  String? get type;

  /// 节点类型描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 节点分类
  @BuiltValueField(wireName: r'category')
  String? get category;

  /// 节点图标
  @BuiltValueField(wireName: r'icon')
  String? get icon;

  /// 配置参数模板
  @BuiltValueField(wireName: r'configFields')
  BuiltList<ConfigFieldDTO>? get configFields;

  NodeTypeResponse._();

  factory NodeTypeResponse([void updates(NodeTypeResponseBuilder b)]) =
      _$NodeTypeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NodeTypeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NodeTypeResponse> get serializer =>
      _$NodeTypeResponseSerializer();
}

class _$NodeTypeResponseSerializer
    implements PrimitiveSerializer<NodeTypeResponse> {
  @override
  final Iterable<Type> types = const [NodeTypeResponse, _$NodeTypeResponse];

  @override
  final String wireName = r'NodeTypeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NodeTypeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.icon != null) {
      yield r'icon';
      yield serializers.serialize(
        object.icon,
        specifiedType: const FullType(String),
      );
    }
    if (object.configFields != null) {
      yield r'configFields';
      yield serializers.serialize(
        object.configFields,
        specifiedType: const FullType(BuiltList, [FullType(ConfigFieldDTO)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NodeTypeResponse object, {
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
    required NodeTypeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icon = valueDes;
          break;
        case r'configFields':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(ConfigFieldDTO)]),
          ) as BuiltList<ConfigFieldDTO>;
          result.configFields.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NodeTypeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NodeTypeResponseBuilder();
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
