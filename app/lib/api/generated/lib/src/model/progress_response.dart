//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'progress_response.g.dart';

/// 学习进度响应
///
/// Properties:
/// * [id] - 进度ID
/// * [userId] - 用户ID
/// * [courseId] - 课程ID
/// * [sectionId] - 小节ID
/// * [progress] - 学习进度(百分比)
/// * [watchDuration] - 观看时长(秒)
/// * [lastPosition] - 上次观看位置(秒)
/// * [isCompleted] - 是否完成
/// * [completedTime] - 完成时间
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class ProgressResponse
    implements Built<ProgressResponse, ProgressResponseBuilder> {
  /// 进度ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  /// 小节ID
  @BuiltValueField(wireName: r'sectionId')
  int? get sectionId;

  /// 学习进度(百分比)
  @BuiltValueField(wireName: r'progress')
  int? get progress;

  /// 观看时长(秒)
  @BuiltValueField(wireName: r'watchDuration')
  int? get watchDuration;

  /// 上次观看位置(秒)
  @BuiltValueField(wireName: r'lastPosition')
  int? get lastPosition;

  /// 是否完成
  @BuiltValueField(wireName: r'isCompleted')
  bool? get isCompleted;

  /// 完成时间
  @BuiltValueField(wireName: r'completedTime')
  DateTime? get completedTime;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  ProgressResponse._();

  factory ProgressResponse([void updates(ProgressResponseBuilder b)]) =
      _$ProgressResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProgressResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProgressResponse> get serializer =>
      _$ProgressResponseSerializer();
}

class _$ProgressResponseSerializer
    implements PrimitiveSerializer<ProgressResponse> {
  @override
  final Iterable<Type> types = const [ProgressResponse, _$ProgressResponse];

  @override
  final String wireName = r'ProgressResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProgressResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
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
    if (object.sectionId != null) {
      yield r'sectionId';
      yield serializers.serialize(
        object.sectionId,
        specifiedType: const FullType(int),
      );
    }
    if (object.progress != null) {
      yield r'progress';
      yield serializers.serialize(
        object.progress,
        specifiedType: const FullType(int),
      );
    }
    if (object.watchDuration != null) {
      yield r'watchDuration';
      yield serializers.serialize(
        object.watchDuration,
        specifiedType: const FullType(int),
      );
    }
    if (object.lastPosition != null) {
      yield r'lastPosition';
      yield serializers.serialize(
        object.lastPosition,
        specifiedType: const FullType(int),
      );
    }
    if (object.isCompleted != null) {
      yield r'isCompleted';
      yield serializers.serialize(
        object.isCompleted,
        specifiedType: const FullType(bool),
      );
    }
    if (object.completedTime != null) {
      yield r'completedTime';
      yield serializers.serialize(
        object.completedTime,
        specifiedType: const FullType(DateTime),
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
    ProgressResponse object, {
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
    required ProgressResponseBuilder result,
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
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        case r'sectionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sectionId = valueDes;
          break;
        case r'progress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.progress = valueDes;
          break;
        case r'watchDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.watchDuration = valueDes;
          break;
        case r'lastPosition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPosition = valueDes;
          break;
        case r'isCompleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCompleted = valueDes;
          break;
        case r'completedTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.completedTime = valueDes;
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
  ProgressResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProgressResponseBuilder();
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
