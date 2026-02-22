//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'live_room_response.g.dart';

/// LiveRoomResponse
///
/// Properties:
/// * [id]
/// * [title]
/// * [description]
/// * [coverUrl]
/// * [hostUserId]
/// * [classId]
/// * [status]
/// * [visibility]
/// * [viewerCount]
/// * [peakViewers]
/// * [startedAt]
/// * [endedAt]
/// * [duration]
/// * [playbackUrl]
/// * [createTime]
/// * [streamKey]
/// * [rtmpUrl]
/// * [flvPlayUrl]
/// * [hlsPlayUrl]
/// * [recording]
@BuiltValue()
abstract class LiveRoomResponse
    implements Built<LiveRoomResponse, LiveRoomResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'coverUrl')
  String? get coverUrl;

  @BuiltValueField(wireName: r'hostUserId')
  int? get hostUserId;

  @BuiltValueField(wireName: r'classId')
  int? get classId;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'visibility')
  String? get visibility;

  @BuiltValueField(wireName: r'viewerCount')
  int? get viewerCount;

  @BuiltValueField(wireName: r'peakViewers')
  int? get peakViewers;

  @BuiltValueField(wireName: r'startedAt')
  DateTime? get startedAt;

  @BuiltValueField(wireName: r'endedAt')
  DateTime? get endedAt;

  @BuiltValueField(wireName: r'duration')
  int? get duration;

  @BuiltValueField(wireName: r'playbackUrl')
  String? get playbackUrl;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'streamKey')
  String? get streamKey;

  @BuiltValueField(wireName: r'rtmpUrl')
  String? get rtmpUrl;

  @BuiltValueField(wireName: r'flvPlayUrl')
  String? get flvPlayUrl;

  @BuiltValueField(wireName: r'hlsPlayUrl')
  String? get hlsPlayUrl;

  @BuiltValueField(wireName: r'recording')
  bool? get recording;

  LiveRoomResponse._();

  factory LiveRoomResponse([void updates(LiveRoomResponseBuilder b)]) =
      _$LiveRoomResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LiveRoomResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LiveRoomResponse> get serializer =>
      _$LiveRoomResponseSerializer();
}

class _$LiveRoomResponseSerializer
    implements PrimitiveSerializer<LiveRoomResponse> {
  @override
  final Iterable<Type> types = const [LiveRoomResponse, _$LiveRoomResponse];

  @override
  final String wireName = r'LiveRoomResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LiveRoomResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
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
    if (object.coverUrl != null) {
      yield r'coverUrl';
      yield serializers.serialize(
        object.coverUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.hostUserId != null) {
      yield r'hostUserId';
      yield serializers.serialize(
        object.hostUserId,
        specifiedType: const FullType(int),
      );
    }
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.visibility != null) {
      yield r'visibility';
      yield serializers.serialize(
        object.visibility,
        specifiedType: const FullType(String),
      );
    }
    if (object.viewerCount != null) {
      yield r'viewerCount';
      yield serializers.serialize(
        object.viewerCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.peakViewers != null) {
      yield r'peakViewers';
      yield serializers.serialize(
        object.peakViewers,
        specifiedType: const FullType(int),
      );
    }
    if (object.startedAt != null) {
      yield r'startedAt';
      yield serializers.serialize(
        object.startedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.endedAt != null) {
      yield r'endedAt';
      yield serializers.serialize(
        object.endedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.duration != null) {
      yield r'duration';
      yield serializers.serialize(
        object.duration,
        specifiedType: const FullType(int),
      );
    }
    if (object.playbackUrl != null) {
      yield r'playbackUrl';
      yield serializers.serialize(
        object.playbackUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.streamKey != null) {
      yield r'streamKey';
      yield serializers.serialize(
        object.streamKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.rtmpUrl != null) {
      yield r'rtmpUrl';
      yield serializers.serialize(
        object.rtmpUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.flvPlayUrl != null) {
      yield r'flvPlayUrl';
      yield serializers.serialize(
        object.flvPlayUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.hlsPlayUrl != null) {
      yield r'hlsPlayUrl';
      yield serializers.serialize(
        object.hlsPlayUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.recording != null) {
      yield r'recording';
      yield serializers.serialize(
        object.recording,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LiveRoomResponse object, {
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
    required LiveRoomResponseBuilder result,
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
        case r'coverUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.coverUrl = valueDes;
          break;
        case r'hostUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.hostUserId = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'visibility':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.visibility = valueDes;
          break;
        case r'viewerCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.viewerCount = valueDes;
          break;
        case r'peakViewers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.peakViewers = valueDes;
          break;
        case r'startedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.startedAt = valueDes;
          break;
        case r'endedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.endedAt = valueDes;
          break;
        case r'duration':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.duration = valueDes;
          break;
        case r'playbackUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.playbackUrl = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'streamKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.streamKey = valueDes;
          break;
        case r'rtmpUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.rtmpUrl = valueDes;
          break;
        case r'flvPlayUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flvPlayUrl = valueDes;
          break;
        case r'hlsPlayUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.hlsPlayUrl = valueDes;
          break;
        case r'recording':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.recording = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LiveRoomResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LiveRoomResponseBuilder();
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
