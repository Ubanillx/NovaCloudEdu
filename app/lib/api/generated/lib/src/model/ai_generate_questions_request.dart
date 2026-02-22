//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ai_generate_questions_request.g.dart';

/// AI 生成题目请求
///
/// Properties:
/// * [subject] - 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS
/// * [type] - 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY
/// * [difficulty] - 难度: 1-5
/// * [count] - 生成数量
/// * [grade] - 年级
/// * [topic] - 知识点/主题描述
/// * [withDiagram] - 是否生成几何图形（Typst cetz 渲染）
/// * [withImage] - 是否生成配图（文生图）
/// * [enableWebSearch] - 是否启用联网搜索热点出题
/// * [modelId] - AI 模型ID（可选，如 dashscope/qwen-max）
/// * [userInput] - 用户自定义补充要求（如出题风格、特殊限制、场景描述等）
@BuiltValue()
abstract class AiGenerateQuestionsRequest
    implements
        Built<AiGenerateQuestionsRequest, AiGenerateQuestionsRequestBuilder> {
  /// 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS
  @BuiltValueField(wireName: r'subject')
  String get subject;

  /// 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY
  @BuiltValueField(wireName: r'type')
  String get type;

  /// 难度: 1-5
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// 生成数量
  @BuiltValueField(wireName: r'count')
  int get count;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 知识点/主题描述
  @BuiltValueField(wireName: r'topic')
  String? get topic;

  /// 是否生成几何图形（Typst cetz 渲染）
  @BuiltValueField(wireName: r'withDiagram')
  bool? get withDiagram;

  /// 是否生成配图（文生图）
  @BuiltValueField(wireName: r'withImage')
  bool? get withImage;

  /// 是否启用联网搜索热点出题
  @BuiltValueField(wireName: r'enableWebSearch')
  bool? get enableWebSearch;

  /// AI 模型ID（可选，如 dashscope/qwen-max）
  @BuiltValueField(wireName: r'modelId')
  String? get modelId;

  /// 用户自定义补充要求（如出题风格、特殊限制、场景描述等）
  @BuiltValueField(wireName: r'userInput')
  String? get userInput;

  AiGenerateQuestionsRequest._();

  factory AiGenerateQuestionsRequest(
          [void updates(AiGenerateQuestionsRequestBuilder b)]) =
      _$AiGenerateQuestionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AiGenerateQuestionsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AiGenerateQuestionsRequest> get serializer =>
      _$AiGenerateQuestionsRequestSerializer();
}

class _$AiGenerateQuestionsRequestSerializer
    implements PrimitiveSerializer<AiGenerateQuestionsRequest> {
  @override
  final Iterable<Type> types = const [
    AiGenerateQuestionsRequest,
    _$AiGenerateQuestionsRequest
  ];

  @override
  final String wireName = r'AiGenerateQuestionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AiGenerateQuestionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(int),
    );
    yield r'count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(int),
    );
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType(String),
      );
    }
    if (object.topic != null) {
      yield r'topic';
      yield serializers.serialize(
        object.topic,
        specifiedType: const FullType(String),
      );
    }
    if (object.withDiagram != null) {
      yield r'withDiagram';
      yield serializers.serialize(
        object.withDiagram,
        specifiedType: const FullType(bool),
      );
    }
    if (object.withImage != null) {
      yield r'withImage';
      yield serializers.serialize(
        object.withImage,
        specifiedType: const FullType(bool),
      );
    }
    if (object.enableWebSearch != null) {
      yield r'enableWebSearch';
      yield serializers.serialize(
        object.enableWebSearch,
        specifiedType: const FullType(bool),
      );
    }
    if (object.modelId != null) {
      yield r'modelId';
      yield serializers.serialize(
        object.modelId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userInput != null) {
      yield r'userInput';
      yield serializers.serialize(
        object.userInput,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AiGenerateQuestionsRequest object, {
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
    required AiGenerateQuestionsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.count = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
          break;
        case r'topic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.topic = valueDes;
          break;
        case r'withDiagram':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.withDiagram = valueDes;
          break;
        case r'withImage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.withImage = valueDes;
          break;
        case r'enableWebSearch':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enableWebSearch = valueDes;
          break;
        case r'modelId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.modelId = valueDes;
          break;
        case r'userInput':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userInput = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AiGenerateQuestionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AiGenerateQuestionsRequestBuilder();
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
