//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'position_dto.g.dart';

/// 节点位置
///
/// Properties:
/// * [x] - X坐标
/// * [y] - Y坐标
@BuiltValue()
abstract class PositionDTO implements Built<PositionDTO, PositionDTOBuilder> {
  /// X坐标
  @BuiltValueField(wireName: r'x')
  int? get x;

  /// Y坐标
  @BuiltValueField(wireName: r'y')
  int? get y;

  PositionDTO._();

  factory PositionDTO([void updates(PositionDTOBuilder b)]) = _$PositionDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PositionDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PositionDTO> get serializer => _$PositionDTOSerializer();
}

class _$PositionDTOSerializer implements PrimitiveSerializer<PositionDTO> {
  @override
  final Iterable<Type> types = const [PositionDTO, _$PositionDTO];

  @override
  final String wireName = r'PositionDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PositionDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.x != null) {
      yield r'x';
      yield serializers.serialize(
        object.x,
        specifiedType: const FullType(int),
      );
    }
    if (object.y != null) {
      yield r'y';
      yield serializers.serialize(
        object.y,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PositionDTO object, {
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
    required PositionDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'x':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.x = valueDes;
          break;
        case r'y':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.y = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PositionDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PositionDTOBuilder();
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
