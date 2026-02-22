//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_paper_section_request.g.dart';

/// 添加试卷大题请求
///
/// Properties:
/// * [title] - 大题标题
/// * [description] - 大题描述
/// * [questionType] - 题型
/// * [sortOrder] - 排序
@BuiltValue()
abstract class AddPaperSectionRequest
    implements Built<AddPaperSectionRequest, AddPaperSectionRequestBuilder> {
  /// 大题标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 大题描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 题型
  @BuiltValueField(wireName: r'questionType')
  String? get questionType;

  /// 排序
  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  AddPaperSectionRequest._();

  factory AddPaperSectionRequest(
          [void updates(AddPaperSectionRequestBuilder b)]) =
      _$AddPaperSectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddPaperSectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddPaperSectionRequest> get serializer =>
      _$AddPaperSectionRequestSerializer();
}

class _$AddPaperSectionRequestSerializer
    implements PrimitiveSerializer<AddPaperSectionRequest> {
  @override
  final Iterable<Type> types = const [
    AddPaperSectionRequest,
    _$AddPaperSectionRequest
  ];

  @override
  final String wireName = r'AddPaperSectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddPaperSectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
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
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AddPaperSectionRequest object, {
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
    required AddPaperSectionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddPaperSectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddPaperSectionRequestBuilder();
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
