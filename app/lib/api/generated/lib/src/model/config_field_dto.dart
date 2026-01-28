//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/option_dto.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'config_field_dto.g.dart';

/// 配置字段定义
///
/// Properties:
/// * [name] - 字段名
/// * [label] - 字段标签
/// * [fieldType] - 字段类型
/// * [required_] - 是否必填
/// * [defaultValue] - 默认值
/// * [description] - 字段描述
/// * [options] - 选项列表（select类型时使用）
/// * [validation] - 验证规则
@BuiltValue()
abstract class ConfigFieldDTO
    implements Built<ConfigFieldDTO, ConfigFieldDTOBuilder> {
  /// 字段名
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 字段标签
  @BuiltValueField(wireName: r'label')
  String? get label;

  /// 字段类型
  @BuiltValueField(wireName: r'fieldType')
  ConfigFieldDTOFieldTypeEnum? get fieldType;
  // enum fieldTypeEnum {  text,  textarea,  number,  select,  boolean,  json,  };

  /// 是否必填
  @BuiltValueField(wireName: r'required')
  bool? get required_;

  /// 默认值
  @BuiltValueField(wireName: r'defaultValue')
  JsonObject? get defaultValue;

  /// 字段描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 选项列表（select类型时使用）
  @BuiltValueField(wireName: r'options')
  BuiltList<OptionDTO>? get options;

  /// 验证规则
  @BuiltValueField(wireName: r'validation')
  BuiltMap<String, JsonObject>? get validation;

  ConfigFieldDTO._();

  factory ConfigFieldDTO([void updates(ConfigFieldDTOBuilder b)]) =
      _$ConfigFieldDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfigFieldDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfigFieldDTO> get serializer =>
      _$ConfigFieldDTOSerializer();
}

class _$ConfigFieldDTOSerializer
    implements PrimitiveSerializer<ConfigFieldDTO> {
  @override
  final Iterable<Type> types = const [ConfigFieldDTO, _$ConfigFieldDTO];

  @override
  final String wireName = r'ConfigFieldDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfigFieldDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    if (object.fieldType != null) {
      yield r'fieldType';
      yield serializers.serialize(
        object.fieldType,
        specifiedType: const FullType(ConfigFieldDTOFieldTypeEnum),
      );
    }
    if (object.required_ != null) {
      yield r'required';
      yield serializers.serialize(
        object.required_,
        specifiedType: const FullType(bool),
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
    if (object.options != null) {
      yield r'options';
      yield serializers.serialize(
        object.options,
        specifiedType: const FullType(BuiltList, [FullType(OptionDTO)]),
      );
    }
    if (object.validation != null) {
      yield r'validation';
      yield serializers.serialize(
        object.validation,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfigFieldDTO object, {
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
    required ConfigFieldDTOBuilder result,
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
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'fieldType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ConfigFieldDTOFieldTypeEnum),
          ) as ConfigFieldDTOFieldTypeEnum;
          result.fieldType = valueDes;
          break;
        case r'required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.required_ = valueDes;
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
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OptionDTO)]),
          ) as BuiltList<OptionDTO>;
          result.options.replace(valueDes);
          break;
        case r'validation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType(JsonObject)]),
          ) as BuiltMap<String, JsonObject>;
          result.validation.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConfigFieldDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfigFieldDTOBuilder();
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

class ConfigFieldDTOFieldTypeEnum extends EnumClass {
  /// 字段类型
  @BuiltValueEnumConst(wireName: r'text')
  static const ConfigFieldDTOFieldTypeEnum text =
      _$configFieldDTOFieldTypeEnum_text;

  /// 字段类型
  @BuiltValueEnumConst(wireName: r'textarea')
  static const ConfigFieldDTOFieldTypeEnum textarea =
      _$configFieldDTOFieldTypeEnum_textarea;

  /// 字段类型
  @BuiltValueEnumConst(wireName: r'number')
  static const ConfigFieldDTOFieldTypeEnum number =
      _$configFieldDTOFieldTypeEnum_number;

  /// 字段类型
  @BuiltValueEnumConst(wireName: r'select')
  static const ConfigFieldDTOFieldTypeEnum select =
      _$configFieldDTOFieldTypeEnum_select;

  /// 字段类型
  @BuiltValueEnumConst(wireName: r'boolean')
  static const ConfigFieldDTOFieldTypeEnum boolean =
      _$configFieldDTOFieldTypeEnum_boolean;

  /// 字段类型
  @BuiltValueEnumConst(wireName: r'json')
  static const ConfigFieldDTOFieldTypeEnum json =
      _$configFieldDTOFieldTypeEnum_json;

  static Serializer<ConfigFieldDTOFieldTypeEnum> get serializer =>
      _$configFieldDTOFieldTypeEnumSerializer;

  const ConfigFieldDTOFieldTypeEnum._(String name) : super(name);

  static BuiltSet<ConfigFieldDTOFieldTypeEnum> get values =>
      _$configFieldDTOFieldTypeEnumValues;
  static ConfigFieldDTOFieldTypeEnum valueOf(String name) =>
      _$configFieldDTOFieldTypeEnumValueOf(name);
}
