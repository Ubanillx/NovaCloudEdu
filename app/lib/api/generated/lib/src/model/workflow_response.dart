//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_response.g.dart';

/// 工作流响应
///
/// Properties:
/// * [id] - 工作流ID
/// * [name] - 工作流名称
/// * [description] - 工作流描述
/// * [definition] - 工作流定义JSON字符串
/// * [status] - 工作流状态
/// * [version] - 版本号
/// * [creatorId] - 创建者ID
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
/// * [public]
@BuiltValue()
abstract class WorkflowResponse
    implements Built<WorkflowResponse, WorkflowResponseBuilder> {
  /// 工作流ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 工作流名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 工作流描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 工作流定义JSON字符串
  @BuiltValueField(wireName: r'definition')
  String? get definition;

  /// 工作流状态
  @BuiltValueField(wireName: r'status')
  WorkflowResponseStatusEnum? get status;
  // enum statusEnum {  DRAFT,  PUBLISHED,  ARCHIVED,  };

  /// 版本号
  @BuiltValueField(wireName: r'version')
  int? get version;

  /// 创建者ID
  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'public')
  bool? get public;

  WorkflowResponse._();

  factory WorkflowResponse([void updates(WorkflowResponseBuilder b)]) =
      _$WorkflowResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowResponse> get serializer =>
      _$WorkflowResponseSerializer();
}

class _$WorkflowResponseSerializer
    implements PrimitiveSerializer<WorkflowResponse> {
  @override
  final Iterable<Type> types = const [WorkflowResponse, _$WorkflowResponse];

  @override
  final String wireName = r'WorkflowResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowResponse object, {
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
    if (object.definition != null) {
      yield r'definition';
      yield serializers.serialize(
        object.definition,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(WorkflowResponseStatusEnum),
      );
    }
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType(int),
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
    if (object.public != null) {
      yield r'public';
      yield serializers.serialize(
        object.public,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowResponse object, {
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
    required WorkflowResponseBuilder result,
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
        case r'definition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.definition = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(WorkflowResponseStatusEnum),
          ) as WorkflowResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
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
        case r'public':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.public = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowResponseBuilder();
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

class WorkflowResponseStatusEnum extends EnumClass {
  /// 工作流状态
  @BuiltValueEnumConst(wireName: r'DRAFT')
  static const WorkflowResponseStatusEnum DRAFT =
      _$workflowResponseStatusEnum_DRAFT;

  /// 工作流状态
  @BuiltValueEnumConst(wireName: r'PUBLISHED')
  static const WorkflowResponseStatusEnum PUBLISHED =
      _$workflowResponseStatusEnum_PUBLISHED;

  /// 工作流状态
  @BuiltValueEnumConst(wireName: r'ARCHIVED')
  static const WorkflowResponseStatusEnum ARCHIVED =
      _$workflowResponseStatusEnum_ARCHIVED;

  static Serializer<WorkflowResponseStatusEnum> get serializer =>
      _$workflowResponseStatusEnumSerializer;

  const WorkflowResponseStatusEnum._(String name) : super(name);

  static BuiltSet<WorkflowResponseStatusEnum> get values =>
      _$workflowResponseStatusEnumValues;
  static WorkflowResponseStatusEnum valueOf(String name) =>
      _$workflowResponseStatusEnumValueOf(name);
}
