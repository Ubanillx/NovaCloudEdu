//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'paper_section_response.g.dart';

/// 试卷大题响应
///
/// Properties:
/// * [id] - 大题ID
/// * [paperId] - 试卷ID
/// * [title] - 标题
/// * [description] - 描述
/// * [questionType] - 题型
/// * [questionTypeDesc] - 题型描述
/// * [sortOrder] - 排序
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class PaperSectionResponse
    implements Built<PaperSectionResponse, PaperSectionResponseBuilder> {
  /// 大题ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 试卷ID
  @BuiltValueField(wireName: r'paperId')
  int? get paperId;

  /// 标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 题型
  @BuiltValueField(wireName: r'questionType')
  String? get questionType;

  /// 题型描述
  @BuiltValueField(wireName: r'questionTypeDesc')
  String? get questionTypeDesc;

  /// 排序
  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  PaperSectionResponse._();

  factory PaperSectionResponse([void updates(PaperSectionResponseBuilder b)]) =
      _$PaperSectionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PaperSectionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PaperSectionResponse> get serializer =>
      _$PaperSectionResponseSerializer();
}

class _$PaperSectionResponseSerializer
    implements PrimitiveSerializer<PaperSectionResponse> {
  @override
  final Iterable<Type> types = const [
    PaperSectionResponse,
    _$PaperSectionResponse
  ];

  @override
  final String wireName = r'PaperSectionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PaperSectionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.paperId != null) {
      yield r'paperId';
      yield serializers.serialize(
        object.paperId,
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
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.questionType != null) {
      yield r'questionType';
      yield serializers.serialize(
        object.questionType,
        specifiedType: const FullType(String),
      );
    }
    if (object.questionTypeDesc != null) {
      yield r'questionTypeDesc';
      yield serializers.serialize(
        object.questionTypeDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
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
    PaperSectionResponse object, {
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
    required PaperSectionResponseBuilder result,
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
        case r'paperId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.paperId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'questionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.questionType = valueDes;
          break;
        case r'questionTypeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.questionTypeDesc = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
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
  PaperSectionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PaperSectionResponseBuilder();
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
