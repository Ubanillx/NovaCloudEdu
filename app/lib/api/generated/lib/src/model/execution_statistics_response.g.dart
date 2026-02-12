// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_statistics_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExecutionStatisticsResponse extends ExecutionStatisticsResponse {
  @override
  final int? totalCount;
  @override
  final int? successCount;
  @override
  final int? failedCount;
  @override
  final int? cancelledCount;
  @override
  final double? avgDurationMs;
  @override
  final double? successRate;

  factory _$ExecutionStatisticsResponse([
    void Function(ExecutionStatisticsResponseBuilder)? updates,
  ]) => (ExecutionStatisticsResponseBuilder()..update(updates))._build();

  _$ExecutionStatisticsResponse._({
    this.totalCount,
    this.successCount,
    this.failedCount,
    this.cancelledCount,
    this.avgDurationMs,
    this.successRate,
  }) : super._();
  @override
  ExecutionStatisticsResponse rebuild(
    void Function(ExecutionStatisticsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExecutionStatisticsResponseBuilder toBuilder() =>
      ExecutionStatisticsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecutionStatisticsResponse &&
        totalCount == other.totalCount &&
        successCount == other.successCount &&
        failedCount == other.failedCount &&
        cancelledCount == other.cancelledCount &&
        avgDurationMs == other.avgDurationMs &&
        successRate == other.successRate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, successCount.hashCode);
    _$hash = $jc(_$hash, failedCount.hashCode);
    _$hash = $jc(_$hash, cancelledCount.hashCode);
    _$hash = $jc(_$hash, avgDurationMs.hashCode);
    _$hash = $jc(_$hash, successRate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExecutionStatisticsResponse')
          ..add('totalCount', totalCount)
          ..add('successCount', successCount)
          ..add('failedCount', failedCount)
          ..add('cancelledCount', cancelledCount)
          ..add('avgDurationMs', avgDurationMs)
          ..add('successRate', successRate))
        .toString();
  }
}

class ExecutionStatisticsResponseBuilder
    implements
        Builder<
          ExecutionStatisticsResponse,
          ExecutionStatisticsResponseBuilder
        > {
  _$ExecutionStatisticsResponse? _$v;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  int? _successCount;
  int? get successCount => _$this._successCount;
  set successCount(int? successCount) => _$this._successCount = successCount;

  int? _failedCount;
  int? get failedCount => _$this._failedCount;
  set failedCount(int? failedCount) => _$this._failedCount = failedCount;

  int? _cancelledCount;
  int? get cancelledCount => _$this._cancelledCount;
  set cancelledCount(int? cancelledCount) =>
      _$this._cancelledCount = cancelledCount;

  double? _avgDurationMs;
  double? get avgDurationMs => _$this._avgDurationMs;
  set avgDurationMs(double? avgDurationMs) =>
      _$this._avgDurationMs = avgDurationMs;

  double? _successRate;
  double? get successRate => _$this._successRate;
  set successRate(double? successRate) => _$this._successRate = successRate;

  ExecutionStatisticsResponseBuilder() {
    ExecutionStatisticsResponse._defaults(this);
  }

  ExecutionStatisticsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalCount = $v.totalCount;
      _successCount = $v.successCount;
      _failedCount = $v.failedCount;
      _cancelledCount = $v.cancelledCount;
      _avgDurationMs = $v.avgDurationMs;
      _successRate = $v.successRate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExecutionStatisticsResponse other) {
    _$v = other as _$ExecutionStatisticsResponse;
  }

  @override
  void update(void Function(ExecutionStatisticsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExecutionStatisticsResponse build() => _build();

  _$ExecutionStatisticsResponse _build() {
    final _$result =
        _$v ??
        _$ExecutionStatisticsResponse._(
          totalCount: totalCount,
          successCount: successCount,
          failedCount: failedCount,
          cancelledCount: cancelledCount,
          avgDurationMs: avgDurationMs,
          successRate: successRate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
