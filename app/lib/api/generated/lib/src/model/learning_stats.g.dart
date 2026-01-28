// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LearningStats extends LearningStats {
  @override
  final int? total;
  @override
  final int? studied;

  factory _$LearningStats([void Function(LearningStatsBuilder)? updates]) =>
      (LearningStatsBuilder()..update(updates))._build();

  _$LearningStats._({this.total, this.studied}) : super._();
  @override
  LearningStats rebuild(void Function(LearningStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LearningStatsBuilder toBuilder() => LearningStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LearningStats &&
        total == other.total &&
        studied == other.studied;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, studied.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LearningStats')
          ..add('total', total)
          ..add('studied', studied))
        .toString();
  }
}

class LearningStatsBuilder
    implements Builder<LearningStats, LearningStatsBuilder> {
  _$LearningStats? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _studied;
  int? get studied => _$this._studied;
  set studied(int? studied) => _$this._studied = studied;

  LearningStatsBuilder() {
    LearningStats._defaults(this);
  }

  LearningStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _studied = $v.studied;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LearningStats other) {
    _$v = other as _$LearningStats;
  }

  @override
  void update(void Function(LearningStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LearningStats build() => _build();

  _$LearningStats _build() {
    final _$result = _$v ?? _$LearningStats._(total: total, studied: studied);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
