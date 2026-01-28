//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_workflow_request.g.dart';

/// 更新工作流基本信息请求
///
/// Properties:
/// * [name] - 工作流名称
/// * [description] - 工作流描述
@BuiltValue()
abstract class UpdateWorkflowRequest
    implements Built<UpdateWorkflowRequest, UpdateWorkflowRequestBuilder> {
  /// 工作流名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 工作流描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  UpdateWorkflowRequest._();

  factory UpdateWorkflowRequest(
      [void updates(UpdateWorkflowRequestBuilder b)]) = _$UpdateWorkflowRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateWorkflowRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateWorkflowRequest> get serializer =>
      _$UpdateWorkflowRequestSerializer();
}

class _$UpdateWorkflowRequestSerializer
    implements PrimitiveSerializer<UpdateWorkflowRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateWorkflowRequest,
    _$UpdateWorkflowRequest
  ];

  @override
  final String wireName = r'UpdateWorkflowRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateWorkflowRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateWorkflowRequest object, {
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
    required UpdateWorkflowRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateWorkflowRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateWorkflowRequestBuilder();
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
