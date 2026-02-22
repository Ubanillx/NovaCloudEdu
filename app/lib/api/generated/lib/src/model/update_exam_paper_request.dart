//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_exam_paper_request.g.dart';

/// 更新试卷请求
///
/// Properties:
/// * [id] - 试卷ID
/// * [title] - 试卷标题
/// * [subject] - 学科
/// * [subtitle] - 副标题
/// * [grade] - 年级
/// * [durationMin] - 考试时长(分钟)
/// * [layout] - 排版配置JSON
/// * [templateId] - 模板ID
@BuiltValue()
abstract class UpdateExamPaperRequest
    implements Built<UpdateExamPaperRequest, UpdateExamPaperRequestBuilder> {
  /// 试卷ID
  @BuiltValueField(wireName: r'id')
  int get id;

  /// 试卷标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String get subject;

  /// 副标题
  @BuiltValueField(wireName: r'subtitle')
  String? get subtitle;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 考试时长(分钟)
  @BuiltValueField(wireName: r'durationMin')
  int? get durationMin;

  /// 排版配置JSON
  @BuiltValueField(wireName: r'layout')
  String? get layout;

  /// 模板ID
  @BuiltValueField(wireName: r'templateId')
  int? get templateId;

  UpdateExamPaperRequest._();

  factory UpdateExamPaperRequest(
          [void updates(UpdateExamPaperRequestBuilder b)]) =
      _$UpdateExamPaperRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateExamPaperRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateExamPaperRequest> get serializer =>
      _$UpdateExamPaperRequestSerializer();
}

class _$UpdateExamPaperRequestSerializer
    implements PrimitiveSerializer<UpdateExamPaperRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateExamPaperRequest,
    _$UpdateExamPaperRequest
  ];

  @override
  final String wireName = r'UpdateExamPaperRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateExamPaperRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    if (object.subtitle != null) {
      yield r'subtitle';
      yield serializers.serialize(
        object.subtitle,
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
    if (object.templateId != null) {
      yield r'templateId';
      yield serializers.serialize(
        object.templateId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateExamPaperRequest object, {
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
    required UpdateExamPaperRequestBuilder result,
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
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'subtitle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subtitle = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
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
        case r'templateId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.templateId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateExamPaperRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateExamPaperRequestBuilder();
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
