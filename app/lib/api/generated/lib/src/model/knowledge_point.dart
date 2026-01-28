//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/knowledge_point_id.dart';
import 'package:nova_api/src/model/chapter_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'knowledge_point.g.dart';

/// KnowledgePoint
///
/// Properties:
/// * [id]
/// * [chapterId]
/// * [pointType]
/// * [name]
/// * [description]
/// * [position]
/// * [relatedChapterIds]
/// * [relatedPointIds]
/// * [createTime]
@BuiltValue()
abstract class KnowledgePoint
    implements Built<KnowledgePoint, KnowledgePointBuilder> {
  @BuiltValueField(wireName: r'id')
  KnowledgePointId? get id;

  @BuiltValueField(wireName: r'chapterId')
  ChapterId? get chapterId;

  @BuiltValueField(wireName: r'pointType')
  KnowledgePointPointTypeEnum? get pointType;
  // enum pointTypeEnum {  CONCEPT,  TERM,  FORMULA,  PRINCIPLE,  METHOD,  };

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'position')
  int? get position;

  @BuiltValueField(wireName: r'relatedChapterIds')
  BuiltList<int>? get relatedChapterIds;

  @BuiltValueField(wireName: r'relatedPointIds')
  BuiltList<int>? get relatedPointIds;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  KnowledgePoint._();

  factory KnowledgePoint([void updates(KnowledgePointBuilder b)]) =
      _$KnowledgePoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KnowledgePointBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KnowledgePoint> get serializer =>
      _$KnowledgePointSerializer();
}

class _$KnowledgePointSerializer
    implements PrimitiveSerializer<KnowledgePoint> {
  @override
  final Iterable<Type> types = const [KnowledgePoint, _$KnowledgePoint];

  @override
  final String wireName = r'KnowledgePoint';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KnowledgePoint object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(KnowledgePointId),
      );
    }
    if (object.chapterId != null) {
      yield r'chapterId';
      yield serializers.serialize(
        object.chapterId,
        specifiedType: const FullType(ChapterId),
      );
    }
    if (object.pointType != null) {
      yield r'pointType';
      yield serializers.serialize(
        object.pointType,
        specifiedType: const FullType(KnowledgePointPointTypeEnum),
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
    if (object.position != null) {
      yield r'position';
      yield serializers.serialize(
        object.position,
        specifiedType: const FullType(int),
      );
    }
    if (object.relatedChapterIds != null) {
      yield r'relatedChapterIds';
      yield serializers.serialize(
        object.relatedChapterIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.relatedPointIds != null) {
      yield r'relatedPointIds';
      yield serializers.serialize(
        object.relatedPointIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KnowledgePoint object, {
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
    required KnowledgePointBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnowledgePointId),
          ) as KnowledgePointId;
          result.id.replace(valueDes);
          break;
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChapterId),
          ) as ChapterId;
          result.chapterId.replace(valueDes);
          break;
        case r'pointType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KnowledgePointPointTypeEnum),
          ) as KnowledgePointPointTypeEnum;
          result.pointType = valueDes;
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
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.position = valueDes;
          break;
        case r'relatedChapterIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.relatedChapterIds.replace(valueDes);
          break;
        case r'relatedPointIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.relatedPointIds.replace(valueDes);
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KnowledgePoint deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KnowledgePointBuilder();
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

class KnowledgePointPointTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'CONCEPT')
  static const KnowledgePointPointTypeEnum CONCEPT =
      _$knowledgePointPointTypeEnum_CONCEPT;
  @BuiltValueEnumConst(wireName: r'TERM')
  static const KnowledgePointPointTypeEnum TERM =
      _$knowledgePointPointTypeEnum_TERM;
  @BuiltValueEnumConst(wireName: r'FORMULA')
  static const KnowledgePointPointTypeEnum FORMULA =
      _$knowledgePointPointTypeEnum_FORMULA;
  @BuiltValueEnumConst(wireName: r'PRINCIPLE')
  static const KnowledgePointPointTypeEnum PRINCIPLE =
      _$knowledgePointPointTypeEnum_PRINCIPLE;
  @BuiltValueEnumConst(wireName: r'METHOD')
  static const KnowledgePointPointTypeEnum METHOD =
      _$knowledgePointPointTypeEnum_METHOD;

  static Serializer<KnowledgePointPointTypeEnum> get serializer =>
      _$knowledgePointPointTypeEnumSerializer;

  const KnowledgePointPointTypeEnum._(String name) : super(name);

  static BuiltSet<KnowledgePointPointTypeEnum> get values =>
      _$knowledgePointPointTypeEnumValues;
  static KnowledgePointPointTypeEnum valueOf(String name) =>
      _$knowledgePointPointTypeEnumValueOf(name);
}
