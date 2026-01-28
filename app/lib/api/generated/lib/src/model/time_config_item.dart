//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'time_config_item.g.dart';

/// TimeConfigItem
///
/// Properties:
/// * [section]
/// * [start]
/// * [end]
@BuiltValue()
abstract class TimeConfigItem
    implements Built<TimeConfigItem, TimeConfigItemBuilder> {
  @BuiltValueField(wireName: r'section')
  int? get section;

  @BuiltValueField(wireName: r'start')
  String? get start;

  @BuiltValueField(wireName: r'end')
  String? get end;

  TimeConfigItem._();

  factory TimeConfigItem([void updates(TimeConfigItemBuilder b)]) =
      _$TimeConfigItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TimeConfigItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TimeConfigItem> get serializer =>
      _$TimeConfigItemSerializer();
}

class _$TimeConfigItemSerializer
    implements PrimitiveSerializer<TimeConfigItem> {
  @override
  final Iterable<Type> types = const [TimeConfigItem, _$TimeConfigItem];

  @override
  final String wireName = r'TimeConfigItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TimeConfigItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.section != null) {
      yield r'section';
      yield serializers.serialize(
        object.section,
        specifiedType: const FullType(int),
      );
    }
    if (object.start != null) {
      yield r'start';
      yield serializers.serialize(
        object.start,
        specifiedType: const FullType(String),
      );
    }
    if (object.end != null) {
      yield r'end';
      yield serializers.serialize(
        object.end,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TimeConfigItem object, {
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
    required TimeConfigItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'section':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.section = valueDes;
          break;
        case r'start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.start = valueDes;
          break;
        case r'end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.end = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TimeConfigItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TimeConfigItemBuilder();
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
