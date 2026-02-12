//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_template_response.g.dart';

/// 工作流模板响应
///
/// Properties:
/// * [id] - 模板ID
/// * [name] - 模板名称
/// * [description] - 模板描述
/// * [category] - 分类
/// * [icon] - 图标URL
/// * [definition] - 工作流定义JSON
/// * [tags] - 标签
/// * [creatorId] - 创建者ID
/// * [usageCount] - 使用次数
/// * [createTime] - 创建时间
/// * [public]
/// * [system]
@BuiltValue()
abstract class WorkflowTemplateResponse
    implements
        Built<WorkflowTemplateResponse, WorkflowTemplateResponseBuilder> {
  /// 模板ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 模板名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 模板描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 分类
  @BuiltValueField(wireName: r'category')
  String? get category;

  /// 图标URL
  @BuiltValueField(wireName: r'icon')
  String? get icon;

  /// 工作流定义JSON
  @BuiltValueField(wireName: r'definition')
  String? get definition;

  /// 标签
  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  /// 创建者ID
  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  /// 使用次数
  @BuiltValueField(wireName: r'usageCount')
  int? get usageCount;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'public')
  bool? get public;

  @BuiltValueField(wireName: r'system')
  bool? get system;

  WorkflowTemplateResponse._();

  factory WorkflowTemplateResponse(
          [void updates(WorkflowTemplateResponseBuilder b)]) =
      _$WorkflowTemplateResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowTemplateResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowTemplateResponse> get serializer =>
      _$WorkflowTemplateResponseSerializer();
}

class _$WorkflowTemplateResponseSerializer
    implements PrimitiveSerializer<WorkflowTemplateResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowTemplateResponse,
    _$WorkflowTemplateResponse
  ];

  @override
  final String wireName = r'WorkflowTemplateResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowTemplateResponse object, {
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
    if (object.category != null) {
      yield r'category';
      yield serializers.serialize(
        object.category,
        specifiedType: const FullType(String),
      );
    }
    if (object.icon != null) {
      yield r'icon';
      yield serializers.serialize(
        object.icon,
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
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.creatorId != null) {
      yield r'creatorId';
      yield serializers.serialize(
        object.creatorId,
        specifiedType: const FullType(int),
      );
    }
    if (object.usageCount != null) {
      yield r'usageCount';
      yield serializers.serialize(
        object.usageCount,
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
    if (object.public != null) {
      yield r'public';
      yield serializers.serialize(
        object.public,
        specifiedType: const FullType(bool),
      );
    }
    if (object.system != null) {
      yield r'system';
      yield serializers.serialize(
        object.system,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowTemplateResponse object, {
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
    required WorkflowTemplateResponseBuilder result,
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
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.icon = valueDes;
          break;
        case r'definition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.definition = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'creatorId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.creatorId = valueDes;
          break;
        case r'usageCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.usageCount = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'public':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.public = valueDes;
          break;
        case r'system':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.system = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WorkflowTemplateResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowTemplateResponseBuilder();
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
