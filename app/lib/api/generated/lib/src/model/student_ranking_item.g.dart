// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_ranking_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentRankingItem extends StudentRankingItem {
  @override
  final int? rank;
  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final int? totalDurationSec;
  @override
  final String? durationText;
  @override
  final int? activityCount;
  @override
  final double? scoreRate;
  @override
  final double? compositeScore;

  factory _$StudentRankingItem([
    void Function(StudentRankingItemBuilder)? updates,
  ]) => (StudentRankingItemBuilder()..update(updates))._build();

  _$StudentRankingItem._({
    this.rank,
    this.userId,
    this.userName,
    this.totalDurationSec,
    this.durationText,
    this.activityCount,
    this.scoreRate,
    this.compositeScore,
  }) : super._();
  @override
  StudentRankingItem rebuild(
    void Function(StudentRankingItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentRankingItemBuilder toBuilder() =>
      StudentRankingItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentRankingItem &&
        rank == other.rank &&
        userId == other.userId &&
        userName == other.userName &&
        totalDurationSec == other.totalDurationSec &&
        durationText == other.durationText &&
        activityCount == other.activityCount &&
        scoreRate == other.scoreRate &&
        compositeScore == other.compositeScore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, totalDurationSec.hashCode);
    _$hash = $jc(_$hash, durationText.hashCode);
    _$hash = $jc(_$hash, activityCount.hashCode);
    _$hash = $jc(_$hash, scoreRate.hashCode);
    _$hash = $jc(_$hash, compositeScore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentRankingItem')
          ..add('rank', rank)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('totalDurationSec', totalDurationSec)
          ..add('durationText', durationText)
          ..add('activityCount', activityCount)
          ..add('scoreRate', scoreRate)
          ..add('compositeScore', compositeScore))
        .toString();
  }
}

class StudentRankingItemBuilder
    implements Builder<StudentRankingItem, StudentRankingItemBuilder> {
  _$StudentRankingItem? _$v;

  int? _rank;
  int? get rank => _$this._rank;
  set rank(int? rank) => _$this._rank = rank;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  int? _totalDurationSec;
  int? get totalDurationSec => _$this._totalDurationSec;
  set totalDurationSec(int? totalDurationSec) =>
      _$this._totalDurationSec = totalDurationSec;

  String? _durationText;
  String? get durationText => _$this._durationText;
  set durationText(String? durationText) => _$this._durationText = durationText;

  int? _activityCount;
  int? get activityCount => _$this._activityCount;
  set activityCount(int? activityCount) =>
      _$this._activityCount = activityCount;

  double? _scoreRate;
  double? get scoreRate => _$this._scoreRate;
  set scoreRate(double? scoreRate) => _$this._scoreRate = scoreRate;

  double? _compositeScore;
  double? get compositeScore => _$this._compositeScore;
  set compositeScore(double? compositeScore) =>
      _$this._compositeScore = compositeScore;

  StudentRankingItemBuilder() {
    StudentRankingItem._defaults(this);
  }

  StudentRankingItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rank = $v.rank;
      _userId = $v.userId;
      _userName = $v.userName;
      _totalDurationSec = $v.totalDurationSec;
      _durationText = $v.durationText;
      _activityCount = $v.activityCount;
      _scoreRate = $v.scoreRate;
      _compositeScore = $v.compositeScore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentRankingItem other) {
    _$v = other as _$StudentRankingItem;
  }

  @override
  void update(void Function(StudentRankingItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentRankingItem build() => _build();

  _$StudentRankingItem _build() {
    final _$result =
        _$v ??
        _$StudentRankingItem._(
          rank: rank,
          userId: userId,
          userName: userName,
          totalDurationSec: totalDurationSec,
          durationText: durationText,
          activityCount: activityCount,
          scoreRate: scoreRate,
          compositeScore: compositeScore,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
