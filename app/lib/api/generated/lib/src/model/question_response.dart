//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'question_response.g.dart';

/// 题目响应
///
/// Properties:
/// * [id] - 题目ID
/// * [type] - 题型
/// * [typeDesc] - 题型描述
/// * [subject] - 学科
/// * [subjectDesc] - 学科描述
/// * [grade] - 年级
/// * [difficulty] - 难度
/// * [difficultyDesc] - 难度描述
/// * [content] - 题干内容
/// * [options] - 选项JSON
/// * [answer] - 标准答案
/// * [explanation] - 解析
/// * [knowledgeTags] - 知识点标签
/// * [imageUrl] - 题目图片URL
/// * [source_] - 来源
/// * [creatorId] - 创建者ID
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class QuestionResponse
    implements Built<QuestionResponse, QuestionResponseBuilder> {
  /// 题目ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 题型
  @BuiltValueField(wireName: r'type')
  String? get type;

  /// 题型描述
  @BuiltValueField(wireName: r'typeDesc')
  String? get typeDesc;

  /// 学科
  @BuiltValueField(wireName: r'subject')
  String? get subject;

  /// 学科描述
  @BuiltValueField(wireName: r'subjectDesc')
  String? get subjectDesc;

  /// 年级
  @BuiltValueField(wireName: r'grade')
  String? get grade;

  /// 难度
  @BuiltValueField(wireName: r'difficulty')
  int? get difficulty;

  /// 难度描述
  @BuiltValueField(wireName: r'difficultyDesc')
  String? get difficultyDesc;

  /// 题干内容
  @BuiltValueField(wireName: r'content')
  String? get content;

  /// 选项JSON
  @BuiltValueField(wireName: r'options')
  String? get options;

  /// 标准答案
  @BuiltValueField(wireName: r'answer')
  String? get answer;

  /// 解析
  @BuiltValueField(wireName: r'explanation')
  String? get explanation;

  /// 知识点标签
  @BuiltValueField(wireName: r'knowledgeTags')
  BuiltList<String>? get knowledgeTags;

  /// 题目图片URL
  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  /// 来源
  @BuiltValueField(wireName: r'source')
  String? get source_;

  /// 创建者ID
  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  QuestionResponse._();

  factory QuestionResponse([void updates(QuestionResponseBuilder b)]) =
      _$QuestionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QuestionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QuestionResponse> get serializer =>
      _$QuestionResponseSerializer();
}

class _$QuestionResponseSerializer
    implements PrimitiveSerializer<QuestionResponse> {
  @override
  final Iterable<Type> types = const [QuestionResponse, _$QuestionResponse];

  @override
  final String wireName = r'QuestionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QuestionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(String),
      );
    }
    if (object.typeDesc != null) {
      yield r'typeDesc';
      yield serializers.serialize(
        object.typeDesc,
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
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType(int),
      );
    }
    if (object.difficultyDesc != null) {
      yield r'difficultyDesc';
      yield serializers.serialize(
        object.difficultyDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
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
    if (object.answer != null) {
      yield r'answer';
      yield serializers.serialize(
        object.answer,
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
    if (object.source_ != null) {
      yield r'source';
      yield serializers.serialize(
        object.source_,
        specifiedType: const FullType(String),
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
    QuestionResponse object, {
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
    required QuestionResponseBuilder result,
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
        case r'typeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.typeDesc = valueDes;
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
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.difficulty = valueDes;
          break;
        case r'difficultyDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.difficultyDesc = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.options = valueDes;
          break;
        case r'answer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.answer = valueDes;
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
        case r'source':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.source_ = valueDes;
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
  QuestionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QuestionResponseBuilder();
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
