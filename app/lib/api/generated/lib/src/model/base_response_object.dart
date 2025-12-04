//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_object.g.dart';

/// BaseResponseObject
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseObject
    implements Built<BaseResponseObject, BaseResponseObjectBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  JsonObject? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseObject._();

  factory BaseResponseObject([void updates(BaseResponseObjectBuilder b)]) =
      _$BaseResponseObject;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseObjectBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseObject> get serializer =>
      _$BaseResponseObjectSerializer();
}

class _$BaseResponseObjectSerializer
    implements PrimitiveSerializer<BaseResponseObject> {
  @override
  final Iterable<Type> types = const [BaseResponseObject, _$BaseResponseObject];

  @override
  final String wireName = r'BaseResponseObject';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseObject object, {
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
        specifiedType: const FullType(JsonObject),
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
    BaseResponseObject object, {
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
    required BaseResponseObjectBuilder result,
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
            specifiedType: const FullType(JsonObject),
          ) as JsonObject;
          result.data = valueDes;
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
  BaseResponseObject deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseObjectBuilder();
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
