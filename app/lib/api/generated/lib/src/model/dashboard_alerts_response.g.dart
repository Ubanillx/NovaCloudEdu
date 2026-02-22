// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_alerts_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardAlertsResponse extends DashboardAlertsResponse {
  @override
  final int? pendingFeedbackCount;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? recentPendingFeedbacks;
  @override
  final int? expiringMemberCount;
  @override
  final int? failedScraperTaskCount;
  @override
  final int? todayCheckinCount;
  @override
  final int? totalUserCount;

  factory _$DashboardAlertsResponse([
    void Function(DashboardAlertsResponseBuilder)? updates,
  ]) => (DashboardAlertsResponseBuilder()..update(updates))._build();

  _$DashboardAlertsResponse._({
    this.pendingFeedbackCount,
    this.recentPendingFeedbacks,
    this.expiringMemberCount,
    this.failedScraperTaskCount,
    this.todayCheckinCount,
    this.totalUserCount,
  }) : super._();
  @override
  DashboardAlertsResponse rebuild(
    void Function(DashboardAlertsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardAlertsResponseBuilder toBuilder() =>
      DashboardAlertsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardAlertsResponse &&
        pendingFeedbackCount == other.pendingFeedbackCount &&
        recentPendingFeedbacks == other.recentPendingFeedbacks &&
        expiringMemberCount == other.expiringMemberCount &&
        failedScraperTaskCount == other.failedScraperTaskCount &&
        todayCheckinCount == other.todayCheckinCount &&
        totalUserCount == other.totalUserCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pendingFeedbackCount.hashCode);
    _$hash = $jc(_$hash, recentPendingFeedbacks.hashCode);
    _$hash = $jc(_$hash, expiringMemberCount.hashCode);
    _$hash = $jc(_$hash, failedScraperTaskCount.hashCode);
    _$hash = $jc(_$hash, todayCheckinCount.hashCode);
    _$hash = $jc(_$hash, totalUserCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardAlertsResponse')
          ..add('pendingFeedbackCount', pendingFeedbackCount)
          ..add('recentPendingFeedbacks', recentPendingFeedbacks)
          ..add('expiringMemberCount', expiringMemberCount)
          ..add('failedScraperTaskCount', failedScraperTaskCount)
          ..add('todayCheckinCount', todayCheckinCount)
          ..add('totalUserCount', totalUserCount))
        .toString();
  }
}

class DashboardAlertsResponseBuilder
    implements
        Builder<DashboardAlertsResponse, DashboardAlertsResponseBuilder> {
  _$DashboardAlertsResponse? _$v;

  int? _pendingFeedbackCount;
  int? get pendingFeedbackCount => _$this._pendingFeedbackCount;
  set pendingFeedbackCount(int? pendingFeedbackCount) =>
      _$this._pendingFeedbackCount = pendingFeedbackCount;

  ListBuilder<BuiltMap<String, JsonObject>>? _recentPendingFeedbacks;
  ListBuilder<BuiltMap<String, JsonObject>> get recentPendingFeedbacks =>
      _$this._recentPendingFeedbacks ??=
          ListBuilder<BuiltMap<String, JsonObject>>();
  set recentPendingFeedbacks(
    ListBuilder<BuiltMap<String, JsonObject>>? recentPendingFeedbacks,
  ) => _$this._recentPendingFeedbacks = recentPendingFeedbacks;

  int? _expiringMemberCount;
  int? get expiringMemberCount => _$this._expiringMemberCount;
  set expiringMemberCount(int? expiringMemberCount) =>
      _$this._expiringMemberCount = expiringMemberCount;

  int? _failedScraperTaskCount;
  int? get failedScraperTaskCount => _$this._failedScraperTaskCount;
  set failedScraperTaskCount(int? failedScraperTaskCount) =>
      _$this._failedScraperTaskCount = failedScraperTaskCount;

  int? _todayCheckinCount;
  int? get todayCheckinCount => _$this._todayCheckinCount;
  set todayCheckinCount(int? todayCheckinCount) =>
      _$this._todayCheckinCount = todayCheckinCount;

  int? _totalUserCount;
  int? get totalUserCount => _$this._totalUserCount;
  set totalUserCount(int? totalUserCount) =>
      _$this._totalUserCount = totalUserCount;

  DashboardAlertsResponseBuilder() {
    DashboardAlertsResponse._defaults(this);
  }

  DashboardAlertsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pendingFeedbackCount = $v.pendingFeedbackCount;
      _recentPendingFeedbacks = $v.recentPendingFeedbacks?.toBuilder();
      _expiringMemberCount = $v.expiringMemberCount;
      _failedScraperTaskCount = $v.failedScraperTaskCount;
      _todayCheckinCount = $v.todayCheckinCount;
      _totalUserCount = $v.totalUserCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardAlertsResponse other) {
    _$v = other as _$DashboardAlertsResponse;
  }

  @override
  void update(void Function(DashboardAlertsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardAlertsResponse build() => _build();

  _$DashboardAlertsResponse _build() {
    _$DashboardAlertsResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardAlertsResponse._(
            pendingFeedbackCount: pendingFeedbackCount,
            recentPendingFeedbacks: _recentPendingFeedbacks?.build(),
            expiringMemberCount: expiringMemberCount,
            failedScraperTaskCount: failedScraperTaskCount,
            todayCheckinCount: todayCheckinCount,
            totalUserCount: totalUserCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recentPendingFeedbacks';
        _recentPendingFeedbacks?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardAlertsResponse',
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
