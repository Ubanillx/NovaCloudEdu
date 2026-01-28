//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_feedback_request.g.dart';

/// CreateFeedbackRequest
///
/// Properties:
/// * [feedbackType]
/// * [content]
/// * [title]
/// * [attachment]
@BuiltValue()
abstract class CreateFeedbackRequest
    implements Built<CreateFeedbackRequest, CreateFeedbackRequestBuilder> {
  @BuiltValueField(wireName: r'feedbackType')
  String get feedbackType;

  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'attachment')
  String? get attachment;

  CreateFeedbackRequest._();

  factory CreateFeedbackRequest(
      [void updates(CreateFeedbackRequestBuilder b)]) = _$CreateFeedbackRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateFeedbackRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateFeedbackRequest> get serializer =>
      _$CreateFeedbackRequestSerializer();
}

class _$CreateFeedbackRequestSerializer
    implements PrimitiveSerializer<CreateFeedbackRequest> {
  @override
  final Iterable<Type> types = const [
    CreateFeedbackRequest,
    _$CreateFeedbackRequest
  ];

  @override
  final String wireName = r'CreateFeedbackRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateFeedbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'feedbackType';
    yield serializers.serialize(
      object.feedbackType,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.attachment != null) {
      yield r'attachment';
      yield serializers.serialize(
        object.attachment,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateFeedbackRequest object, {
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
    required CreateFeedbackRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'feedbackType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feedbackType = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'attachment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.attachment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateFeedbackRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateFeedbackRequestBuilder();
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
