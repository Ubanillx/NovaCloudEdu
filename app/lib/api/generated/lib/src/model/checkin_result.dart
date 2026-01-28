//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checkin_result.g.dart';

/// CheckinResult
///
/// Properties:
/// * [success]
/// * [streakDays]
/// * [totalCheckinDays]
/// * [maxStreak]
@BuiltValue()
abstract class CheckinResult
    implements Built<CheckinResult, CheckinResultBuilder> {
  @BuiltValueField(wireName: r'success')
  bool? get success;

  @BuiltValueField(wireName: r'streakDays')
  int? get streakDays;

  @BuiltValueField(wireName: r'totalCheckinDays')
  int? get totalCheckinDays;

  @BuiltValueField(wireName: r'maxStreak')
  int? get maxStreak;

  CheckinResult._();

  factory CheckinResult([void updates(CheckinResultBuilder b)]) =
      _$CheckinResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckinResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckinResult> get serializer =>
      _$CheckinResultSerializer();
}

class _$CheckinResultSerializer implements PrimitiveSerializer<CheckinResult> {
  @override
  final Iterable<Type> types = const [CheckinResult, _$CheckinResult];

  @override
  final String wireName = r'CheckinResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckinResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.success != null) {
      yield r'success';
      yield serializers.serialize(
        object.success,
        specifiedType: const FullType(bool),
      );
    }
    if (object.streakDays != null) {
      yield r'streakDays';
      yield serializers.serialize(
        object.streakDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalCheckinDays != null) {
      yield r'totalCheckinDays';
      yield serializers.serialize(
        object.totalCheckinDays,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxStreak != null) {
      yield r'maxStreak';
      yield serializers.serialize(
        object.maxStreak,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckinResult object, {
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
    required CheckinResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'success':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.success = valueDes;
          break;
        case r'streakDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.streakDays = valueDes;
          break;
        case r'totalCheckinDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCheckinDays = valueDes;
          break;
        case r'maxStreak':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxStreak = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckinResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckinResultBuilder();
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
