//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_progress_request.g.dart';

/// 更新学习进度请求
///
/// Properties:
/// * [courseId] - 课程ID
/// * [sectionId] - 小节ID
/// * [lastPosition] - 上次观看位置(秒)
/// * [watchDuration] - 观看时长(秒)
/// * [progress] - 学习进度(百分比)
@BuiltValue()
abstract class UpdateProgressRequest
    implements Built<UpdateProgressRequest, UpdateProgressRequestBuilder> {
  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int get courseId;

  /// 小节ID
  @BuiltValueField(wireName: r'sectionId')
  int get sectionId;

  /// 上次观看位置(秒)
  @BuiltValueField(wireName: r'lastPosition')
  int get lastPosition;

  /// 观看时长(秒)
  @BuiltValueField(wireName: r'watchDuration')
  int get watchDuration;

  /// 学习进度(百分比)
  @BuiltValueField(wireName: r'progress')
  int get progress;

  UpdateProgressRequest._();

  factory UpdateProgressRequest(
      [void updates(UpdateProgressRequestBuilder b)]) = _$UpdateProgressRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateProgressRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateProgressRequest> get serializer =>
      _$UpdateProgressRequestSerializer();
}

class _$UpdateProgressRequestSerializer
    implements PrimitiveSerializer<UpdateProgressRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateProgressRequest,
    _$UpdateProgressRequest
  ];

  @override
  final String wireName = r'UpdateProgressRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateProgressRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'courseId';
    yield serializers.serialize(
      object.courseId,
      specifiedType: const FullType(int),
    );
    yield r'sectionId';
    yield serializers.serialize(
      object.sectionId,
      specifiedType: const FullType(int),
    );
    yield r'lastPosition';
    yield serializers.serialize(
      object.lastPosition,
      specifiedType: const FullType(int),
    );
    yield r'watchDuration';
    yield serializers.serialize(
      object.watchDuration,
      specifiedType: const FullType(int),
    );
    yield r'progress';
    yield serializers.serialize(
      object.progress,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateProgressRequest object, {
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
    required UpdateProgressRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'lastPosition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lastPosition = valueDes;
          break;
        case r'watchDuration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.watchDuration = valueDes;
          break;
        case r'progress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.progress = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateProgressRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateProgressRequestBuilder();
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
