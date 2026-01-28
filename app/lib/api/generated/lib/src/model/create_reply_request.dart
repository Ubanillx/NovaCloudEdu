//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_reply_request.g.dart';

/// CreateReplyRequest
///
/// Properties:
/// * [content]
@BuiltValue()
abstract class CreateReplyRequest
    implements Built<CreateReplyRequest, CreateReplyRequestBuilder> {
  @BuiltValueField(wireName: r'content')
  String get content;

  CreateReplyRequest._();

  factory CreateReplyRequest([void updates(CreateReplyRequestBuilder b)]) =
      _$CreateReplyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateReplyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateReplyRequest> get serializer =>
      _$CreateReplyRequestSerializer();
}

class _$CreateReplyRequestSerializer
    implements PrimitiveSerializer<CreateReplyRequest> {
  @override
  final Iterable<Type> types = const [CreateReplyRequest, _$CreateReplyRequest];

  @override
  final String wireName = r'CreateReplyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateReplyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateReplyRequest object, {
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
    required CreateReplyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateReplyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateReplyRequestBuilder();
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
