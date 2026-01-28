//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/feedback_reply_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_feedback_reply_response.g.dart';

/// BaseResponseListFeedbackReplyResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListFeedbackReplyResponse
    implements
        Built<BaseResponseListFeedbackReplyResponse,
            BaseResponseListFeedbackReplyResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<FeedbackReplyResponse>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListFeedbackReplyResponse._();

  factory BaseResponseListFeedbackReplyResponse(
          [void updates(BaseResponseListFeedbackReplyResponseBuilder b)]) =
      _$BaseResponseListFeedbackReplyResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListFeedbackReplyResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListFeedbackReplyResponse> get serializer =>
      _$BaseResponseListFeedbackReplyResponseSerializer();
}

class _$BaseResponseListFeedbackReplyResponseSerializer
    implements PrimitiveSerializer<BaseResponseListFeedbackReplyResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListFeedbackReplyResponse,
    _$BaseResponseListFeedbackReplyResponse
  ];

  @override
  final String wireName = r'BaseResponseListFeedbackReplyResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListFeedbackReplyResponse object, {
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
            const FullType(BuiltList, [FullType(FeedbackReplyResponse)]),
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
    BaseResponseListFeedbackReplyResponse object, {
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
    required BaseResponseListFeedbackReplyResponseBuilder result,
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
                const FullType(BuiltList, [FullType(FeedbackReplyResponse)]),
          ) as BuiltList<FeedbackReplyResponse>;
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
  BaseResponseListFeedbackReplyResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListFeedbackReplyResponseBuilder();
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
