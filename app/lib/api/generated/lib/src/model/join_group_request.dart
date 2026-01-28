//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'join_group_request.g.dart';

/// JoinGroupRequest
///
/// Properties:
/// * [message]
@BuiltValue()
abstract class JoinGroupRequest
    implements Built<JoinGroupRequest, JoinGroupRequestBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  JoinGroupRequest._();

  factory JoinGroupRequest([void updates(JoinGroupRequestBuilder b)]) =
      _$JoinGroupRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JoinGroupRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JoinGroupRequest> get serializer =>
      _$JoinGroupRequestSerializer();
}

class _$JoinGroupRequestSerializer
    implements PrimitiveSerializer<JoinGroupRequest> {
  @override
  final Iterable<Type> types = const [JoinGroupRequest, _$JoinGroupRequest];

  @override
  final String wireName = r'JoinGroupRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JoinGroupRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    JoinGroupRequest object, {
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
    required JoinGroupRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  JoinGroupRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JoinGroupRequestBuilder();
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
