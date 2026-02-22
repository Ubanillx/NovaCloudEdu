//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submission_status_response.g.dart';

/// 作业提交状态响应
///
/// Properties:
/// * [submissionId] - 提交ID
/// * [gradingMode] - 批改模式: EXAM_PAPER/GENERAL
/// * [title] - 作业标题
/// * [subject] - 学科（可能为null，通用模式下AI推断后回填）
/// * [grade] - 年级
/// * [imageUrls] - 作业图片URL列表
/// * [status] - 批改状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED
/// * [examPaperId] - 关联试卷ID
/// * [totalScore] - 总得分（已完成时有值）
/// * [maxScore] - 满分（已完成时有值）
/// * [createTime] - 提交时间
@BuiltValue()
abstract class SubmissionStatusResponse
    implements
        Built<SubmissionStatusResponse, SubmissionStatusResponseBuilder> {
  /// 提交ID
  @BuiltValueField(wireName: r'submissionId')
  String? get submissionId;

  /// 批改模式: EXAM_PAPER/GENERAL
  @BuiltValueField(wireName: r'gradingMode')
  String? get gradingMode;

  /// 作业标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 学科（可能为null，通用模式下AI推断后回填）
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 作业图片URL列表
  @BuiltValueField(wireName: r'imageUrls')
  BuiltList<String>? get imageUrls;

  /// 批改状态: PENDING/OCR_PROCESSING/GRADING/COMPLETED/FAILED
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 关联试卷ID
  @BuiltValueField(wireName: r'examPaperId')
  String? get examPaperId;

  /// 总得分（已完成时有值）
  @BuiltValueField(wireName: r'totalScore')
  int? get totalScore;

  /// 满分（已完成时有值）
  @BuiltValueField(wireName: r'maxScore')
  int? get maxScore;

  /// 提交时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  SubmissionStatusResponse._();

  factory SubmissionStatusResponse(
          [void updates(SubmissionStatusResponseBuilder b)]) =
      _$SubmissionStatusResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmissionStatusResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmissionStatusResponse> get serializer =>
      _$SubmissionStatusResponseSerializer();
}

class _$SubmissionStatusResponseSerializer
    implements PrimitiveSerializer<SubmissionStatusResponse> {
  @override
  final Iterable<Type> types = const [
    SubmissionStatusResponse,
    _$SubmissionStatusResponse
  ];

  @override
  final String wireName = r'SubmissionStatusResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmissionStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.submissionId != null) {
      yield r'submissionId';
      yield serializers.serialize(
        object.submissionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.gradingMode != null) {
      yield r'gradingMode';
      yield serializers.serialize(
        object.gradingMode,
        specifiedType: const FullType(String),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.subject != null) {
      yield r'subject';
      yield serializers.serialize(
        object.subject,
        specifiedType: const FullType(String),
      );
    }
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType(String),
      );
    }
    if (object.imageUrls != null) {
      yield r'imageUrls';
      yield serializers.serialize(
        object.imageUrls,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.examPaperId != null) {
      yield r'examPaperId';
      yield serializers.serialize(
        object.examPaperId,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalScore != null) {
      yield r'totalScore';
      yield serializers.serialize(
        object.totalScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxScore != null) {
      yield r'maxScore';
      yield serializers.serialize(
        object.maxScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmissionStatusResponse object, {
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
    required SubmissionStatusResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'submissionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.submissionId = valueDes;
          break;
        case r'gradingMode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gradingMode = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
          break;
        case r'imageUrls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.imageUrls.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'examPaperId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.examPaperId = valueDes;
          break;
        case r'totalScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalScore = valueDes;
          break;
        case r'maxScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxScore = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmissionStatusResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmissionStatusResponseBuilder();
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
