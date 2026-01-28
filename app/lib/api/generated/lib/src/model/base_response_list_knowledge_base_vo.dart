//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/knowledge_base_vo.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_knowledge_base_vo.g.dart';

/// BaseResponseListKnowledgeBaseVO
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListKnowledgeBaseVO
    implements
        Built<BaseResponseListKnowledgeBaseVO,
            BaseResponseListKnowledgeBaseVOBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<KnowledgeBaseVO>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListKnowledgeBaseVO._();

  factory BaseResponseListKnowledgeBaseVO(
          [void updates(BaseResponseListKnowledgeBaseVOBuilder b)]) =
      _$BaseResponseListKnowledgeBaseVO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListKnowledgeBaseVOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListKnowledgeBaseVO> get serializer =>
      _$BaseResponseListKnowledgeBaseVOSerializer();
}

class _$BaseResponseListKnowledgeBaseVOSerializer
    implements PrimitiveSerializer<BaseResponseListKnowledgeBaseVO> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListKnowledgeBaseVO,
    _$BaseResponseListKnowledgeBaseVO
  ];

  @override
  final String wireName = r'BaseResponseListKnowledgeBaseVO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListKnowledgeBaseVO object, {
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
        specifiedType: const FullType(BuiltList, [FullType(KnowledgeBaseVO)]),
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
    BaseResponseListKnowledgeBaseVO object, {
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
    required BaseResponseListKnowledgeBaseVOBuilder result,
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
            specifiedType:
                const FullType(BuiltList, [FullType(KnowledgeBaseVO)]),
          ) as BuiltList<KnowledgeBaseVO>;
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
  BaseResponseListKnowledgeBaseVO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListKnowledgeBaseVOBuilder();
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
