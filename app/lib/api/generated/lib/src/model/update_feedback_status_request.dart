//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_feedback_status_request.g.dart';

/// UpdateFeedbackStatusRequest
///
/// Properties:
/// * [feedbackId]
/// * [status]
@BuiltValue()
abstract class UpdateFeedbackStatusRequest
    implements
        Built<UpdateFeedbackStatusRequest, UpdateFeedbackStatusRequestBuilder> {
  @BuiltValueField(wireName: r'feedbackId')
  int get feedbackId;

  @BuiltValueField(wireName: r'status')
  int get status;

  UpdateFeedbackStatusRequest._();

  factory UpdateFeedbackStatusRequest(
          [void updates(UpdateFeedbackStatusRequestBuilder b)]) =
      _$UpdateFeedbackStatusRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateFeedbackStatusRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateFeedbackStatusRequest> get serializer =>
      _$UpdateFeedbackStatusRequestSerializer();
}

class _$UpdateFeedbackStatusRequestSerializer
    implements PrimitiveSerializer<UpdateFeedbackStatusRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateFeedbackStatusRequest,
    _$UpdateFeedbackStatusRequest
  ];

  @override
  final String wireName = r'UpdateFeedbackStatusRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateFeedbackStatusRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'feedbackId';
    yield serializers.serialize(
      object.feedbackId,
      specifiedType: const FullType(int),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateFeedbackStatusRequest object, {
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
    required UpdateFeedbackStatusRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'feedbackId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.feedbackId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateFeedbackStatusRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateFeedbackStatusRequestBuilder();
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
