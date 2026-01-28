//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_section_request.g.dart';

/// 创建小节请求
///
/// Properties:
/// * [chapterId] - 章节ID
/// * [title] - 小节标题
/// * [duration] - 时长(秒)
/// * [sort] - 排序，数字越小排序越靠前
/// * [isFree] - 是否免费：false-否，true-是
/// * [description] - 小节描述
/// * [videoUrl] - 视频URL
/// * [resourceUrl] - 资源URL
@BuiltValue()
abstract class CreateSectionRequest
    implements Built<CreateSectionRequest, CreateSectionRequestBuilder> {
  /// 章节ID
  @BuiltValueField(wireName: r'chapterId')
  int get chapterId;

  /// 小节标题
  @BuiltValueField(wireName: r'title')
  String get title;

  /// 时长(秒)
  @BuiltValueField(wireName: r'duration')
  int get duration;

  /// 排序，数字越小排序越靠前
  @BuiltValueField(wireName: r'sort')
  int get sort;

  /// 是否免费：false-否，true-是
  @BuiltValueField(wireName: r'isFree')
  bool get isFree;

  /// 小节描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 视频URL
  @BuiltValueField(wireName: r'videoUrl')
  String? get videoUrl;

  /// 资源URL
  @BuiltValueField(wireName: r'resourceUrl')
  String? get resourceUrl;

  CreateSectionRequest._();

  factory CreateSectionRequest([void updates(CreateSectionRequestBuilder b)]) =
      _$CreateSectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSectionRequest> get serializer =>
      _$CreateSectionRequestSerializer();
}

class _$CreateSectionRequestSerializer
    implements PrimitiveSerializer<CreateSectionRequest> {
  @override
  final Iterable<Type> types = const [
    CreateSectionRequest,
    _$CreateSectionRequest
  ];

  @override
  final String wireName = r'CreateSectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'chapterId';
    yield serializers.serialize(
      object.chapterId,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'duration';
    yield serializers.serialize(
      object.duration,
      specifiedType: const FullType(int),
    );
    yield r'sort';
    yield serializers.serialize(
      object.sort,
      specifiedType: const FullType(int),
    );
    yield r'isFree';
    yield serializers.serialize(
      object.isFree,
      specifiedType: const FullType(bool),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      );
    }
    if (object.videoUrl != null) {
      yield r'videoUrl';
      yield serializers.serialize(
        object.videoUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.resourceUrl != null) {
      yield r'resourceUrl';
      yield serializers.serialize(
        object.resourceUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSectionRequest object, {
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
    required CreateSectionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'chapterId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.chapterId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'duration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.duration = valueDes;
          break;
        case r'sort':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sort = valueDes;
          break;
        case r'isFree':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFree = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'videoUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.videoUrl = valueDes;
          break;
        case r'resourceUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSectionRequestBuilder();
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
