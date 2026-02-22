//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_homework_request.g.dart';

/// 提交作业请求
///
/// Properties:
/// * [imageUrls] - 作业图片 OSS URL 列表
/// * [gradingMode] - 批改模式: EXAM_PAPER(试卷批改) / GENERAL(通用作业助手)，默认 GENERAL
/// * [title] - 作业标题（通用模式可自定义，如'人教版三年级数学第五章练习'）
/// * [subject] - 学科: MATH/CHINESE/ENGLISH/...（可选，通用模式AI自动推断）
/// * [grade] - 年级
/// * [classId] - 班级ID（可选）
/// * [examPaperId] - 关联试卷ID（试卷批改模式时传入）
@BuiltValue()
abstract class SubmitHomeworkRequest
    implements Built<SubmitHomeworkRequest, SubmitHomeworkRequestBuilder> {
  /// 作业图片 OSS URL 列表
  @BuiltValueField(wireName: r'imageUrls')
  BuiltList<String> get imageUrls;

  /// 批改模式: EXAM_PAPER(试卷批改) / GENERAL(通用作业助手)，默认 GENERAL
  @BuiltValueField(wireName: r'gradingMode')
  String? get gradingMode;

  /// 作业标题（通用模式可自定义，如'人教版三年级数学第五章练习'）
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 学科: MATH/CHINESE/ENGLISH/...（可选，通用模式AI自动推断）
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 班级ID（可选）
  @BuiltValueField(wireName: r'classId')
  int? get classId;

  /// 关联试卷ID（试卷批改模式时传入）
  @BuiltValueField(wireName: r'examPaperId')
  int? get examPaperId;

  SubmitHomeworkRequest._();

  factory SubmitHomeworkRequest(
      [void updates(SubmitHomeworkRequestBuilder b)]) = _$SubmitHomeworkRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitHomeworkRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitHomeworkRequest> get serializer =>
      _$SubmitHomeworkRequestSerializer();
}

class _$SubmitHomeworkRequestSerializer
    implements PrimitiveSerializer<SubmitHomeworkRequest> {
  @override
  final Iterable<Type> types = const [
    SubmitHomeworkRequest,
    _$SubmitHomeworkRequest
  ];

  @override
  final String wireName = r'SubmitHomeworkRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitHomeworkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'imageUrls';
    yield serializers.serialize(
      object.imageUrls,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
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
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(int),
      );
    }
    if (object.examPaperId != null) {
      yield r'examPaperId';
      yield serializers.serialize(
        object.examPaperId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitHomeworkRequest object, {
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
    required SubmitHomeworkRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'imageUrls':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.imageUrls.replace(valueDes);
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
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classId = valueDes;
          break;
        case r'examPaperId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.examPaperId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitHomeworkRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitHomeworkRequestBuilder();
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
