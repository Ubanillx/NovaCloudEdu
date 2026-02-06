//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_map_string_string.g.dart';

/// BaseResponseMapStringString
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseMapStringString
    implements
        Built<BaseResponseMapStringString, BaseResponseMapStringStringBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltMap<String, String>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseMapStringString._();

  factory BaseResponseMapStringString(
          [void updates(BaseResponseMapStringStringBuilder b)]) =
      _$BaseResponseMapStringString;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseMapStringStringBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseMapStringString> get serializer =>
      _$BaseResponseMapStringStringSerializer();
}

class _$BaseResponseMapStringStringSerializer
    implements PrimitiveSerializer<BaseResponseMapStringString> {
  @override
  final Iterable<Type> types = const [
    BaseResponseMapStringString,
    _$BaseResponseMapStringString
  ];

  @override
  final String wireName = r'BaseResponseMapStringString';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseMapStringString object, {
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
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(String)]),
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
    BaseResponseMapStringString object, {
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
    required BaseResponseMapStringStringBuilder result,
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
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>;
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
  BaseResponseMapStringString deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseMapStringStringBuilder();
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
