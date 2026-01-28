//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/feedback_detail_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_feedback_detail_response.g.dart';

/// BaseResponseFeedbackDetailResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseFeedbackDetailResponse
    implements
        Built<BaseResponseFeedbackDetailResponse,
            BaseResponseFeedbackDetailResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  FeedbackDetailResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseFeedbackDetailResponse._();

  factory BaseResponseFeedbackDetailResponse(
          [void updates(BaseResponseFeedbackDetailResponseBuilder b)]) =
      _$BaseResponseFeedbackDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseFeedbackDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseFeedbackDetailResponse> get serializer =>
      _$BaseResponseFeedbackDetailResponseSerializer();
}

class _$BaseResponseFeedbackDetailResponseSerializer
    implements PrimitiveSerializer<BaseResponseFeedbackDetailResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseFeedbackDetailResponse,
    _$BaseResponseFeedbackDetailResponse
  ];

  @override
  final String wireName = r'BaseResponseFeedbackDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseFeedbackDetailResponse object, {
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
        specifiedType: const FullType(FeedbackDetailResponse),
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
    BaseResponseFeedbackDetailResponse object, {
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
    required BaseResponseFeedbackDetailResponseBuilder result,
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
            specifiedType: const FullType(FeedbackDetailResponse),
          ) as FeedbackDetailResponse;
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
  BaseResponseFeedbackDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseFeedbackDetailResponseBuilder();
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
