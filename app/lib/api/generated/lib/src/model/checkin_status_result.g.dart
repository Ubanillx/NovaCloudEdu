// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_status_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckinStatusResult extends CheckinStatusResult {
  @override
  final bool? checkedInToday;
  @override
  final int? currentStreak;
  @override
  final int? totalCheckinDays;

  factory _$CheckinStatusResult([
    void Function(CheckinStatusResultBuilder)? updates,
  ]) => (CheckinStatusResultBuilder()..update(updates))._build();

  _$CheckinStatusResult._({
    this.checkedInToday,
    this.currentStreak,
    this.totalCheckinDays,
  }) : super._();
  @override
  CheckinStatusResult rebuild(
    void Function(CheckinStatusResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CheckinStatusResultBuilder toBuilder() =>
      CheckinStatusResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckinStatusResult &&
        checkedInToday == other.checkedInToday &&
        currentStreak == other.currentStreak &&
        totalCheckinDays == other.totalCheckinDays;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, checkedInToday.hashCode);
    _$hash = $jc(_$hash, currentStreak.hashCode);
    _$hash = $jc(_$hash, totalCheckinDays.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckinStatusResult')
          ..add('checkedInToday', checkedInToday)
          ..add('currentStreak', currentStreak)
          ..add('totalCheckinDays', totalCheckinDays))
        .toString();
  }
}

class CheckinStatusResultBuilder
    implements Builder<CheckinStatusResult, CheckinStatusResultBuilder> {
  _$CheckinStatusResult? _$v;

  bool? _checkedInToday;
  bool? get checkedInToday => _$this._checkedInToday;
  set checkedInToday(bool? checkedInToday) =>
      _$this._checkedInToday = checkedInToday;

  int? _currentStreak;
  int? get currentStreak => _$this._currentStreak;
  set currentStreak(int? currentStreak) =>
      _$this._currentStreak = currentStreak;

  int? _totalCheckinDays;
  int? get totalCheckinDays => _$this._totalCheckinDays;
  set totalCheckinDays(int? totalCheckinDays) =>
      _$this._totalCheckinDays = totalCheckinDays;

  CheckinStatusResultBuilder() {
    CheckinStatusResult._defaults(this);
  }

  CheckinStatusResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _checkedInToday = $v.checkedInToday;
      _currentStreak = $v.currentStreak;
      _totalCheckinDays = $v.totalCheckinDays;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckinStatusResult other) {
    _$v = other as _$CheckinStatusResult;
  }

  @override
  void update(void Function(CheckinStatusResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckinStatusResult build() => _build();

  _$CheckinStatusResult _build() {
    final _$result =
        _$v ??
        _$CheckinStatusResult._(
          checkedInToday: checkedInToday,
          currentStreak: currentStreak,
          totalCheckinDays: totalCheckinDays,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
