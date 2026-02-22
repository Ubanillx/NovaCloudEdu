// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_ai_system_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardAiSystemResponse extends DashboardAiSystemResponse {
  @override
  final int? totalAiSessions;
  @override
  final int? todayAiSessions;
  @override
  final int? totalAiMessages;
  @override
  final int? todayAiMessages;
  @override
  final int? totalSubmissions;
  @override
  final int? todaySubmissions;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? submissionsByStatus;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? submissionsBySubject;
  @override
  final int? totalPptSessions;
  @override
  final int? todayPptSessions;
  @override
  final int? completedPptSessions;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? aiUsageToday;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? aiUsageTotal;
  @override
  final int? totalWorkflows;
  @override
  final int? totalWorkflowExecutions;
  @override
  final int? completedWorkflowExecutions;

  factory _$DashboardAiSystemResponse([
    void Function(DashboardAiSystemResponseBuilder)? updates,
  ]) => (DashboardAiSystemResponseBuilder()..update(updates))._build();

  _$DashboardAiSystemResponse._({
    this.totalAiSessions,
    this.todayAiSessions,
    this.totalAiMessages,
    this.todayAiMessages,
    this.totalSubmissions,
    this.todaySubmissions,
    this.submissionsByStatus,
    this.submissionsBySubject,
    this.totalPptSessions,
    this.todayPptSessions,
    this.completedPptSessions,
    this.aiUsageToday,
    this.aiUsageTotal,
    this.totalWorkflows,
    this.totalWorkflowExecutions,
    this.completedWorkflowExecutions,
  }) : super._();
  @override
  DashboardAiSystemResponse rebuild(
    void Function(DashboardAiSystemResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardAiSystemResponseBuilder toBuilder() =>
      DashboardAiSystemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardAiSystemResponse &&
        totalAiSessions == other.totalAiSessions &&
        todayAiSessions == other.todayAiSessions &&
        totalAiMessages == other.totalAiMessages &&
        todayAiMessages == other.todayAiMessages &&
        totalSubmissions == other.totalSubmissions &&
        todaySubmissions == other.todaySubmissions &&
        submissionsByStatus == other.submissionsByStatus &&
        submissionsBySubject == other.submissionsBySubject &&
        totalPptSessions == other.totalPptSessions &&
        todayPptSessions == other.todayPptSessions &&
        completedPptSessions == other.completedPptSessions &&
        aiUsageToday == other.aiUsageToday &&
        aiUsageTotal == other.aiUsageTotal &&
        totalWorkflows == other.totalWorkflows &&
        totalWorkflowExecutions == other.totalWorkflowExecutions &&
        completedWorkflowExecutions == other.completedWorkflowExecutions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalAiSessions.hashCode);
    _$hash = $jc(_$hash, todayAiSessions.hashCode);
    _$hash = $jc(_$hash, totalAiMessages.hashCode);
    _$hash = $jc(_$hash, todayAiMessages.hashCode);
    _$hash = $jc(_$hash, totalSubmissions.hashCode);
    _$hash = $jc(_$hash, todaySubmissions.hashCode);
    _$hash = $jc(_$hash, submissionsByStatus.hashCode);
    _$hash = $jc(_$hash, submissionsBySubject.hashCode);
    _$hash = $jc(_$hash, totalPptSessions.hashCode);
    _$hash = $jc(_$hash, todayPptSessions.hashCode);
    _$hash = $jc(_$hash, completedPptSessions.hashCode);
    _$hash = $jc(_$hash, aiUsageToday.hashCode);
    _$hash = $jc(_$hash, aiUsageTotal.hashCode);
    _$hash = $jc(_$hash, totalWorkflows.hashCode);
    _$hash = $jc(_$hash, totalWorkflowExecutions.hashCode);
    _$hash = $jc(_$hash, completedWorkflowExecutions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardAiSystemResponse')
          ..add('totalAiSessions', totalAiSessions)
          ..add('todayAiSessions', todayAiSessions)
          ..add('totalAiMessages', totalAiMessages)
          ..add('todayAiMessages', todayAiMessages)
          ..add('totalSubmissions', totalSubmissions)
          ..add('todaySubmissions', todaySubmissions)
          ..add('submissionsByStatus', submissionsByStatus)
          ..add('submissionsBySubject', submissionsBySubject)
          ..add('totalPptSessions', totalPptSessions)
          ..add('todayPptSessions', todayPptSessions)
          ..add('completedPptSessions', completedPptSessions)
          ..add('aiUsageToday', aiUsageToday)
          ..add('aiUsageTotal', aiUsageTotal)
          ..add('totalWorkflows', totalWorkflows)
          ..add('totalWorkflowExecutions', totalWorkflowExecutions)
          ..add('completedWorkflowExecutions', completedWorkflowExecutions))
        .toString();
  }
}

