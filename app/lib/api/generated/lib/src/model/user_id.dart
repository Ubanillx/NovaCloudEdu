//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_id.g.dart';

/// UserId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class UserId implements Built<UserId, UserIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  UserId._();

  factory UserId([void updates(UserIdBuilder b)]) = _$UserId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserId> get serializer => _$UserIdSerializer();
}

class _$UserIdSerializer implements PrimitiveSerializer<UserId> {
  @override
  final Iterable<Type> types = const [UserId, _$UserId];

  @override
  final String wireName = r'UserId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserId object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserId object, {
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
    required UserIdBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserIdBuilder();
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
