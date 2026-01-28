//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/course_progress_summary_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_course_progress_summary_response.g.dart';

/// BaseResponseCourseProgressSummaryResponse
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseCourseProgressSummaryResponse
    implements
        Built<BaseResponseCourseProgressSummaryResponse,
            BaseResponseCourseProgressSummaryResponseBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  CourseProgressSummaryResponse? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseCourseProgressSummaryResponse._();

  factory BaseResponseCourseProgressSummaryResponse(
          [void updates(BaseResponseCourseProgressSummaryResponseBuilder b)]) =
      _$BaseResponseCourseProgressSummaryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseCourseProgressSummaryResponseBuilder b) =>
      b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseCourseProgressSummaryResponse> get serializer =>
      _$BaseResponseCourseProgressSummaryResponseSerializer();
}

class _$BaseResponseCourseProgressSummaryResponseSerializer
    implements PrimitiveSerializer<BaseResponseCourseProgressSummaryResponse> {
  @override
  final Iterable<Type> types = const [
    BaseResponseCourseProgressSummaryResponse,
    _$BaseResponseCourseProgressSummaryResponse
  ];

  @override
  final String wireName = r'BaseResponseCourseProgressSummaryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseCourseProgressSummaryResponse object, {
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
        specifiedType: const FullType(CourseProgressSummaryResponse),
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
    BaseResponseCourseProgressSummaryResponse object, {
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
    required BaseResponseCourseProgressSummaryResponseBuilder result,
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
            specifiedType: const FullType(CourseProgressSummaryResponse),
          ) as CourseProgressSummaryResponse;
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
  BaseResponseCourseProgressSummaryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseCourseProgressSummaryResponseBuilder();
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
