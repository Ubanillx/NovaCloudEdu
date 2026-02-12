//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'skill_output_vo.g.dart';

/// SkillOutputVO
///
/// Properties:
/// * [name]
/// * [sourceVariable]
@BuiltValue()
abstract class SkillOutputVO
    implements Built<SkillOutputVO, SkillOutputVOBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'sourceVariable')
  String? get sourceVariable;

  SkillOutputVO._();

  factory SkillOutputVO([void updates(SkillOutputVOBuilder b)]) =
      _$SkillOutputVO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SkillOutputVOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SkillOutputVO> get serializer =>
      _$SkillOutputVOSerializer();
}

class _$SkillOutputVOSerializer implements PrimitiveSerializer<SkillOutputVO> {
  @override
  final Iterable<Type> types = const [SkillOutputVO, _$SkillOutputVO];

  @override
  final String wireName = r'SkillOutputVO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SkillOutputVO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.sourceVariable != null) {
      yield r'sourceVariable';
      yield serializers.serialize(
        object.sourceVariable,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SkillOutputVO object, {
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
    required SkillOutputVOBuilder result,
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
        case r'sourceVariable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sourceVariable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SkillOutputVO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SkillOutputVOBuilder();
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
