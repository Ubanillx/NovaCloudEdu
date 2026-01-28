//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_variable_request.g.dart';

/// 更新工作流变量请求
///
/// Properties:
/// * [type] - 变量类型
/// * [defaultValue] - 默认值
/// * [description] - 变量描述
@BuiltValue()
abstract class UpdateVariableRequest
    implements Built<UpdateVariableRequest, UpdateVariableRequestBuilder> {
  /// 变量类型
  @BuiltValueField(wireName: r'type')
  UpdateVariableRequestTypeEnum? get type;
  // enum typeEnum {  string,  number,  boolean,  object,  array,  };

  /// 默认值
  @BuiltValueField(wireName: r'defaultValue')
  JsonObject? get defaultValue;

  /// 变量描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  UpdateVariableRequest._();

  factory UpdateVariableRequest(
      [void updates(UpdateVariableRequestBuilder b)]) = _$UpdateVariableRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateVariableRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateVariableRequest> get serializer =>
      _$UpdateVariableRequestSerializer();
}

class _$UpdateVariableRequestSerializer
    implements PrimitiveSerializer<UpdateVariableRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateVariableRequest,
    _$UpdateVariableRequest
  ];

  @override
  final String wireName = r'UpdateVariableRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateVariableRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(UpdateVariableRequestTypeEnum),
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
    UpdateVariableRequest object, {
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
    required UpdateVariableRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UpdateVariableRequestTypeEnum),
          ) as UpdateVariableRequestTypeEnum;
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
  UpdateVariableRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateVariableRequestBuilder();
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

class UpdateVariableRequestTypeEnum extends EnumClass {
  /// 变量类型
  @BuiltValueEnumConst(wireName: r'string')
  static const UpdateVariableRequestTypeEnum string =
      _$updateVariableRequestTypeEnum_string;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'number')
  static const UpdateVariableRequestTypeEnum number =
      _$updateVariableRequestTypeEnum_number;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'boolean')
  static const UpdateVariableRequestTypeEnum boolean =
      _$updateVariableRequestTypeEnum_boolean;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'object')
  static const UpdateVariableRequestTypeEnum object =
      _$updateVariableRequestTypeEnum_object;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'array')
  static const UpdateVariableRequestTypeEnum array =
      _$updateVariableRequestTypeEnum_array;

  static Serializer<UpdateVariableRequestTypeEnum> get serializer =>
      _$updateVariableRequestTypeEnumSerializer;

  const UpdateVariableRequestTypeEnum._(String name) : super(name);

  static BuiltSet<UpdateVariableRequestTypeEnum> get values =>
      _$updateVariableRequestTypeEnumValues;
  static UpdateVariableRequestTypeEnum valueOf(String name) =>
      _$updateVariableRequestTypeEnumValueOf(name);
}
