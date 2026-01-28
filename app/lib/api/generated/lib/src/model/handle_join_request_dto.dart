//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'handle_join_request_dto.g.dart';

/// HandleJoinRequestDTO
///
/// Properties:
/// * [approve]
@BuiltValue()
abstract class HandleJoinRequestDTO
    implements Built<HandleJoinRequestDTO, HandleJoinRequestDTOBuilder> {
  @BuiltValueField(wireName: r'approve')
  bool get approve;

  HandleJoinRequestDTO._();

  factory HandleJoinRequestDTO([void updates(HandleJoinRequestDTOBuilder b)]) =
      _$HandleJoinRequestDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HandleJoinRequestDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HandleJoinRequestDTO> get serializer =>
      _$HandleJoinRequestDTOSerializer();
}

class _$HandleJoinRequestDTOSerializer
    implements PrimitiveSerializer<HandleJoinRequestDTO> {
  @override
  final Iterable<Type> types = const [
    HandleJoinRequestDTO,
    _$HandleJoinRequestDTO
  ];

  @override
  final String wireName = r'HandleJoinRequestDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HandleJoinRequestDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'approve';
    yield serializers.serialize(
      object.approve,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HandleJoinRequestDTO object, {
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
    required HandleJoinRequestDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'approve':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.approve = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HandleJoinRequestDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HandleJoinRequestDTOBuilder();
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
