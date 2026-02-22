//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ppt_generation_request.g.dart';

/// PPT生成助手请求
///
/// Properties:
/// * [action] - 操作类型: detect_intent / generate_outline / revise_outline / confirm_outline / select_template / generate_ppt
/// * [sessionId] - 会话ID（首次操作时为空，后续步骤必填）
/// * [message] - 用户消息（detect_intent 时使用，AI判断是否要生成PPT）
/// * [topic] - PPT主题（generate_outline 时使用）
/// * [requirements] - 额外要求（generate_outline 时可选）
/// * [feedback] - 修改反馈（revise_outline 时使用）
/// * [templateId] - 系统模板ID（select_template 时使用）
/// * [templateUrl] - 自定义模板URL（select_template 时使用，与 templateId 二选一）
@BuiltValue()
abstract class PptGenerationRequest
    implements Built<PptGenerationRequest, PptGenerationRequestBuilder> {
  /// 操作类型: detect_intent / generate_outline / revise_outline / confirm_outline / select_template / generate_ppt
  @BuiltValueField(wireName: r'action')
  String get action;

  /// 会话ID（首次操作时为空，后续步骤必填）
  @BuiltValueField(wireName: r'sessionId')
  int? get sessionId;

  /// 用户消息（detect_intent 时使用，AI判断是否要生成PPT）
  @BuiltValueField(wireName: r'message')
  String? get message;

  /// PPT主题（generate_outline 时使用）
  @BuiltValueField(wireName: r'topic')
  String? get topic;

  /// 额外要求（generate_outline 时可选）
  @BuiltValueField(wireName: r'requirements')
  String? get requirements;

  /// 修改反馈（revise_outline 时使用）
  @BuiltValueField(wireName: r'feedback')
  String? get feedback;

  /// 系统模板ID（select_template 时使用）
  @BuiltValueField(wireName: r'templateId')
  int? get templateId;

  /// 自定义模板URL（select_template 时使用，与 templateId 二选一）
  @BuiltValueField(wireName: r'templateUrl')
  String? get templateUrl;

  PptGenerationRequest._();

  factory PptGenerationRequest([void updates(PptGenerationRequestBuilder b)]) =
      _$PptGenerationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PptGenerationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PptGenerationRequest> get serializer =>
      _$PptGenerationRequestSerializer();
}

class _$PptGenerationRequestSerializer
    implements PrimitiveSerializer<PptGenerationRequest> {
  @override
  final Iterable<Type> types = const [
    PptGenerationRequest,
    _$PptGenerationRequest
  ];

  @override
  final String wireName = r'PptGenerationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PptGenerationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(String),
    );
    if (object.sessionId != null) {
      yield r'sessionId';
      yield serializers.serialize(
        object.sessionId,
        specifiedType: const FullType(int),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
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
    if (object.requirements != null) {
      yield r'requirements';
      yield serializers.serialize(
        object.requirements,
        specifiedType: const FullType(String),
      );
    }
    if (object.feedback != null) {
      yield r'feedback';
      yield serializers.serialize(
        object.feedback,
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
    if (object.templateUrl != null) {
      yield r'templateUrl';
      yield serializers.serialize(
        object.templateUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PptGenerationRequest object, {
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
    required PptGenerationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.action = valueDes;
          break;
        case r'sessionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sessionId = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'topic':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.topic = valueDes;
          break;
        case r'requirements':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.requirements = valueDes;
          break;
        case r'feedback':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feedback = valueDes;
          break;
        case r'templateId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.templateId = valueDes;
          break;
        case r'templateUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.templateUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PptGenerationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PptGenerationRequestBuilder();
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
