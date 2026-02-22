// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_full_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardFullResponse extends DashboardFullResponse {
  @override
  final DashboardOverviewResponse? overview;
  @override
  final DashboardTrendsResponse? trends;
  @override
  final DashboardLearningResponse? learning;
  @override
  final DashboardContentResponse? content;
  @override
  final DashboardAiSystemResponse? aiSystem;
  @override
  final DashboardAlertsResponse? alerts;

  factory _$DashboardFullResponse([
    void Function(DashboardFullResponseBuilder)? updates,
  ]) => (DashboardFullResponseBuilder()..update(updates))._build();

  _$DashboardFullResponse._({
    this.overview,
    this.trends,
    this.learning,
    this.content,
    this.aiSystem,
    this.alerts,
  }) : super._();
  @override
  DashboardFullResponse rebuild(
    void Function(DashboardFullResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardFullResponseBuilder toBuilder() =>
      DashboardFullResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardFullResponse &&
        overview == other.overview &&
        trends == other.trends &&
        learning == other.learning &&
        content == other.content &&
        aiSystem == other.aiSystem &&
        alerts == other.alerts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, overview.hashCode);
    _$hash = $jc(_$hash, trends.hashCode);
    _$hash = $jc(_$hash, learning.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, aiSystem.hashCode);
    _$hash = $jc(_$hash, alerts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardFullResponse')
          ..add('overview', overview)
          ..add('trends', trends)
          ..add('learning', learning)
          ..add('content', content)
          ..add('aiSystem', aiSystem)
          ..add('alerts', alerts))
        .toString();
  }
}

class DashboardFullResponseBuilder
    implements Builder<DashboardFullResponse, DashboardFullResponseBuilder> {
  _$DashboardFullResponse? _$v;

  DashboardOverviewResponseBuilder? _overview;
  DashboardOverviewResponseBuilder get overview =>
      _$this._overview ??= DashboardOverviewResponseBuilder();
  set overview(DashboardOverviewResponseBuilder? overview) =>
      _$this._overview = overview;

  DashboardTrendsResponseBuilder? _trends;
  DashboardTrendsResponseBuilder get trends =>
      _$this._trends ??= DashboardTrendsResponseBuilder();
  set trends(DashboardTrendsResponseBuilder? trends) => _$this._trends = trends;

  DashboardLearningResponseBuilder? _learning;
  DashboardLearningResponseBuilder get learning =>
      _$this._learning ??= DashboardLearningResponseBuilder();
  set learning(DashboardLearningResponseBuilder? learning) =>
      _$this._learning = learning;

  DashboardContentResponseBuilder? _content;
  DashboardContentResponseBuilder get content =>
      _$this._content ??= DashboardContentResponseBuilder();
  set content(DashboardContentResponseBuilder? content) =>
      _$this._content = content;

  DashboardAiSystemResponseBuilder? _aiSystem;
  DashboardAiSystemResponseBuilder get aiSystem =>
      _$this._aiSystem ??= DashboardAiSystemResponseBuilder();
  set aiSystem(DashboardAiSystemResponseBuilder? aiSystem) =>
      _$this._aiSystem = aiSystem;

  DashboardAlertsResponseBuilder? _alerts;
  DashboardAlertsResponseBuilder get alerts =>
      _$this._alerts ??= DashboardAlertsResponseBuilder();
  set alerts(DashboardAlertsResponseBuilder? alerts) => _$this._alerts = alerts;

  DashboardFullResponseBuilder() {
    DashboardFullResponse._defaults(this);
  }

  DashboardFullResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _overview = $v.overview?.toBuilder();
      _trends = $v.trends?.toBuilder();
      _learning = $v.learning?.toBuilder();
      _content = $v.content?.toBuilder();
      _aiSystem = $v.aiSystem?.toBuilder();
      _alerts = $v.alerts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardFullResponse other) {
    _$v = other as _$DashboardFullResponse;
  }

  @override
  void update(void Function(DashboardFullResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardFullResponse build() => _build();

  _$DashboardFullResponse _build() {
    _$DashboardFullResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardFullResponse._(
            overview: _overview?.build(),
            trends: _trends?.build(),
            learning: _learning?.build(),
            content: _content?.build(),
            aiSystem: _aiSystem?.build(),
            alerts: _alerts?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'overview';
        _overview?.build();
        _$failedField = 'trends';
        _trends?.build();
        _$failedField = 'learning';
        _learning?.build();
        _$failedField = 'content';
        _content?.build();
        _$failedField = 'aiSystem';
        _aiSystem?.build();
        _$failedField = 'alerts';
        _alerts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardFullResponse',
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
