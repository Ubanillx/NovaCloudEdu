// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserStatsResult extends UserStatsResult {
  @override
  final int? registerDays;
  @override
  final int? totalCheckinDays;
  @override
  final int? currentStreak;
  @override
  final bool? checkedInToday;
  @override
  final int? totalLikes;

  factory _$UserStatsResult([void Function(UserStatsResultBuilder)? updates]) =>
      (UserStatsResultBuilder()..update(updates))._build();

  _$UserStatsResult._({
    this.registerDays,
    this.totalCheckinDays,
    this.currentStreak,
    this.checkedInToday,
    this.totalLikes,
  }) : super._();
  @override
  UserStatsResult rebuild(void Function(UserStatsResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserStatsResultBuilder toBuilder() => UserStatsResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserStatsResult &&
        registerDays == other.registerDays &&
        totalCheckinDays == other.totalCheckinDays &&
        currentStreak == other.currentStreak &&
        checkedInToday == other.checkedInToday &&
        totalLikes == other.totalLikes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, registerDays.hashCode);
    _$hash = $jc(_$hash, totalCheckinDays.hashCode);
    _$hash = $jc(_$hash, currentStreak.hashCode);
    _$hash = $jc(_$hash, checkedInToday.hashCode);
    _$hash = $jc(_$hash, totalLikes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserStatsResult')
          ..add('registerDays', registerDays)
          ..add('totalCheckinDays', totalCheckinDays)
          ..add('currentStreak', currentStreak)
          ..add('checkedInToday', checkedInToday)
          ..add('totalLikes', totalLikes))
        .toString();
  }
}

class UserStatsResultBuilder
    implements Builder<UserStatsResult, UserStatsResultBuilder> {
  _$UserStatsResult? _$v;

  int? _registerDays;
  int? get registerDays => _$this._registerDays;
  set registerDays(int? registerDays) => _$this._registerDays = registerDays;

  int? _totalCheckinDays;
  int? get totalCheckinDays => _$this._totalCheckinDays;
  set totalCheckinDays(int? totalCheckinDays) =>
      _$this._totalCheckinDays = totalCheckinDays;

  int? _currentStreak;
  int? get currentStreak => _$this._currentStreak;
  set currentStreak(int? currentStreak) =>
      _$this._currentStreak = currentStreak;

  bool? _checkedInToday;
  bool? get checkedInToday => _$this._checkedInToday;
  set checkedInToday(bool? checkedInToday) =>
      _$this._checkedInToday = checkedInToday;

  int? _totalLikes;
  int? get totalLikes => _$this._totalLikes;
  set totalLikes(int? totalLikes) => _$this._totalLikes = totalLikes;

  UserStatsResultBuilder() {
    UserStatsResult._defaults(this);
  }

  UserStatsResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _registerDays = $v.registerDays;
      _totalCheckinDays = $v.totalCheckinDays;
      _currentStreak = $v.currentStreak;
      _checkedInToday = $v.checkedInToday;
      _totalLikes = $v.totalLikes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserStatsResult other) {
    _$v = other as _$UserStatsResult;
  }

  @override
  void update(void Function(UserStatsResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserStatsResult build() => _build();

  _$UserStatsResult _build() {
    final _$result =
        _$v ??
        _$UserStatsResult._(
          registerDays: registerDays,
          totalCheckinDays: totalCheckinDays,
          currentStreak: currentStreak,
          checkedInToday: checkedInToday,
          totalLikes: totalLikes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
