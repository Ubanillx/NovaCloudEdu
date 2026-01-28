//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'option_dto.g.dart';

/// 选项
///
/// Properties:
/// * [value] - 选项值
/// * [label] - 选项标签
@BuiltValue()
abstract class OptionDTO implements Built<OptionDTO, OptionDTOBuilder> {
  /// 选项值
  @BuiltValueField(wireName: r'value')
  String? get value;

  /// 选项标签
  @BuiltValueField(wireName: r'label')
  String? get label;

  OptionDTO._();

  factory OptionDTO([void updates(OptionDTOBuilder b)]) = _$OptionDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OptionDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OptionDTO> get serializer => _$OptionDTOSerializer();
}

class _$OptionDTOSerializer implements PrimitiveSerializer<OptionDTO> {
  @override
  final Iterable<Type> types = const [OptionDTO, _$OptionDTO];

  @override
  final String wireName = r'OptionDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OptionDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
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
    OptionDTO object, {
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
    required OptionDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
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
  OptionDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OptionDTOBuilder();
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
