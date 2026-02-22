//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_question_request.g.dart';

/// 更新题目请求
///
/// Properties:
/// * [id] - 题目ID
/// * [type] - 题型
/// * [subject] - 学科
/// * [difficulty] - 难度: 1-5
/// * [content] - 题干内容
/// * [answer] - 标准答案
/// * [grade] - 年级
/// * [options] - 选项JSON字符串
/// * [explanation] - 解析
/// * [knowledgeTags] - 知识点标签
/// * [imageUrl] - 题目图片URL
@BuiltValue()
abstract class UpdateQuestionRequest
    implements Built<UpdateQuestionRequest, UpdateQuestionRequestBuilder> {
  /// 题目ID
  @BuiltValueField(wireName: r'id')
  int get id;

  /// 题型
  @BuiltValueField(wireName: r'type')
  String get type;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String get subject;

  /// 难度: 1-5
  @BuiltValueField(wireName: r'difficulty')
  int get difficulty;

  /// 题干内容
  @BuiltValueField(wireName: r'content')
  String get content;

  /// 标准答案
  @BuiltValueField(wireName: r'answer')
  String get answer;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 选项JSON字符串
  @BuiltValueField(wireName: r'options')
  String? get options;

  /// 解析
  @BuiltValueField(wireName: r'explanation')
  String? get explanation;

  /// 知识点标签
  @BuiltValueField(wireName: r'knowledgeTags')
  BuiltList<String>? get knowledgeTags;

  /// 题目图片URL
  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  UpdateQuestionRequest._();

  factory UpdateQuestionRequest(
      [void updates(UpdateQuestionRequestBuilder b)]) = _$UpdateQuestionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateQuestionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateQuestionRequest> get serializer =>
      _$UpdateQuestionRequestSerializer();
}

class _$UpdateQuestionRequestSerializer
    implements PrimitiveSerializer<UpdateQuestionRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateQuestionRequest,
    _$UpdateQuestionRequest
  ];

  @override
  final String wireName = r'UpdateQuestionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateQuestionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(int),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
      specifiedType: const FullType(String),
    );
    yield r'answer';
    yield serializers.serialize(
      object.answer,
      specifiedType: const FullType(String),
    );
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType(String),
      );
    }
    if (object.options != null) {
      yield r'options';
      yield serializers.serialize(
        object.options,
        specifiedType: const FullType(String),
      );
    }
    if (object.explanation != null) {
      yield r'explanation';
      yield serializers.serialize(
        object.explanation,
        specifiedType: const FullType(String),
      );
    }
    if (object.knowledgeTags != null) {
      yield r'knowledgeTags';
      yield serializers.serialize(
        object.knowledgeTags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.imageUrl != null) {
      yield r'imageUrl';
      yield serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateQuestionRequest object, {
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
    required UpdateQuestionRequestBuilder result,
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
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'answer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.answer = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
          break;
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.options = valueDes;
          break;
        case r'explanation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.explanation = valueDes;
          break;
        case r'knowledgeTags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.knowledgeTags.replace(valueDes);
          break;
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateQuestionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateQuestionRequestBuilder();
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
