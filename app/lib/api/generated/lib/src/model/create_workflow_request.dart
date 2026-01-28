//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_workflow_request.g.dart';

/// 创建工作流请求
///
/// Properties:
/// * [userId] - 用户ID
/// * [name] - 工作流名称
/// * [description] - 工作流描述
@BuiltValue()
abstract class CreateWorkflowRequest
    implements Built<CreateWorkflowRequest, CreateWorkflowRequestBuilder> {
  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int get userId;

  /// 工作流名称
  @BuiltValueField(wireName: r'name')
  String get name;

  /// 工作流描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  CreateWorkflowRequest._();

  factory CreateWorkflowRequest(
      [void updates(CreateWorkflowRequestBuilder b)]) = _$CreateWorkflowRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateWorkflowRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateWorkflowRequest> get serializer =>
      _$CreateWorkflowRequestSerializer();
}

class _$CreateWorkflowRequestSerializer
    implements PrimitiveSerializer<CreateWorkflowRequest> {
  @override
  final Iterable<Type> types = const [
    CreateWorkflowRequest,
    _$CreateWorkflowRequest
  ];

  @override
  final String wireName = r'CreateWorkflowRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateWorkflowRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
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
    CreateWorkflowRequest object, {
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
    required CreateWorkflowRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
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
  CreateWorkflowRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateWorkflowRequestBuilder();
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
