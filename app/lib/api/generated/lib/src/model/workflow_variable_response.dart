//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_variable_response.g.dart';

/// 工作流变量响应
///
/// Properties:
/// * [name] - 变量名称
/// * [type] - 变量类型
/// * [defaultValue] - 默认值
/// * [description] - 变量描述
@BuiltValue()
abstract class WorkflowVariableResponse
    implements
        Built<WorkflowVariableResponse, WorkflowVariableResponseBuilder> {
  /// 变量名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 变量类型
  @BuiltValueField(wireName: r'type')
  String? get type;

  /// 默认值
  @BuiltValueField(wireName: r'defaultValue')
  JsonObject? get defaultValue;

  /// 变量描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  WorkflowVariableResponse._();

  factory WorkflowVariableResponse(
          [void updates(WorkflowVariableResponseBuilder b)]) =
      _$WorkflowVariableResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowVariableResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowVariableResponse> get serializer =>
      _$WorkflowVariableResponseSerializer();
}

class _$WorkflowVariableResponseSerializer
    implements PrimitiveSerializer<WorkflowVariableResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowVariableResponse,
    _$WorkflowVariableResponse
  ];

  @override
  final String wireName = r'WorkflowVariableResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowVariableResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    if (object.defaultValue != null) {
      yield r'defaultValue';
      yield serializers.serialize(
        object.defaultValue,
        specifiedType: const FullType(JsonObject),
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
    WorkflowVariableResponse object, {
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
    required WorkflowVariableResponseBuilder result,
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'defaultValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.defaultValue = valueDes;
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
  WorkflowVariableResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowVariableResponseBuilder();
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
