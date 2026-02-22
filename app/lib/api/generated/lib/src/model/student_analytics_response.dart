//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_analytics_response.g.dart';

/// StudentAnalyticsResponse
///
/// Properties:
/// * [totalDurationSec]
/// * [totalDurationText]
/// * [courseWatchCount]
/// * [wordStudyCount]
/// * [articleReadCount]
/// * [homeworkSubmitCount]
/// * [checkinCount]
/// * [totalCheckinDays]
/// * [currentStreak]
/// * [subjectMastery]
/// * [weakPointCount]
/// * [totalKnowledgePoints]
@BuiltValue()
abstract class StudentAnalyticsResponse
    implements
        Built<StudentAnalyticsResponse, StudentAnalyticsResponseBuilder> {
  @BuiltValueField(wireName: r'totalDurationSec')
  int? get totalDurationSec;

  @BuiltValueField(wireName: r'totalDurationText')
  String? get totalDurationText;

  @BuiltValueField(wireName: r'courseWatchCount')
  int? get courseWatchCount;

  @BuiltValueField(wireName: r'wordStudyCount')
  int? get wordStudyCount;

  @BuiltValueField(wireName: r'articleReadCount')
  int? get articleReadCount;

  @BuiltValueField(wireName: r'homeworkSubmitCount')
  int? get homeworkSubmitCount;

  @BuiltValueField(wireName: r'checkinCount')
  int? get checkinCount;

  @BuiltValueField(wireName: r'totalCheckinDays')
  int? get totalCheckinDays;

  @BuiltValueField(wireName: r'currentStreak')
  int? get currentStreak;

  @BuiltValueField(wireName: r'subjectMastery')
  BuiltMap<String, double>? get subjectMastery;

  @BuiltValueField(wireName: r'weakPointCount')
  int? get weakPointCount;

  @BuiltValueField(wireName: r'totalKnowledgePoints')
  int? get totalKnowledgePoints;

  StudentAnalyticsResponse._();

  factory StudentAnalyticsResponse(
          [void updates(StudentAnalyticsResponseBuilder b)]) =
      _$StudentAnalyticsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentAnalyticsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentAnalyticsResponse> get serializer =>
      _$StudentAnalyticsResponseSerializer();
}

class _$StudentAnalyticsResponseSerializer
    implements PrimitiveSerializer<StudentAnalyticsResponse> {
  @override
  final Iterable<Type> types = const [
    StudentAnalyticsResponse,
    _$StudentAnalyticsResponse
  ];

  @override
  final String wireName = r'StudentAnalyticsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentAnalyticsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalDurationSec != null) {
      yield r'totalDurationSec';
      yield serializers.serialize(
        object.totalDurationSec,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalDurationText != null) {
      yield r'totalDurationText';
      yield serializers.serialize(
        object.totalDurationText,
        specifiedType: const FullType(String),
      );
    }
    if (object.courseWatchCount != null) {
      yield r'courseWatchCount';
      yield serializers.serialize(
        object.courseWatchCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.wordStudyCount != null) {
      yield r'wordStudyCount';
      yield serializers.serialize(
        object.wordStudyCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.articleReadCount != null) {
      yield r'articleReadCount';
      yield serializers.serialize(
        object.articleReadCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.homeworkSubmitCount != null) {
      yield r'homeworkSubmitCount';
      yield serializers.serialize(
        object.homeworkSubmitCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.checkinCount != null) {
      yield r'checkinCount';
      yield serializers.serialize(
        object.checkinCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalCheckinDays != null) {
      yield r'totalCheckinDays';
      yield serializers.serialize(
        object.totalCheckinDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.currentStreak != null) {
      yield r'currentStreak';
      yield serializers.serialize(
        object.currentStreak,
        specifiedType: const FullType(int),
      );
    }
    if (object.subjectMastery != null) {
      yield r'subjectMastery';
      yield serializers.serialize(
        object.subjectMastery,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(double)]),
      );
    }
    if (object.weakPointCount != null) {
      yield r'weakPointCount';
      yield serializers.serialize(
        object.weakPointCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalKnowledgePoints != null) {
      yield r'totalKnowledgePoints';
      yield serializers.serialize(
        object.totalKnowledgePoints,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentAnalyticsResponse object, {
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
    required StudentAnalyticsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalDurationSec':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDurationSec = valueDes;
          break;
        case r'totalDurationText':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalDurationText = valueDes;
          break;
        case r'courseWatchCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseWatchCount = valueDes;
          break;
        case r'wordStudyCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.wordStudyCount = valueDes;
          break;
        case r'articleReadCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.articleReadCount = valueDes;
          break;
        case r'homeworkSubmitCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.homeworkSubmitCount = valueDes;
          break;
        case r'checkinCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.checkinCount = valueDes;
          break;
        case r'totalCheckinDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCheckinDays = valueDes;
          break;
        case r'currentStreak':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentStreak = valueDes;
          break;
        case r'subjectMastery':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(double)]),
          ) as BuiltMap<String, double>;
          result.subjectMastery.replace(valueDes);
          break;
        case r'weakPointCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.weakPointCount = valueDes;
          break;
        case r'totalKnowledgePoints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalKnowledgePoints = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentAnalyticsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentAnalyticsResponseBuilder();
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
