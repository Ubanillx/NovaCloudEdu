//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'workflow_version_response.g.dart';

/// 工作流版本历史响应
///
/// Properties:
/// * [id] - 版本记录ID
/// * [workflowId] - 工作流ID
/// * [version] - 版本号
/// * [name] - 名称快照
/// * [description] - 描述快照
/// * [definition] - 工作流定义快照JSON
/// * [publishNote] - 发布说明
/// * [publishedBy] - 发布者ID
/// * [createTime] - 创建时间
@BuiltValue()
abstract class WorkflowVersionResponse
    implements Built<WorkflowVersionResponse, WorkflowVersionResponseBuilder> {
  /// 版本记录ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 工作流ID
  @BuiltValueField(wireName: r'workflowId')
  int? get workflowId;

  /// 版本号
  @BuiltValueField(wireName: r'version')
  int? get version;

  /// 名称快照
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 描述快照
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 工作流定义快照JSON
  @BuiltValueField(wireName: r'definition')
  String? get definition;

  /// 发布说明
  @BuiltValueField(wireName: r'publishNote')
  String? get publishNote;

  /// 发布者ID
  @BuiltValueField(wireName: r'publishedBy')
  int? get publishedBy;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  WorkflowVersionResponse._();

  factory WorkflowVersionResponse(
          [void updates(WorkflowVersionResponseBuilder b)]) =
      _$WorkflowVersionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WorkflowVersionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WorkflowVersionResponse> get serializer =>
      _$WorkflowVersionResponseSerializer();
}

class _$WorkflowVersionResponseSerializer
    implements PrimitiveSerializer<WorkflowVersionResponse> {
  @override
  final Iterable<Type> types = const [
    WorkflowVersionResponse,
    _$WorkflowVersionResponse
  ];

  @override
  final String wireName = r'WorkflowVersionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WorkflowVersionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(int),
      );
    }
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
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
    if (object.publishNote != null) {
      yield r'publishNote';
      yield serializers.serialize(
        object.publishNote,
        specifiedType: const FullType(String),
      );
    }
    if (object.publishedBy != null) {
      yield r'publishedBy';
      yield serializers.serialize(
        object.publishedBy,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    WorkflowVersionResponse object, {
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
    required WorkflowVersionResponseBuilder result,
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
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.workflowId = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
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
        case r'publishNote':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.publishNote = valueDes;
          break;
        case r'publishedBy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.publishedBy = valueDes;
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
  WorkflowVersionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WorkflowVersionResponseBuilder();
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
