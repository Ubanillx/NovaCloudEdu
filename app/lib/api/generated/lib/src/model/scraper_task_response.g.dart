// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scraper_task_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScraperTaskResponse extends ScraperTaskResponse {
  @override
  final int? id;
  @override
  final int? configId;
  @override
  final String? configName;
  @override
  final String? status;
  @override
  final String? statusDescription;
  @override
  final int? totalArticles;
  @override
  final int? successCount;
  @override
  final int? failCount;
  @override
  final BuiltList<int>? createdArticleIds;
  @override
  final String? errorMessage;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final int? durationMs;
  @override
  final DateTime? createTime;

  factory _$ScraperTaskResponse([
    void Function(ScraperTaskResponseBuilder)? updates,
  ]) => (ScraperTaskResponseBuilder()..update(updates))._build();

  _$ScraperTaskResponse._({
    this.id,
    this.configId,
    this.configName,
    this.status,
    this.statusDescription,
    this.totalArticles,
    this.successCount,
    this.failCount,
    this.createdArticleIds,
    this.errorMessage,
    this.startTime,
    this.endTime,
    this.durationMs,
    this.createTime,
  }) : super._();
  @override
  ScraperTaskResponse rebuild(
    void Function(ScraperTaskResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScraperTaskResponseBuilder toBuilder() =>
      ScraperTaskResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScraperTaskResponse &&
        id == other.id &&
        configId == other.configId &&
        configName == other.configName &&
        status == other.status &&
        statusDescription == other.statusDescription &&
        totalArticles == other.totalArticles &&
        successCount == other.successCount &&
        failCount == other.failCount &&
        createdArticleIds == other.createdArticleIds &&
        errorMessage == other.errorMessage &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        durationMs == other.durationMs &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, configId.hashCode);
    _$hash = $jc(_$hash, configName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDescription.hashCode);
    _$hash = $jc(_$hash, totalArticles.hashCode);
    _$hash = $jc(_$hash, successCount.hashCode);
    _$hash = $jc(_$hash, failCount.hashCode);
    _$hash = $jc(_$hash, createdArticleIds.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, durationMs.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScraperTaskResponse')
          ..add('id', id)
          ..add('configId', configId)
          ..add('configName', configName)
          ..add('status', status)
          ..add('statusDescription', statusDescription)
          ..add('totalArticles', totalArticles)
          ..add('successCount', successCount)
          ..add('failCount', failCount)
          ..add('createdArticleIds', createdArticleIds)
          ..add('errorMessage', errorMessage)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('durationMs', durationMs)
          ..add('createTime', createTime))
        .toString();
  }
}

class ScraperTaskResponseBuilder
    implements Builder<ScraperTaskResponse, ScraperTaskResponseBuilder> {
  _$ScraperTaskResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _configId;
  int? get configId => _$this._configId;
  set configId(int? configId) => _$this._configId = configId;

  String? _configName;
  String? get configName => _$this._configName;
  set configName(String? configName) => _$this._configName = configName;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _statusDescription;
  String? get statusDescription => _$this._statusDescription;
  set statusDescription(String? statusDescription) =>
      _$this._statusDescription = statusDescription;

  int? _totalArticles;
  int? get totalArticles => _$this._totalArticles;
  set totalArticles(int? totalArticles) =>
      _$this._totalArticles = totalArticles;

  int? _successCount;
  int? get successCount => _$this._successCount;
  set successCount(int? successCount) => _$this._successCount = successCount;

  int? _failCount;
  int? get failCount => _$this._failCount;
  set failCount(int? failCount) => _$this._failCount = failCount;

  ListBuilder<int>? _createdArticleIds;
  ListBuilder<int> get createdArticleIds =>
      _$this._createdArticleIds ??= ListBuilder<int>();
  set createdArticleIds(ListBuilder<int>? createdArticleIds) =>
      _$this._createdArticleIds = createdArticleIds;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  DateTime? _startTime;
  DateTime? get startTime => _$this._startTime;
  set startTime(DateTime? startTime) => _$this._startTime = startTime;

  DateTime? _endTime;
  DateTime? get endTime => _$this._endTime;
  set endTime(DateTime? endTime) => _$this._endTime = endTime;

  int? _durationMs;
  int? get durationMs => _$this._durationMs;
  set durationMs(int? durationMs) => _$this._durationMs = durationMs;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  ScraperTaskResponseBuilder() {
    ScraperTaskResponse._defaults(this);
  }

  ScraperTaskResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _configId = $v.configId;
      _configName = $v.configName;
      _status = $v.status;
      _statusDescription = $v.statusDescription;
      _totalArticles = $v.totalArticles;
      _successCount = $v.successCount;
      _failCount = $v.failCount;
      _createdArticleIds = $v.createdArticleIds?.toBuilder();
      _errorMessage = $v.errorMessage;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _durationMs = $v.durationMs;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScraperTaskResponse other) {
    _$v = other as _$ScraperTaskResponse;
  }

  @override
  void update(void Function(ScraperTaskResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScraperTaskResponse build() => _build();

  _$ScraperTaskResponse _build() {
    _$ScraperTaskResponse _$result;
    try {
      _$result =
          _$v ??
          _$ScraperTaskResponse._(
            id: id,
            configId: configId,
            configName: configName,
            status: status,
            statusDescription: statusDescription,
            totalArticles: totalArticles,
            successCount: successCount,
            failCount: failCount,
            createdArticleIds: _createdArticleIds?.build(),
            errorMessage: errorMessage,
            startTime: startTime,
            endTime: endTime,
            durationMs: durationMs,
            createTime: createTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdArticleIds';
        _createdArticleIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ScraperTaskResponse',
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
