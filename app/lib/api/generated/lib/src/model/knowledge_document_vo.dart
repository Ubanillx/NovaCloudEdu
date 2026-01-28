//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'knowledge_document_vo.g.dart';

/// KnowledgeDocumentVO
///
/// Properties:
/// * [id]
/// * [knowledgeBaseId]
/// * [name]
/// * [fileType]
/// * [fileUrl]
/// * [fileSize]
/// * [chunkCount]
/// * [status]
/// * [errorMessage]
/// * [creatorId]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class KnowledgeDocumentVO
    implements Built<KnowledgeDocumentVO, KnowledgeDocumentVOBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'knowledgeBaseId')
  int? get knowledgeBaseId;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'fileType')
  String? get fileType;

  @BuiltValueField(wireName: r'fileUrl')
  String? get fileUrl;

  @BuiltValueField(wireName: r'fileSize')
  int? get fileSize;

  @BuiltValueField(wireName: r'chunkCount')
  int? get chunkCount;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  KnowledgeDocumentVO._();

  factory KnowledgeDocumentVO([void updates(KnowledgeDocumentVOBuilder b)]) =
      _$KnowledgeDocumentVO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnowledgeDocumentVOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnowledgeDocumentVO> get serializer =>
      _$KnowledgeDocumentVOSerializer();
}

class _$KnowledgeDocumentVOSerializer
    implements PrimitiveSerializer<KnowledgeDocumentVO> {
  @override
  final Iterable<Type> types = const [
    KnowledgeDocumentVO,
    _$KnowledgeDocumentVO
  ];

  @override
  final String wireName = r'KnowledgeDocumentVO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnowledgeDocumentVO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.knowledgeBaseId != null) {
      yield r'knowledgeBaseId';
      yield serializers.serialize(
        object.knowledgeBaseId,
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
    if (object.fileType != null) {
      yield r'fileType';
      yield serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileUrl != null) {
      yield r'fileUrl';
      yield serializers.serialize(
        object.fileUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileSize != null) {
      yield r'fileSize';
      yield serializers.serialize(
        object.fileSize,
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
    if (object.errorMessage != null) {
      yield r'errorMessage';
      yield serializers.serialize(
        object.errorMessage,
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
    KnowledgeDocumentVO object, {
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
    required KnowledgeDocumentVOBuilder result,
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
        case r'knowledgeBaseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.knowledgeBaseId = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'fileType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileType = valueDes;
          break;
        case r'fileUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileUrl = valueDes;
          break;
        case r'fileSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fileSize = valueDes;
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
        case r'errorMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errorMessage = valueDes;
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
  KnowledgeDocumentVO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnowledgeDocumentVOBuilder();
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
