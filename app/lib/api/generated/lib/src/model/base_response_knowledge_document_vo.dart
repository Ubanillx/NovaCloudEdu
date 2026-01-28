//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/knowledge_document_vo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_knowledge_document_vo.g.dart';

/// BaseResponseKnowledgeDocumentVO
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseKnowledgeDocumentVO
    implements
        Built<BaseResponseKnowledgeDocumentVO,
            BaseResponseKnowledgeDocumentVOBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  KnowledgeDocumentVO? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseKnowledgeDocumentVO._();

  factory BaseResponseKnowledgeDocumentVO(
          [void updates(BaseResponseKnowledgeDocumentVOBuilder b)]) =
      _$BaseResponseKnowledgeDocumentVO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseKnowledgeDocumentVOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseKnowledgeDocumentVO> get serializer =>
      _$BaseResponseKnowledgeDocumentVOSerializer();
}

class _$BaseResponseKnowledgeDocumentVOSerializer
    implements PrimitiveSerializer<BaseResponseKnowledgeDocumentVO> {
  @override
  final Iterable<Type> types = const [
    BaseResponseKnowledgeDocumentVO,
    _$BaseResponseKnowledgeDocumentVO
  ];

  @override
  final String wireName = r'BaseResponseKnowledgeDocumentVO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseKnowledgeDocumentVO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(KnowledgeDocumentVO),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseKnowledgeDocumentVO object, {
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
    required BaseResponseKnowledgeDocumentVOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnowledgeDocumentVO),
          ) as KnowledgeDocumentVO;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseKnowledgeDocumentVO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseKnowledgeDocumentVOBuilder();
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
