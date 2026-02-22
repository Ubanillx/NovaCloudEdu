//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exam_paper_response.g.dart';

/// 试卷响应
///
/// Properties:
/// * [id] - 试卷ID
/// * [title] - 标题
/// * [subtitle] - 副标题
/// * [subject] - 学科
/// * [subjectDesc] - 学科描述
/// * [grade] - 年级
/// * [totalScore] - 总分
/// * [durationMin] - 考试时长(分钟)
/// * [layout] - 排版配置JSON
/// * [status] - 状态
/// * [statusDesc] - 状态描述
/// * [templateId] - 模板ID
/// * [creatorId] - 创建者ID
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class ExamPaperResponse
    implements Built<ExamPaperResponse, ExamPaperResponseBuilder> {
  /// 试卷ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 副标题
  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 学科描述
  @BuiltValueField(wireName: r'subjectDesc')
  String? get subjectDesc;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 总分
  @BuiltValueField(wireName: r'totalScore')
  int? get totalScore;

  /// 考试时长(分钟)
  @BuiltValueField(wireName: r'durationMin')
  int? get durationMin;

  /// 排版配置JSON
  @BuiltValueField(wireName: r'layout')
  String? get layout;

  /// 状态
  @BuiltValueField(wireName: r'status')
  String? get status;

  /// 状态描述
  @BuiltValueField(wireName: r'statusDesc')
  String? get statusDesc;

  /// 模板ID
  @BuiltValueField(wireName: r'templateId')
  int? get templateId;

  /// 创建者ID
  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  ExamPaperResponse._();

  factory ExamPaperResponse([void updates(ExamPaperResponseBuilder b)]) =
      _$ExamPaperResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExamPaperResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExamPaperResponse> get serializer =>
      _$ExamPaperResponseSerializer();
}

class _$ExamPaperResponseSerializer
    implements PrimitiveSerializer<ExamPaperResponse> {
  @override
  final Iterable<Type> types = const [ExamPaperResponse, _$ExamPaperResponse];

  @override
  final String wireName = r'ExamPaperResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExamPaperResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      );
    }
    if (object.subtitle != null) {
      yield r'subtitle';
      yield serializers.serialize(
        object.subtitle,
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
    if (object.subjectDesc != null) {
      yield r'subjectDesc';
      yield serializers.serialize(
        object.subjectDesc,
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
    if (object.totalScore != null) {
      yield r'totalScore';
      yield serializers.serialize(
        object.totalScore,
        specifiedType: const FullType(int),
      );
    }
    if (object.durationMin != null) {
      yield r'durationMin';
      yield serializers.serialize(
        object.durationMin,
        specifiedType: const FullType(int),
      );
    }
    if (object.layout != null) {
      yield r'layout';
      yield serializers.serialize(
        object.layout,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.statusDesc != null) {
      yield r'statusDesc';
      yield serializers.serialize(
        object.statusDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.templateId != null) {
      yield r'templateId';
      yield serializers.serialize(
        object.templateId,
        specifiedType: const FullType(int),
      );
    }
    if (object.creatorId != null) {
      yield r'creatorId';
      yield serializers.serialize(
        object.creatorId,
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
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExamPaperResponse object, {
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
    required ExamPaperResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'subtitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtitle = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'subjectDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subjectDesc = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
          break;
        case r'totalScore':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalScore = valueDes;
          break;
        case r'durationMin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationMin = valueDes;
          break;
        case r'layout':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.layout = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'statusDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.statusDesc = valueDes;
          break;
        case r'templateId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.templateId = valueDes;
          break;
        case r'creatorId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.creatorId = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExamPaperResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExamPaperResponseBuilder();
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
