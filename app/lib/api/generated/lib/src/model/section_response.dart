//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'section_response.g.dart';

/// 小节信息响应
///
/// Properties:
/// * [id] - 小节ID
/// * [courseId] - 课程ID
/// * [chapterId] - 章节ID
/// * [title] - 小节标题
/// * [description] - 小节描述
/// * [videoUrl] - 视频URL
/// * [duration] - 时长(秒)
/// * [sort] - 排序
/// * [isFree] - 是否免费
/// * [resourceUrl] - 资源URL
/// * [hlsUrl] - HLS播放地址(m3u8)
/// * [accessible] - 当前用户是否可访问此小节
/// * [transcodeStatus] - 转码状态: 0-未转码, 1-转码中, 2-已完成, 3-失败
/// * [thumbnailUrl] - 缩略图雪碧图URL
/// * [thumbnailCount] - 缩略图数量
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class SectionResponse
    implements Built<SectionResponse, SectionResponseBuilder> {
  /// 小节ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  /// 章节ID
  @BuiltValueField(wireName: r'chapterId')
  int? get chapterId;

  /// 小节标题
  @BuiltValueField(wireName: r'title')
  String? get title;

  /// 小节描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 视频URL
  @BuiltValueField(wireName: r'videoUrl')
  String? get videoUrl;

  /// 时长(秒)
  @BuiltValueField(wireName: r'duration')
  int? get duration;

  /// 排序
  @BuiltValueField(wireName: r'sort')
  int? get sort;

  /// 是否免费
  @BuiltValueField(wireName: r'isFree')
  bool? get isFree;

  /// 资源URL
  @BuiltValueField(wireName: r'resourceUrl')
  String? get resourceUrl;

  /// HLS播放地址(m3u8)
  @BuiltValueField(wireName: r'hlsUrl')
  String? get hlsUrl;

  /// 当前用户是否可访问此小节
  @BuiltValueField(wireName: r'accessible')
  bool? get accessible;

  /// 转码状态: 0-未转码, 1-转码中, 2-已完成, 3-失败
  @BuiltValueField(wireName: r'transcodeStatus')
  int? get transcodeStatus;

  /// 缩略图雪碧图URL
  @BuiltValueField(wireName: r'thumbnailUrl')
  String? get thumbnailUrl;

  /// 缩略图数量
  @BuiltValueField(wireName: r'thumbnailCount')
  int? get thumbnailCount;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  SectionResponse._();

  factory SectionResponse([void updates(SectionResponseBuilder b)]) =
      _$SectionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SectionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SectionResponse> get serializer =>
      _$SectionResponseSerializer();
}

class _$SectionResponseSerializer
    implements PrimitiveSerializer<SectionResponse> {
  @override
  final Iterable<Type> types = const [SectionResponse, _$SectionResponse];

  @override
  final String wireName = r'SectionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SectionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.courseId != null) {
      yield r'courseId';
      yield serializers.serialize(
        object.courseId,
        specifiedType: const FullType(int),
      );
    }
    if (object.chapterId != null) {
      yield r'chapterId';
      yield serializers.serialize(
        object.chapterId,
        specifiedType: const FullType(int),
      );
    }
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
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
    if (object.videoUrl != null) {
      yield r'videoUrl';
      yield serializers.serialize(
        object.videoUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.duration != null) {
      yield r'duration';
      yield serializers.serialize(
        object.duration,
        specifiedType: const FullType(int),
      );
    }
    if (object.sort != null) {
      yield r'sort';
      yield serializers.serialize(
        object.sort,
        specifiedType: const FullType(int),
      );
    }
    if (object.isFree != null) {
      yield r'isFree';
      yield serializers.serialize(
        object.isFree,
        specifiedType: const FullType(bool),
      );
    }
    if (object.resourceUrl != null) {
      yield r'resourceUrl';
      yield serializers.serialize(
        object.resourceUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.hlsUrl != null) {
      yield r'hlsUrl';
      yield serializers.serialize(
        object.hlsUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.accessible != null) {
      yield r'accessible';
      yield serializers.serialize(
        object.accessible,
        specifiedType: const FullType(bool),
      );
    }
    if (object.transcodeStatus != null) {
      yield r'transcodeStatus';
      yield serializers.serialize(
        object.transcodeStatus,
        specifiedType: const FullType(int),
      );
    }
    if (object.thumbnailUrl != null) {
      yield r'thumbnailUrl';
      yield serializers.serialize(
        object.thumbnailUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.thumbnailCount != null) {
      yield r'thumbnailCount';
      yield serializers.serialize(
        object.thumbnailCount,
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
    SectionResponse object, {
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
    required SectionResponseBuilder result,
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
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
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
        case r'resourceUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.resourceUrl = valueDes;
          break;
        case r'hlsUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.hlsUrl = valueDes;
          break;
        case r'accessible':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.accessible = valueDes;
          break;
        case r'transcodeStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.transcodeStatus = valueDes;
          break;
        case r'thumbnailUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.thumbnailUrl = valueDes;
          break;
        case r'thumbnailCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.thumbnailCount = valueDes;
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
  SectionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SectionResponseBuilder();
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
