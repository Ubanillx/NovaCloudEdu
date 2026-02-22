//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'save_call_record_request.g.dart';

/// SaveCallRecordRequest
///
/// Properties:
/// * [callId]
/// * [callerId]
/// * [calleeId]
/// * [mediaType]
/// * [status]
/// * [mode]
/// * [startedAt]
/// * [endedAt]
/// * [duration]
@BuiltValue()
abstract class SaveCallRecordRequest
    implements Built<SaveCallRecordRequest, SaveCallRecordRequestBuilder> {
  @BuiltValueField(wireName: r'callId')
  String? get callId;

  @BuiltValueField(wireName: r'callerId')
  int? get callerId;

  @BuiltValueField(wireName: r'calleeId')
  int? get calleeId;

  @BuiltValueField(wireName: r'mediaType')
  String? get mediaType;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'mode')
  String? get mode;

  @BuiltValueField(wireName: r'startedAt')
  DateTime? get startedAt;

  @BuiltValueField(wireName: r'endedAt')
  DateTime? get endedAt;

  @BuiltValueField(wireName: r'duration')
  int? get duration;

  SaveCallRecordRequest._();

  factory SaveCallRecordRequest(
      [void updates(SaveCallRecordRequestBuilder b)]) = _$SaveCallRecordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SaveCallRecordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SaveCallRecordRequest> get serializer =>
      _$SaveCallRecordRequestSerializer();
}

class _$SaveCallRecordRequestSerializer
    implements PrimitiveSerializer<SaveCallRecordRequest> {
  @override
  final Iterable<Type> types = const [
    SaveCallRecordRequest,
    _$SaveCallRecordRequest
  ];

  @override
  final String wireName = r'SaveCallRecordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SaveCallRecordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.callId != null) {
      yield r'callId';
      yield serializers.serialize(
        object.callId,
        specifiedType: const FullType(String),
      );
    }
    if (object.callerId != null) {
      yield r'callerId';
      yield serializers.serialize(
        object.callerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.calleeId != null) {
      yield r'calleeId';
      yield serializers.serialize(
        object.calleeId,
        specifiedType: const FullType(int),
      );
    }
    if (object.mediaType != null) {
      yield r'mediaType';
      yield serializers.serialize(
        object.mediaType,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.mode != null) {
      yield r'mode';
      yield serializers.serialize(
        object.mode,
        specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SaveCallRecordRequest object, {
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
    required SaveCallRecordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'callId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.callId = valueDes;
          break;
        case r'callerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.callerId = valueDes;
          break;
        case r'calleeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.calleeId = valueDes;
          break;
        case r'mediaType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mediaType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mode = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SaveCallRecordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SaveCallRecordRequestBuilder();
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
