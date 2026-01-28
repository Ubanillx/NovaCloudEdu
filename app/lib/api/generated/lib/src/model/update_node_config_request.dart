//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_node_config_request.g.dart';

/// 更新节点配置请求
///
/// Properties:
/// * [config] - 节点配置参数
@BuiltValue()
abstract class UpdateNodeConfigRequest
    implements Built<UpdateNodeConfigRequest, UpdateNodeConfigRequestBuilder> {
  /// 节点配置参数
  @BuiltValueField(wireName: r'config')
  BuiltMap<String, JsonObject> get config;

  UpdateNodeConfigRequest._();

  factory UpdateNodeConfigRequest(
          [void updates(UpdateNodeConfigRequestBuilder b)]) =
      _$UpdateNodeConfigRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateNodeConfigRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateNodeConfigRequest> get serializer =>
      _$UpdateNodeConfigRequestSerializer();
}

class _$UpdateNodeConfigRequestSerializer
    implements PrimitiveSerializer<UpdateNodeConfigRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateNodeConfigRequest,
    _$UpdateNodeConfigRequest
  ];

  @override
  final String wireName = r'UpdateNodeConfigRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateNodeConfigRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'config';
    yield serializers.serialize(
      object.config,
      specifiedType:
          const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateNodeConfigRequest object, {
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
    required UpdateNodeConfigRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'config':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.config.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateNodeConfigRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateNodeConfigRequestBuilder();
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
