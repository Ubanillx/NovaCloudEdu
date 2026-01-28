// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_ranking_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckinRankingItem extends CheckinRankingItem {
  @override
  final int? userId;
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final int? totalCheckinDays;
  @override
  final int? currentStreak;
  @override
  final int? rank;

  factory _$CheckinRankingItem([
    void Function(CheckinRankingItemBuilder)? updates,
  ]) => (CheckinRankingItemBuilder()..update(updates))._build();

  _$CheckinRankingItem._({
    this.userId,
    this.userName,
    this.userAvatar,
    this.totalCheckinDays,
    this.currentStreak,
    this.rank,
  }) : super._();
  @override
  CheckinRankingItem rebuild(
    void Function(CheckinRankingItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CheckinRankingItemBuilder toBuilder() =>
      CheckinRankingItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckinRankingItem &&
        userId == other.userId &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        totalCheckinDays == other.totalCheckinDays &&
        currentStreak == other.currentStreak &&
        rank == other.rank;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, totalCheckinDays.hashCode);
    _$hash = $jc(_$hash, currentStreak.hashCode);
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckinRankingItem')
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('totalCheckinDays', totalCheckinDays)
          ..add('currentStreak', currentStreak)
          ..add('rank', rank))
        .toString();
  }
}

class CheckinRankingItemBuilder
    implements Builder<CheckinRankingItem, CheckinRankingItemBuilder> {
  _$CheckinRankingItem? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  int? _totalCheckinDays;
  int? get totalCheckinDays => _$this._totalCheckinDays;
  set totalCheckinDays(int? totalCheckinDays) =>
      _$this._totalCheckinDays = totalCheckinDays;

  int? _currentStreak;
  int? get currentStreak => _$this._currentStreak;
  set currentStreak(int? currentStreak) =>
      _$this._currentStreak = currentStreak;

  int? _rank;
  int? get rank => _$this._rank;
  set rank(int? rank) => _$this._rank = rank;

  CheckinRankingItemBuilder() {
    CheckinRankingItem._defaults(this);
  }

  CheckinRankingItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _totalCheckinDays = $v.totalCheckinDays;
      _currentStreak = $v.currentStreak;
      _rank = $v.rank;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckinRankingItem other) {
    _$v = other as _$CheckinRankingItem;
  }

  @override
  void update(void Function(CheckinRankingItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckinRankingItem build() => _build();

  _$CheckinRankingItem _build() {
    final _$result =
        _$v ??
        _$CheckinRankingItem._(
          userId: userId,
          userName: userName,
          userAvatar: userAvatar,
          totalCheckinDays: totalCheckinDays,
          currentStreak: currentStreak,
          rank: rank,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
