//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_variable_request.g.dart';

/// 添加工作流变量请求
///
/// Properties:
/// * [name] - 变量名称
/// * [type] - 变量类型
/// * [defaultValue] - 默认值
/// * [description] - 变量描述
@BuiltValue()
abstract class AddVariableRequest
    implements Built<AddVariableRequest, AddVariableRequestBuilder> {
  /// 变量名称
  @BuiltValueField(wireName: r'name')
  String get name;

  /// 变量类型
  @BuiltValueField(wireName: r'type')
  AddVariableRequestTypeEnum get type;
  // enum typeEnum {  string,  number,  boolean,  object,  array,  };

  /// 默认值
  @BuiltValueField(wireName: r'defaultValue')
  JsonObject? get defaultValue;

  /// 变量描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  AddVariableRequest._();

  factory AddVariableRequest([void updates(AddVariableRequestBuilder b)]) =
      _$AddVariableRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddVariableRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddVariableRequest> get serializer =>
      _$AddVariableRequestSerializer();
}

class _$AddVariableRequestSerializer
    implements PrimitiveSerializer<AddVariableRequest> {
  @override
  final Iterable<Type> types = const [AddVariableRequest, _$AddVariableRequest];

  @override
  final String wireName = r'AddVariableRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddVariableRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(AddVariableRequestTypeEnum),
    );
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
    AddVariableRequest object, {
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
    required AddVariableRequestBuilder result,
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
            specifiedType: const FullType(AddVariableRequestTypeEnum),
          ) as AddVariableRequestTypeEnum;
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
  AddVariableRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddVariableRequestBuilder();
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

class AddVariableRequestTypeEnum extends EnumClass {
  /// 变量类型
  @BuiltValueEnumConst(wireName: r'string')
  static const AddVariableRequestTypeEnum string =
      _$addVariableRequestTypeEnum_string;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'number')
  static const AddVariableRequestTypeEnum number =
      _$addVariableRequestTypeEnum_number;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'boolean')
  static const AddVariableRequestTypeEnum boolean =
      _$addVariableRequestTypeEnum_boolean;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'object')
  static const AddVariableRequestTypeEnum object =
      _$addVariableRequestTypeEnum_object;

  /// 变量类型
  @BuiltValueEnumConst(wireName: r'array')
  static const AddVariableRequestTypeEnum array =
      _$addVariableRequestTypeEnum_array;

  static Serializer<AddVariableRequestTypeEnum> get serializer =>
      _$addVariableRequestTypeEnumSerializer;

  const AddVariableRequestTypeEnum._(String name) : super(name);

  static BuiltSet<AddVariableRequestTypeEnum> get values =>
      _$addVariableRequestTypeEnumValues;
  static AddVariableRequestTypeEnum valueOf(String name) =>
      _$addVariableRequestTypeEnumValueOf(name);
}
