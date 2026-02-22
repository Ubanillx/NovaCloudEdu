// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trend_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrendItem extends TrendItem {
  @override
  final String? period;
  @override
  final int? activityCount;
  @override
  final int? totalDurationSec;
  @override
  final String? durationText;

  factory _$TrendItem([void Function(TrendItemBuilder)? updates]) =>
      (TrendItemBuilder()..update(updates))._build();

  _$TrendItem._({
    this.period,
    this.activityCount,
    this.totalDurationSec,
    this.durationText,
  }) : super._();
  @override
  TrendItem rebuild(void Function(TrendItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TrendItemBuilder toBuilder() => TrendItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrendItem &&
        period == other.period &&
        activityCount == other.activityCount &&
        totalDurationSec == other.totalDurationSec &&
        durationText == other.durationText;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, period.hashCode);
    _$hash = $jc(_$hash, activityCount.hashCode);
    _$hash = $jc(_$hash, totalDurationSec.hashCode);
    _$hash = $jc(_$hash, durationText.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrendItem')
          ..add('period', period)
          ..add('activityCount', activityCount)
          ..add('totalDurationSec', totalDurationSec)
          ..add('durationText', durationText))
        .toString();
  }
}

class TrendItemBuilder implements Builder<TrendItem, TrendItemBuilder> {
  _$TrendItem? _$v;

  String? _period;
  String? get period => _$this._period;
  set period(String? period) => _$this._period = period;

  int? _activityCount;
  int? get activityCount => _$this._activityCount;
  set activityCount(int? activityCount) =>
      _$this._activityCount = activityCount;

  int? _totalDurationSec;
  int? get totalDurationSec => _$this._totalDurationSec;
  set totalDurationSec(int? totalDurationSec) =>
      _$this._totalDurationSec = totalDurationSec;

  String? _durationText;
  String? get durationText => _$this._durationText;
  set durationText(String? durationText) => _$this._durationText = durationText;

  TrendItemBuilder() {
    TrendItem._defaults(this);
  }

  TrendItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _period = $v.period;
      _activityCount = $v.activityCount;
      _totalDurationSec = $v.totalDurationSec;
      _durationText = $v.durationText;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TrendItem other) {
    _$v = other as _$TrendItem;
  }

  @override
  void update(void Function(TrendItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrendItem build() => _build();

  _$TrendItem _build() {
    final _$result =
        _$v ??
        _$TrendItem._(
          period: period,
          activityCount: activityCount,
          totalDurationSec: totalDurationSec,
          durationText: durationText,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