class DashboardAiSystemResponseBuilder
    implements
        Builder<DashboardAiSystemResponse, DashboardAiSystemResponseBuilder> {
  _$DashboardAiSystemResponse? _$v;

  int? _totalAiSessions;
  int? get totalAiSessions => _$this._totalAiSessions;
  set totalAiSessions(int? totalAiSessions) =>
      _$this._totalAiSessions = totalAiSessions;

  int? _todayAiSessions;
  int? get todayAiSessions => _$this._todayAiSessions;
  set todayAiSessions(int? todayAiSessions) =>
      _$this._todayAiSessions = todayAiSessions;

  int? _totalAiMessages;
  int? get totalAiMessages => _$this._totalAiMessages;
  set totalAiMessages(int? totalAiMessages) =>
      _$this._totalAiMessages = totalAiMessages;

  int? _todayAiMessages;
  int? get todayAiMessages => _$this._todayAiMessages;
  set todayAiMessages(int? todayAiMessages) =>
      _$this._todayAiMessages = todayAiMessages;

  int? _totalSubmissions;
  int? get totalSubmissions => _$this._totalSubmissions;
  set totalSubmissions(int? totalSubmissions) =>
      _$this._totalSubmissions = totalSubmissions;

  int? _todaySubmissions;
  int? get todaySubmissions => _$this._todaySubmissions;
  set todaySubmissions(int? todaySubmissions) =>
      _$this._todaySubmissions = todaySubmissions;

  ListBuilder<BuiltMap<String, JsonObject>>? _submissionsByStatus;
  ListBuilder<BuiltMap<String, JsonObject>> get submissionsByStatus =>
      _$this._submissionsByStatus ??=
          ListBuilder<BuiltMap<String, JsonObject>>();
  set submissionsByStatus(
    ListBuilder<BuiltMap<String, JsonObject>>? submissionsByStatus,
  ) => _$this._submissionsByStatus = submissionsByStatus;

  ListBuilder<BuiltMap<String, JsonObject>>? _submissionsBySubject;
  ListBuilder<BuiltMap<String, JsonObject>> get submissionsBySubject =>
      _$this._submissionsBySubject ??=
          ListBuilder<BuiltMap<String, JsonObject>>();
  set submissionsBySubject(
    ListBuilder<BuiltMap<String, JsonObject>>? submissionsBySubject,
  ) => _$this._submissionsBySubject = submissionsBySubject;

  int? _totalPptSessions;
  int? get totalPptSessions => _$this._totalPptSessions;
  set totalPptSessions(int? totalPptSessions) =>
      _$this._totalPptSessions = totalPptSessions;

  int? _todayPptSessions;
  int? get todayPptSessions => _$this._todayPptSessions;
  set todayPptSessions(int? todayPptSessions) =>
      _$this._todayPptSessions = todayPptSessions;

  int? _completedPptSessions;
  int? get completedPptSessions => _$this._completedPptSessions;
  set completedPptSessions(int? completedPptSessions) =>
      _$this._completedPptSessions = completedPptSessions;

  ListBuilder<BuiltMap<String, JsonObject>>? _aiUsageToday;
  ListBuilder<BuiltMap<String, JsonObject>> get aiUsageToday =>
      _$this._aiUsageToday ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set aiUsageToday(ListBuilder<BuiltMap<String, JsonObject>>? aiUsageToday) =>
      _$this._aiUsageToday = aiUsageToday;

  ListBuilder<BuiltMap<String, JsonObject>>? _aiUsageTotal;
  ListBuilder<BuiltMap<String, JsonObject>> get aiUsageTotal =>
      _$this._aiUsageTotal ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set aiUsageTotal(ListBuilder<BuiltMap<String, JsonObject>>? aiUsageTotal) =>
      _$this._aiUsageTotal = aiUsageTotal;

  int? _totalWorkflows;
  int? get totalWorkflows => _$this._totalWorkflows;
  set totalWorkflows(int? totalWorkflows) =>
      _$this._totalWorkflows = totalWorkflows;

  int? _totalWorkflowExecutions;
  int? get totalWorkflowExecutions => _$this._totalWorkflowExecutions;
  set totalWorkflowExecutions(int? totalWorkflowExecutions) =>
      _$this._totalWorkflowExecutions = totalWorkflowExecutions;

  int? _completedWorkflowExecutions;
  int? get completedWorkflowExecutions => _$this._completedWorkflowExecutions;
  set completedWorkflowExecutions(int? completedWorkflowExecutions) =>
      _$this._completedWorkflowExecutions = completedWorkflowExecutions;

  DashboardAiSystemResponseBuilder() {
    DashboardAiSystemResponse._defaults(this);
  }

  DashboardAiSystemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalAiSessions = $v.totalAiSessions;
      _todayAiSessions = $v.todayAiSessions;
      _totalAiMessages = $v.totalAiMessages;
      _todayAiMessages = $v.todayAiMessages;
      _totalSubmissions = $v.totalSubmissions;
      _todaySubmissions = $v.todaySubmissions;
      _submissionsByStatus = $v.submissionsByStatus?.toBuilder();
      _submissionsBySubject = $v.submissionsBySubject?.toBuilder();
      _totalPptSessions = $v.totalPptSessions;
      _todayPptSessions = $v.todayPptSessions;
      _completedPptSessions = $v.completedPptSessions;
      _aiUsageToday = $v.aiUsageToday?.toBuilder();
      _aiUsageTotal = $v.aiUsageTotal?.toBuilder();
      _totalWorkflows = $v.totalWorkflows;
      _totalWorkflowExecutions = $v.totalWorkflowExecutions;
      _completedWorkflowExecutions = $v.completedWorkflowExecutions;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardAiSystemResponse other) {
    _$v = other as _$DashboardAiSystemResponse;
  }

  @override
  void update(void Function(DashboardAiSystemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardAiSystemResponse build() => _build();

  _$DashboardAiSystemResponse _build() {
    _$DashboardAiSystemResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardAiSystemResponse._(
            totalAiSessions: totalAiSessions,
            todayAiSessions: todayAiSessions,
            totalAiMessages: totalAiMessages,
            todayAiMessages: todayAiMessages,
            totalSubmissions: totalSubmissions,
            todaySubmissions: todaySubmissions,
            submissionsByStatus: _submissionsByStatus?.build(),
            submissionsBySubject: _submissionsBySubject?.build(),
            totalPptSessions: totalPptSessions,
            todayPptSessions: todayPptSessions,
            completedPptSessions: completedPptSessions,
            aiUsageToday: _aiUsageToday?.build(),
            aiUsageTotal: _aiUsageTotal?.build(),
            totalWorkflows: totalWorkflows,
            totalWorkflowExecutions: totalWorkflowExecutions,
            completedWorkflowExecutions: completedWorkflowExecutions,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'submissionsByStatus';
        _submissionsByStatus?.build();
        _$failedField = 'submissionsBySubject';
        _submissionsBySubject?.build();

        _$failedField = 'aiUsageToday';
        _aiUsageToday?.build();
        _$failedField = 'aiUsageTotal';
        _aiUsageTotal?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardAiSystemResponse',
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
