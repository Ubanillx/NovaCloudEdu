//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'query_feedback_request.g.dart';

/// QueryFeedbackRequest
///
/// Properties:
/// * [userId]
/// * [feedbackType]
/// * [status]
/// * [pageNum]
/// * [pageSize]
@BuiltValue()
abstract class QueryFeedbackRequest
    implements Built<QueryFeedbackRequest, QueryFeedbackRequestBuilder> {
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'feedbackType')
  String? get feedbackType;

  @BuiltValueField(wireName: r'status')
  int? get status;

  @BuiltValueField(wireName: r'pageNum')
  int? get pageNum;

  @BuiltValueField(wireName: r'pageSize')
  int? get pageSize;

  QueryFeedbackRequest._();

  factory QueryFeedbackRequest([void updates(QueryFeedbackRequestBuilder b)]) =
      _$QueryFeedbackRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueryFeedbackRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueryFeedbackRequest> get serializer =>
      _$QueryFeedbackRequestSerializer();
}

class _$QueryFeedbackRequestSerializer
    implements PrimitiveSerializer<QueryFeedbackRequest> {
  @override
  final Iterable<Type> types = const [
    QueryFeedbackRequest,
    _$QueryFeedbackRequest
  ];

  @override
  final String wireName = r'QueryFeedbackRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueryFeedbackRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.feedbackType != null) {
      yield r'feedbackType';
      yield serializers.serialize(
        object.feedbackType,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageNum != null) {
      yield r'pageNum';
      yield serializers.serialize(
        object.pageNum,
        specifiedType: const FullType(int),
      );
    }
    if (object.pageSize != null) {
      yield r'pageSize';
      yield serializers.serialize(
        object.pageSize,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QueryFeedbackRequest object, {
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
    required QueryFeedbackRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'feedbackType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feedbackType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'pageNum':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageNum = valueDes;
          break;
        case r'pageSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueryFeedbackRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueryFeedbackRequestBuilder();
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
