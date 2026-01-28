//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'review_application_request.g.dart';

/// 审核讲师申请请求
///
/// Properties:
/// * [applicationId] - 申请ID
/// * [approved] - 是否通过：true-通过，false-拒绝
/// * [rejectReason] - 拒绝原因（拒绝时必填）
@BuiltValue()
abstract class ReviewApplicationRequest
    implements
        Built<ReviewApplicationRequest, ReviewApplicationRequestBuilder> {
  /// 申请ID
  @BuiltValueField(wireName: r'applicationId')
  int get applicationId;

  /// 是否通过：true-通过，false-拒绝
  @BuiltValueField(wireName: r'approved')
  bool get approved;

  /// 拒绝原因（拒绝时必填）
  @BuiltValueField(wireName: r'rejectReason')
  String? get rejectReason;

  ReviewApplicationRequest._();

  factory ReviewApplicationRequest(
          [void updates(ReviewApplicationRequestBuilder b)]) =
      _$ReviewApplicationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReviewApplicationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReviewApplicationRequest> get serializer =>
      _$ReviewApplicationRequestSerializer();
}

class _$ReviewApplicationRequestSerializer
    implements PrimitiveSerializer<ReviewApplicationRequest> {
  @override
  final Iterable<Type> types = const [
    ReviewApplicationRequest,
    _$ReviewApplicationRequest
  ];

  @override
  final String wireName = r'ReviewApplicationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReviewApplicationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'applicationId';
    yield serializers.serialize(
      object.applicationId,
      specifiedType: const FullType(int),
    );
    yield r'approved';
    yield serializers.serialize(
      object.approved,
      specifiedType: const FullType(bool),
    );
    if (object.rejectReason != null) {
      yield r'rejectReason';
      yield serializers.serialize(
        object.rejectReason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ReviewApplicationRequest object, {
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
    required ReviewApplicationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'applicationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.applicationId = valueDes;
          break;
        case r'approved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.approved = valueDes;
          break;
        case r'rejectReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rejectReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReviewApplicationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReviewApplicationRequestBuilder();
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
