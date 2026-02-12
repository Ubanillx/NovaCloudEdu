//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'execution_statistics_response.g.dart';

/// 工作流执行统计响应
///
/// Properties:
/// * [totalCount] - 总执行次数
/// * [successCount] - 成功次数
/// * [failedCount] - 失败次数
/// * [cancelledCount] - 取消次数
/// * [avgDurationMs] - 平均耗时（毫秒）
/// * [successRate] - 成功率（0~1）
@BuiltValue()
abstract class ExecutionStatisticsResponse
    implements
        Built<ExecutionStatisticsResponse, ExecutionStatisticsResponseBuilder> {
  /// 总执行次数
  @BuiltValueField(wireName: r'totalCount')
  int? get totalCount;

  /// 成功次数
  @BuiltValueField(wireName: r'successCount')
  int? get successCount;

  /// 失败次数
  @BuiltValueField(wireName: r'failedCount')
  int? get failedCount;

  /// 取消次数
  @BuiltValueField(wireName: r'cancelledCount')
  int? get cancelledCount;

  /// 平均耗时（毫秒）
  @BuiltValueField(wireName: r'avgDurationMs')
  double? get avgDurationMs;

  /// 成功率（0~1）
  @BuiltValueField(wireName: r'successRate')
  double? get successRate;

  ExecutionStatisticsResponse._();

  factory ExecutionStatisticsResponse(
          [void updates(ExecutionStatisticsResponseBuilder b)]) =
      _$ExecutionStatisticsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExecutionStatisticsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExecutionStatisticsResponse> get serializer =>
      _$ExecutionStatisticsResponseSerializer();
}

class _$ExecutionStatisticsResponseSerializer
    implements PrimitiveSerializer<ExecutionStatisticsResponse> {
  @override
  final Iterable<Type> types = const [
    ExecutionStatisticsResponse,
    _$ExecutionStatisticsResponse
  ];

  @override
  final String wireName = r'ExecutionStatisticsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExecutionStatisticsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalCount != null) {
      yield r'totalCount';
      yield serializers.serialize(
        object.totalCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.successCount != null) {
      yield r'successCount';
      yield serializers.serialize(
        object.successCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.failedCount != null) {
      yield r'failedCount';
      yield serializers.serialize(
        object.failedCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.cancelledCount != null) {
      yield r'cancelledCount';
      yield serializers.serialize(
        object.cancelledCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.avgDurationMs != null) {
      yield r'avgDurationMs';
      yield serializers.serialize(
        object.avgDurationMs,
        specifiedType: const FullType(double),
      );
    }
    if (object.successRate != null) {
      yield r'successRate';
      yield serializers.serialize(
        object.successRate,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExecutionStatisticsResponse object, {
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
    required ExecutionStatisticsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCount = valueDes;
          break;
        case r'successCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.successCount = valueDes;
          break;
        case r'failedCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failedCount = valueDes;
          break;
        case r'cancelledCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.cancelledCount = valueDes;
          break;
        case r'avgDurationMs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.avgDurationMs = valueDes;
          break;
        case r'successRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.successRate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExecutionStatisticsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExecutionStatisticsResponseBuilder();
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
