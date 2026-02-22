//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_analytics_response.g.dart';

/// ClassAnalyticsResponse
///
/// Properties:
/// * [memberCount]
/// * [totalDurationSec]
/// * [totalDurationText]
/// * [avgDurationSecPerMember]
/// * [avgDurationText]
/// * [totalActivities]
/// * [activityTypeCounts]
/// * [avgScoreRate]
@BuiltValue()
abstract class ClassAnalyticsResponse
    implements Built<ClassAnalyticsResponse, ClassAnalyticsResponseBuilder> {
  @BuiltValueField(wireName: r'memberCount')
  int? get memberCount;

  @BuiltValueField(wireName: r'totalDurationSec')
  int? get totalDurationSec;

  @BuiltValueField(wireName: r'totalDurationText')
  String? get totalDurationText;

  @BuiltValueField(wireName: r'avgDurationSecPerMember')
  int? get avgDurationSecPerMember;

  @BuiltValueField(wireName: r'avgDurationText')
  String? get avgDurationText;

  @BuiltValueField(wireName: r'totalActivities')
  int? get totalActivities;

  @BuiltValueField(wireName: r'activityTypeCounts')
  BuiltMap<String, int>? get activityTypeCounts;

  @BuiltValueField(wireName: r'avgScoreRate')
  double? get avgScoreRate;

  ClassAnalyticsResponse._();

  factory ClassAnalyticsResponse(
          [void updates(ClassAnalyticsResponseBuilder b)]) =
      _$ClassAnalyticsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassAnalyticsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassAnalyticsResponse> get serializer =>
      _$ClassAnalyticsResponseSerializer();
}

class _$ClassAnalyticsResponseSerializer
    implements PrimitiveSerializer<ClassAnalyticsResponse> {
  @override
  final Iterable<Type> types = const [
    ClassAnalyticsResponse,
    _$ClassAnalyticsResponse
  ];

  @override
  final String wireName = r'ClassAnalyticsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassAnalyticsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.memberCount != null) {
      yield r'memberCount';
      yield serializers.serialize(
        object.memberCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalDurationSec != null) {
      yield r'totalDurationSec';
      yield serializers.serialize(
        object.totalDurationSec,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalDurationText != null) {
      yield r'totalDurationText';
      yield serializers.serialize(
        object.totalDurationText,
        specifiedType: const FullType(String),
      );
    }
    if (object.avgDurationSecPerMember != null) {
      yield r'avgDurationSecPerMember';
      yield serializers.serialize(
        object.avgDurationSecPerMember,
        specifiedType: const FullType(int),
      );
    }
    if (object.avgDurationText != null) {
      yield r'avgDurationText';
      yield serializers.serialize(
        object.avgDurationText,
        specifiedType: const FullType(String),
      );
    }
    if (object.totalActivities != null) {
      yield r'totalActivities';
      yield serializers.serialize(
        object.totalActivities,
        specifiedType: const FullType(int),
      );
    }
    if (object.activityTypeCounts != null) {
      yield r'activityTypeCounts';
      yield serializers.serialize(
        object.activityTypeCounts,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.avgScoreRate != null) {
      yield r'avgScoreRate';
      yield serializers.serialize(
        object.avgScoreRate,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClassAnalyticsResponse object, {
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
    required ClassAnalyticsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'memberCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.memberCount = valueDes;
          break;
        case r'totalDurationSec':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalDurationSec = valueDes;
          break;
        case r'totalDurationText':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalDurationText = valueDes;
          break;
        case r'avgDurationSecPerMember':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.avgDurationSecPerMember = valueDes;
          break;
        case r'avgDurationText':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.avgDurationText = valueDes;
          break;
        case r'totalActivities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalActivities = valueDes;
          break;
        case r'activityTypeCounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>;
          result.activityTypeCounts.replace(valueDes);
          break;
        case r'avgScoreRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.avgScoreRate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClassAnalyticsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassAnalyticsResponseBuilder();
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
