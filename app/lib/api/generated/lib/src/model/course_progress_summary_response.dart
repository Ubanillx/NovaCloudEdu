//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'course_progress_summary_response.g.dart';

/// 课程进度汇总响应
///
/// Properties:
/// * [courseId] - 课程ID
/// * [totalSections] - 总小节数
/// * [completedSections] - 已完成小节数
/// * [overallProgress] - 课程整体进度(百分比)
/// * [completionRate] - 完成率(百分比)
@BuiltValue()
abstract class CourseProgressSummaryResponse
    implements
        Built<CourseProgressSummaryResponse,
            CourseProgressSummaryResponseBuilder> {
  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  /// 总小节数
  @BuiltValueField(wireName: r'totalSections')
  int? get totalSections;

  /// 已完成小节数
  @BuiltValueField(wireName: r'completedSections')
  int? get completedSections;

  /// 课程整体进度(百分比)
  @BuiltValueField(wireName: r'overallProgress')
  int? get overallProgress;

  /// 完成率(百分比)
  @BuiltValueField(wireName: r'completionRate')
  int? get completionRate;

  CourseProgressSummaryResponse._();

  factory CourseProgressSummaryResponse(
          [void updates(CourseProgressSummaryResponseBuilder b)]) =
      _$CourseProgressSummaryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CourseProgressSummaryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CourseProgressSummaryResponse> get serializer =>
      _$CourseProgressSummaryResponseSerializer();
}

class _$CourseProgressSummaryResponseSerializer
    implements PrimitiveSerializer<CourseProgressSummaryResponse> {
  @override
  final Iterable<Type> types = const [
    CourseProgressSummaryResponse,
    _$CourseProgressSummaryResponse
  ];

  @override
  final String wireName = r'CourseProgressSummaryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CourseProgressSummaryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.courseId != null) {
      yield r'courseId';
      yield serializers.serialize(
        object.courseId,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalSections != null) {
      yield r'totalSections';
      yield serializers.serialize(
        object.totalSections,
        specifiedType: const FullType(int),
      );
    }
    if (object.completedSections != null) {
      yield r'completedSections';
      yield serializers.serialize(
        object.completedSections,
        specifiedType: const FullType(int),
      );
    }
    if (object.overallProgress != null) {
      yield r'overallProgress';
      yield serializers.serialize(
        object.overallProgress,
        specifiedType: const FullType(int),
      );
    }
    if (object.completionRate != null) {
      yield r'completionRate';
      yield serializers.serialize(
        object.completionRate,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CourseProgressSummaryResponse object, {
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
    required CourseProgressSummaryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        case r'totalSections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalSections = valueDes;
          break;
        case r'completedSections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.completedSections = valueDes;
          break;
        case r'overallProgress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.overallProgress = valueDes;
          break;
        case r'completionRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.completionRate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CourseProgressSummaryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CourseProgressSummaryResponseBuilder();
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
