//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ppt_template_detail_response.g.dart';

/// PPT模板详情
///
/// Properties:
/// * [id] - 模板ID
/// * [name] - 模板名称
/// * [description] - 模板描述
/// * [coverUrl] - 封面图URL
/// * [templateUrl] - 模板文件URL
/// * [slideCount] - 页数
/// * [structureJson] - 模板结构JSON（含每页槽位信息）
/// * [enabled] - 是否启用
@BuiltValue()
abstract class PptTemplateDetailResponse
    implements
        Built<PptTemplateDetailResponse, PptTemplateDetailResponseBuilder> {
  /// 模板ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 模板名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 模板描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 封面图URL
  @BuiltValueField(wireName: r'coverUrl')
  String? get coverUrl;

  /// 模板文件URL
  @BuiltValueField(wireName: r'templateUrl')
  String? get templateUrl;

  /// 页数
  @BuiltValueField(wireName: r'slideCount')
  int? get slideCount;

  /// 模板结构JSON（含每页槽位信息）
  @BuiltValueField(wireName: r'structureJson')
  String? get structureJson;

  /// 是否启用
  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  PptTemplateDetailResponse._();

  factory PptTemplateDetailResponse(
          [void updates(PptTemplateDetailResponseBuilder b)]) =
      _$PptTemplateDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PptTemplateDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PptTemplateDetailResponse> get serializer =>
      _$PptTemplateDetailResponseSerializer();
}

class _$PptTemplateDetailResponseSerializer
    implements PrimitiveSerializer<PptTemplateDetailResponse> {
  @override
  final Iterable<Type> types = const [
    PptTemplateDetailResponse,
    _$PptTemplateDetailResponse
  ];

  @override
  final String wireName = r'PptTemplateDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PptTemplateDetailResponse object, {
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
    if (object.coverUrl != null) {
      yield r'coverUrl';
      yield serializers.serialize(
        object.coverUrl,
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
    if (object.slideCount != null) {
      yield r'slideCount';
      yield serializers.serialize(
        object.slideCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.structureJson != null) {
      yield r'structureJson';
      yield serializers.serialize(
        object.structureJson,
        specifiedType: const FullType(String),
      );
    }
    if (object.enabled != null) {
      yield r'enabled';
      yield serializers.serialize(
        object.enabled,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PptTemplateDetailResponse object, {
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
    required PptTemplateDetailResponseBuilder result,
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
        case r'coverUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverUrl = valueDes;
          break;
        case r'templateUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.templateUrl = valueDes;
          break;
        case r'slideCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.slideCount = valueDes;
          break;
        case r'structureJson':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.structureJson = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PptTemplateDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PptTemplateDetailResponseBuilder();
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
