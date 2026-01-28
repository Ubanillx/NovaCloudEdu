// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckinResult extends CheckinResult {
  @override
  final bool? success;
  @override
  final int? streakDays;
  @override
  final int? totalCheckinDays;
  @override
  final int? maxStreak;

  factory _$CheckinResult([void Function(CheckinResultBuilder)? updates]) =>
      (CheckinResultBuilder()..update(updates))._build();

  _$CheckinResult._({
    this.success,
    this.streakDays,
    this.totalCheckinDays,
    this.maxStreak,
  }) : super._();
  @override
  CheckinResult rebuild(void Function(CheckinResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckinResultBuilder toBuilder() => CheckinResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckinResult &&
        success == other.success &&
        streakDays == other.streakDays &&
        totalCheckinDays == other.totalCheckinDays &&
        maxStreak == other.maxStreak;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, streakDays.hashCode);
    _$hash = $jc(_$hash, totalCheckinDays.hashCode);
    _$hash = $jc(_$hash, maxStreak.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckinResult')
          ..add('success', success)
          ..add('streakDays', streakDays)
          ..add('totalCheckinDays', totalCheckinDays)
          ..add('maxStreak', maxStreak))
        .toString();
  }
}

class CheckinResultBuilder
    implements Builder<CheckinResult, CheckinResultBuilder> {
  _$CheckinResult? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  int? _streakDays;
  int? get streakDays => _$this._streakDays;
  set streakDays(int? streakDays) => _$this._streakDays = streakDays;

  int? _totalCheckinDays;
  int? get totalCheckinDays => _$this._totalCheckinDays;
  set totalCheckinDays(int? totalCheckinDays) =>
      _$this._totalCheckinDays = totalCheckinDays;

  int? _maxStreak;
  int? get maxStreak => _$this._maxStreak;
  set maxStreak(int? maxStreak) => _$this._maxStreak = maxStreak;

  CheckinResultBuilder() {
    CheckinResult._defaults(this);
  }

  CheckinResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _streakDays = $v.streakDays;
      _totalCheckinDays = $v.totalCheckinDays;
      _maxStreak = $v.maxStreak;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckinResult other) {
    _$v = other as _$CheckinResult;
  }

  @override
  void update(void Function(CheckinResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckinResult build() => _build();

  _$CheckinResult _build() {
    final _$result =
        _$v ??
        _$CheckinResult._(
          success: success,
          streakDays: streakDays,
          totalCheckinDays: totalCheckinDays,
          maxStreak: maxStreak,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
