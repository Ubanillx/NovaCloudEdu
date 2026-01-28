//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'knowledge_base_vo.g.dart';

/// KnowledgeBaseVO
///
/// Properties:
/// * [id]
/// * [name]
/// * [description]
/// * [embeddingModel]
/// * [embeddingDimension]
/// * [chunkSize]
/// * [chunkOverlap]
/// * [documentCount]
/// * [chunkCount]
/// * [status]
/// * [creatorId]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class KnowledgeBaseVO
    implements Built<KnowledgeBaseVO, KnowledgeBaseVOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'embeddingModel')
  String? get embeddingModel;

  @BuiltValueField(wireName: r'embeddingDimension')
  int? get embeddingDimension;

  @BuiltValueField(wireName: r'chunkSize')
  int? get chunkSize;

  @BuiltValueField(wireName: r'chunkOverlap')
  int? get chunkOverlap;

  @BuiltValueField(wireName: r'documentCount')
  int? get documentCount;

  @BuiltValueField(wireName: r'chunkCount')
  int? get chunkCount;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  KnowledgeBaseVO._();

  factory KnowledgeBaseVO([void updates(KnowledgeBaseVOBuilder b)]) =
      _$KnowledgeBaseVO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnowledgeBaseVOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnowledgeBaseVO> get serializer =>
      _$KnowledgeBaseVOSerializer();
}

class _$KnowledgeBaseVOSerializer
    implements PrimitiveSerializer<KnowledgeBaseVO> {
  @override
  final Iterable<Type> types = const [KnowledgeBaseVO, _$KnowledgeBaseVO];

  @override
  final String wireName = r'KnowledgeBaseVO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnowledgeBaseVO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
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
    if (object.embeddingModel != null) {
      yield r'embeddingModel';
      yield serializers.serialize(
        object.embeddingModel,
        specifiedType: const FullType(String),
      );
    }
    if (object.embeddingDimension != null) {
      yield r'embeddingDimension';
      yield serializers.serialize(
        object.embeddingDimension,
        specifiedType: const FullType(int),
      );
    }
    if (object.chunkSize != null) {
      yield r'chunkSize';
      yield serializers.serialize(
        object.chunkSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.chunkOverlap != null) {
      yield r'chunkOverlap';
      yield serializers.serialize(
        object.chunkOverlap,
        specifiedType: const FullType(int),
      );
    }
    if (object.documentCount != null) {
      yield r'documentCount';
      yield serializers.serialize(
        object.documentCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.chunkCount != null) {
      yield r'chunkCount';
      yield serializers.serialize(
        object.chunkCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
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
    KnowledgeBaseVO object, {
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
    required KnowledgeBaseVOBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'embeddingModel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.embeddingModel = valueDes;
          break;
        case r'embeddingDimension':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.embeddingDimension = valueDes;
          break;
        case r'chunkSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chunkSize = valueDes;
          break;
        case r'chunkOverlap':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chunkOverlap = valueDes;
          break;
        case r'documentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.documentCount = valueDes;
          break;
        case r'chunkCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chunkCount = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
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
  KnowledgeBaseVO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnowledgeBaseVOBuilder();
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
