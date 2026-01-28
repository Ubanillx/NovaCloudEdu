//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'group_id.g.dart';

/// GroupId
///
/// Properties:
/// * [value]
@BuiltValue()
abstract class GroupId implements Built<GroupId, GroupIdBuilder> {
  @BuiltValueField(wireName: r'value')
  int? get value;

  GroupId._();

  factory GroupId([void updates(GroupIdBuilder b)]) = _$GroupId;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GroupIdBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GroupId> get serializer => _$GroupIdSerializer();
}

class _$GroupIdSerializer implements PrimitiveSerializer<GroupId> {
  @override
  final Iterable<Type> types = const [GroupId, _$GroupId];

  @override
  final String wireName = r'GroupId';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GroupId object, {
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
    GroupId object, {
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
    required GroupIdBuilder result,
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
  GroupId deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GroupIdBuilder();
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
