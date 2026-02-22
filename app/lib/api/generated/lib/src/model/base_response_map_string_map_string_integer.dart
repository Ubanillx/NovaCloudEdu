//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_map_string_map_string_integer.g.dart';

/// BaseResponseMapStringMapStringInteger
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseMapStringMapStringInteger
    implements
        Built<BaseResponseMapStringMapStringInteger,
            BaseResponseMapStringMapStringIntegerBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltMap<String, BuiltMap<String, int>>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseMapStringMapStringInteger._();

  factory BaseResponseMapStringMapStringInteger(
          [void updates(BaseResponseMapStringMapStringIntegerBuilder b)]) =
      _$BaseResponseMapStringMapStringInteger;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseMapStringMapStringIntegerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseMapStringMapStringInteger> get serializer =>
      _$BaseResponseMapStringMapStringIntegerSerializer();
}

class _$BaseResponseMapStringMapStringIntegerSerializer
    implements PrimitiveSerializer<BaseResponseMapStringMapStringInteger> {
  @override
  final Iterable<Type> types = const [
    BaseResponseMapStringMapStringInteger,
    _$BaseResponseMapStringMapStringInteger
  ];

  @override
  final String wireName = r'BaseResponseMapStringMapStringInteger';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseMapStringMapStringInteger object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltMap, [
          FullType(String),
          FullType(BuiltMap, [FullType(String), FullType(int)])
        ]),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseMapStringMapStringInteger object, {
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
    required BaseResponseMapStringMapStringIntegerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [
              FullType(String),
              FullType(BuiltMap, [FullType(String), FullType(int)])
            ]),
          ) as BuiltMap<String, BuiltMap<String, int>>;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseMapStringMapStringInteger deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseMapStringMapStringIntegerBuilder();
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
