//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'exam_template_response.g.dart';

/// 试卷模板响应
///
/// Properties:
/// * [id] - 模板ID
/// * [name] - 模板名称
/// * [description] - 模板描述
/// * [templateUrl] - 模板文件URL
/// * [coverUrl] - 预览封面URL
/// * [isSystem] - 是否系统内置
/// * [isEnabled] - 是否启用
/// * [creatorId] - 创建者ID
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class ExamTemplateResponse
    implements Built<ExamTemplateResponse, ExamTemplateResponseBuilder> {
  /// 模板ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 模板名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 模板描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 模板文件URL
  @BuiltValueField(wireName: r'templateUrl')
  String? get templateUrl;

  /// 预览封面URL
  @BuiltValueField(wireName: r'coverUrl')
  String? get coverUrl;

  /// 是否系统内置
  @BuiltValueField(wireName: r'isSystem')
  bool? get isSystem;

  /// 是否启用
  @BuiltValueField(wireName: r'isEnabled')
  bool? get isEnabled;

  /// 创建者ID
  @BuiltValueField(wireName: r'creatorId')
  int? get creatorId;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  String? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  String? get updateTime;

  ExamTemplateResponse._();

  factory ExamTemplateResponse([void updates(ExamTemplateResponseBuilder b)]) =
      _$ExamTemplateResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExamTemplateResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExamTemplateResponse> get serializer =>
      _$ExamTemplateResponseSerializer();
}

class _$ExamTemplateResponseSerializer
    implements PrimitiveSerializer<ExamTemplateResponse> {
  @override
  final Iterable<Type> types = const [
    ExamTemplateResponse,
    _$ExamTemplateResponse
  ];

  @override
  final String wireName = r'ExamTemplateResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExamTemplateResponse object, {
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
    if (object.templateUrl != null) {
      yield r'templateUrl';
      yield serializers.serialize(
        object.templateUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.coverUrl != null) {
      yield r'coverUrl';
      yield serializers.serialize(
        object.coverUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.isSystem != null) {
      yield r'isSystem';
      yield serializers.serialize(
        object.isSystem,
        specifiedType: const FullType(bool),
      );
    }
    if (object.isEnabled != null) {
      yield r'isEnabled';
      yield serializers.serialize(
        object.isEnabled,
        specifiedType: const FullType(bool),
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
        specifiedType: const FullType(String),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExamTemplateResponse object, {
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
    required ExamTemplateResponseBuilder result,
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
        case r'templateUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.templateUrl = valueDes;
          break;
        case r'coverUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverUrl = valueDes;
          break;
        case r'isSystem':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isSystem = valueDes;
          break;
        case r'isEnabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isEnabled = valueDes;
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
            specifiedType: const FullType(String),
          ) as String;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ExamTemplateResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExamTemplateResponseBuilder();
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
