//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checkin_status_result.g.dart';

/// CheckinStatusResult
///
/// Properties:
/// * [checkedInToday]
/// * [currentStreak]
/// * [totalCheckinDays]
@BuiltValue()
abstract class CheckinStatusResult
    implements Built<CheckinStatusResult, CheckinStatusResultBuilder> {
  @BuiltValueField(wireName: r'checkedInToday')
  bool? get checkedInToday;

  @BuiltValueField(wireName: r'currentStreak')
  int? get currentStreak;

  @BuiltValueField(wireName: r'totalCheckinDays')
  int? get totalCheckinDays;

  CheckinStatusResult._();

  factory CheckinStatusResult([void updates(CheckinStatusResultBuilder b)]) =
      _$CheckinStatusResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckinStatusResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckinStatusResult> get serializer =>
      _$CheckinStatusResultSerializer();
}

class _$CheckinStatusResultSerializer
    implements PrimitiveSerializer<CheckinStatusResult> {
  @override
  final Iterable<Type> types = const [
    CheckinStatusResult,
    _$CheckinStatusResult
  ];

  @override
  final String wireName = r'CheckinStatusResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckinStatusResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.checkedInToday != null) {
      yield r'checkedInToday';
      yield serializers.serialize(
        object.checkedInToday,
        specifiedType: const FullType(bool),
      );
    }
    if (object.currentStreak != null) {
      yield r'currentStreak';
      yield serializers.serialize(
        object.currentStreak,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckinStatusResult object, {
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
    required CheckinStatusResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'checkedInToday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.checkedInToday = valueDes;
          break;
        case r'currentStreak':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.currentStreak = valueDes;
          break;
        case r'totalCheckinDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCheckinDays = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckinStatusResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckinStatusResultBuilder();
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
