// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_learning_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardLearningResponse extends DashboardLearningResponse {
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? activityDistribution;
  @override
  final int? totalDurationSec;
  @override
  final double? avgHomeworkScoreRate;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? topActiveUsers;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? topActiveClasses;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? dailyActiveTrend;

  factory _$DashboardLearningResponse([
    void Function(DashboardLearningResponseBuilder)? updates,
  ]) => (DashboardLearningResponseBuilder()..update(updates))._build();

  _$DashboardLearningResponse._({
    this.activityDistribution,
    this.totalDurationSec,
    this.avgHomeworkScoreRate,
    this.topActiveUsers,
    this.topActiveClasses,
    this.dailyActiveTrend,
  }) : super._();
  @override
  DashboardLearningResponse rebuild(
    void Function(DashboardLearningResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardLearningResponseBuilder toBuilder() =>
      DashboardLearningResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardLearningResponse &&
        activityDistribution == other.activityDistribution &&
        totalDurationSec == other.totalDurationSec &&
        avgHomeworkScoreRate == other.avgHomeworkScoreRate &&
        topActiveUsers == other.topActiveUsers &&
        topActiveClasses == other.topActiveClasses &&
        dailyActiveTrend == other.dailyActiveTrend;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, activityDistribution.hashCode);
    _$hash = $jc(_$hash, totalDurationSec.hashCode);
    _$hash = $jc(_$hash, avgHomeworkScoreRate.hashCode);
    _$hash = $jc(_$hash, topActiveUsers.hashCode);
    _$hash = $jc(_$hash, topActiveClasses.hashCode);
    _$hash = $jc(_$hash, dailyActiveTrend.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardLearningResponse')
          ..add('activityDistribution', activityDistribution)
          ..add('totalDurationSec', totalDurationSec)
          ..add('avgHomeworkScoreRate', avgHomeworkScoreRate)
          ..add('topActiveUsers', topActiveUsers)
          ..add('topActiveClasses', topActiveClasses)
          ..add('dailyActiveTrend', dailyActiveTrend))
        .toString();
  }
}

class DashboardLearningResponseBuilder
    implements
        Builder<DashboardLearningResponse, DashboardLearningResponseBuilder> {
  _$DashboardLearningResponse? _$v;

  ListBuilder<BuiltMap<String, JsonObject>>? _activityDistribution;
  ListBuilder<BuiltMap<String, JsonObject>> get activityDistribution =>
      _$this._activityDistribution ??=
          ListBuilder<BuiltMap<String, JsonObject>>();
  set activityDistribution(
    ListBuilder<BuiltMap<String, JsonObject>>? activityDistribution,
  ) => _$this._activityDistribution = activityDistribution;

  int? _totalDurationSec;
  int? get totalDurationSec => _$this._totalDurationSec;
  set totalDurationSec(int? totalDurationSec) =>
      _$this._totalDurationSec = totalDurationSec;

  double? _avgHomeworkScoreRate;
  double? get avgHomeworkScoreRate => _$this._avgHomeworkScoreRate;
  set avgHomeworkScoreRate(double? avgHomeworkScoreRate) =>
      _$this._avgHomeworkScoreRate = avgHomeworkScoreRate;

  ListBuilder<BuiltMap<String, JsonObject>>? _topActiveUsers;
  ListBuilder<BuiltMap<String, JsonObject>> get topActiveUsers =>
      _$this._topActiveUsers ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set topActiveUsers(
    ListBuilder<BuiltMap<String, JsonObject>>? topActiveUsers,
  ) => _$this._topActiveUsers = topActiveUsers;

  ListBuilder<BuiltMap<String, JsonObject>>? _topActiveClasses;
  ListBuilder<BuiltMap<String, JsonObject>> get topActiveClasses =>
      _$this._topActiveClasses ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set topActiveClasses(
    ListBuilder<BuiltMap<String, JsonObject>>? topActiveClasses,
  ) => _$this._topActiveClasses = topActiveClasses;

  ListBuilder<BuiltMap<String, JsonObject>>? _dailyActiveTrend;
  ListBuilder<BuiltMap<String, JsonObject>> get dailyActiveTrend =>
      _$this._dailyActiveTrend ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set dailyActiveTrend(
    ListBuilder<BuiltMap<String, JsonObject>>? dailyActiveTrend,
  ) => _$this._dailyActiveTrend = dailyActiveTrend;

  DashboardLearningResponseBuilder() {
    DashboardLearningResponse._defaults(this);
  }

  DashboardLearningResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _activityDistribution = $v.activityDistribution?.toBuilder();
      _totalDurationSec = $v.totalDurationSec;
      _avgHomeworkScoreRate = $v.avgHomeworkScoreRate;
      _topActiveUsers = $v.topActiveUsers?.toBuilder();
      _topActiveClasses = $v.topActiveClasses?.toBuilder();
      _dailyActiveTrend = $v.dailyActiveTrend?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardLearningResponse other) {
    _$v = other as _$DashboardLearningResponse;
  }

  @override
  void update(void Function(DashboardLearningResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardLearningResponse build() => _build();

  _$DashboardLearningResponse _build() {
    _$DashboardLearningResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardLearningResponse._(
            activityDistribution: _activityDistribution?.build(),
            totalDurationSec: totalDurationSec,
            avgHomeworkScoreRate: avgHomeworkScoreRate,
            topActiveUsers: _topActiveUsers?.build(),
            topActiveClasses: _topActiveClasses?.build(),
            dailyActiveTrend: _dailyActiveTrend?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'activityDistribution';
        _activityDistribution?.build();

        _$failedField = 'topActiveUsers';
        _topActiveUsers?.build();
        _$failedField = 'topActiveClasses';
        _topActiveClasses?.build();
        _$failedField = 'dailyActiveTrend';
        _dailyActiveTrend?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardLearningResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
