// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KnowledgeProfileResponse extends KnowledgeProfileResponse {
  @override
  final String? knowledgePoint;
  @override
  final String? subject;
  @override
  final double? masteryLevel;
  @override
  final String? masteryGrade;
  @override
  final int? totalAttempts;
  @override
  final int? correctCount;
  @override
  final double? correctRate;
  @override
  final BuiltList<String>? recentErrorCategories;
  @override
  final bool? weakPoint;
  @override
  final DateTime? lastUpdated;

  factory _$KnowledgeProfileResponse([
    void Function(KnowledgeProfileResponseBuilder)? updates,
  ]) => (KnowledgeProfileResponseBuilder()..update(updates))._build();

  _$KnowledgeProfileResponse._({
    this.knowledgePoint,
    this.subject,
    this.masteryLevel,
    this.masteryGrade,
    this.totalAttempts,
    this.correctCount,
    this.correctRate,
    this.recentErrorCategories,
    this.weakPoint,
    this.lastUpdated,
  }) : super._();
  @override
  KnowledgeProfileResponse rebuild(
    void Function(KnowledgeProfileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  KnowledgeProfileResponseBuilder toBuilder() =>
      KnowledgeProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnowledgeProfileResponse &&
        knowledgePoint == other.knowledgePoint &&
        subject == other.subject &&
        masteryLevel == other.masteryLevel &&
        masteryGrade == other.masteryGrade &&
        totalAttempts == other.totalAttempts &&
        correctCount == other.correctCount &&
        correctRate == other.correctRate &&
        recentErrorCategories == other.recentErrorCategories &&
        weakPoint == other.weakPoint &&
        lastUpdated == other.lastUpdated;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, knowledgePoint.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, masteryLevel.hashCode);
    _$hash = $jc(_$hash, masteryGrade.hashCode);
    _$hash = $jc(_$hash, totalAttempts.hashCode);
    _$hash = $jc(_$hash, correctCount.hashCode);
    _$hash = $jc(_$hash, correctRate.hashCode);
    _$hash = $jc(_$hash, recentErrorCategories.hashCode);
    _$hash = $jc(_$hash, weakPoint.hashCode);
    _$hash = $jc(_$hash, lastUpdated.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnowledgeProfileResponse')
          ..add('knowledgePoint', knowledgePoint)
          ..add('subject', subject)
          ..add('masteryLevel', masteryLevel)
          ..add('masteryGrade', masteryGrade)
          ..add('totalAttempts', totalAttempts)
          ..add('correctCount', correctCount)
          ..add('correctRate', correctRate)
          ..add('recentErrorCategories', recentErrorCategories)
          ..add('weakPoint', weakPoint)
          ..add('lastUpdated', lastUpdated))
        .toString();
  }
}

class KnowledgeProfileResponseBuilder
    implements
        Builder<KnowledgeProfileResponse, KnowledgeProfileResponseBuilder> {
  _$KnowledgeProfileResponse? _$v;

  String? _knowledgePoint;
  String? get knowledgePoint => _$this._knowledgePoint;
  set knowledgePoint(String? knowledgePoint) =>
      _$this._knowledgePoint = knowledgePoint;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  double? _masteryLevel;
  double? get masteryLevel => _$this._masteryLevel;
  set masteryLevel(double? masteryLevel) => _$this._masteryLevel = masteryLevel;

  String? _masteryGrade;
  String? get masteryGrade => _$this._masteryGrade;
  set masteryGrade(String? masteryGrade) => _$this._masteryGrade = masteryGrade;

  int? _totalAttempts;
  int? get totalAttempts => _$this._totalAttempts;
  set totalAttempts(int? totalAttempts) =>
      _$this._totalAttempts = totalAttempts;

  int? _correctCount;
  int? get correctCount => _$this._correctCount;
  set correctCount(int? correctCount) => _$this._correctCount = correctCount;

  double? _correctRate;
  double? get correctRate => _$this._correctRate;
  set correctRate(double? correctRate) => _$this._correctRate = correctRate;

  ListBuilder<String>? _recentErrorCategories;
  ListBuilder<String> get recentErrorCategories =>
      _$this._recentErrorCategories ??= ListBuilder<String>();
  set recentErrorCategories(ListBuilder<String>? recentErrorCategories) =>
      _$this._recentErrorCategories = recentErrorCategories;

  bool? _weakPoint;
  bool? get weakPoint => _$this._weakPoint;
  set weakPoint(bool? weakPoint) => _$this._weakPoint = weakPoint;

  DateTime? _lastUpdated;
  DateTime? get lastUpdated => _$this._lastUpdated;
  set lastUpdated(DateTime? lastUpdated) => _$this._lastUpdated = lastUpdated;

  KnowledgeProfileResponseBuilder() {
    KnowledgeProfileResponse._defaults(this);
  }

  KnowledgeProfileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _knowledgePoint = $v.knowledgePoint;
      _subject = $v.subject;
      _masteryLevel = $v.masteryLevel;
      _masteryGrade = $v.masteryGrade;
      _totalAttempts = $v.totalAttempts;
      _correctCount = $v.correctCount;
      _correctRate = $v.correctRate;
      _recentErrorCategories = $v.recentErrorCategories?.toBuilder();
      _weakPoint = $v.weakPoint;
      _lastUpdated = $v.lastUpdated;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnowledgeProfileResponse other) {
    _$v = other as _$KnowledgeProfileResponse;
  }

  @override
  void update(void Function(KnowledgeProfileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnowledgeProfileResponse build() => _build();

  _$KnowledgeProfileResponse _build() {
    _$KnowledgeProfileResponse _$result;
    try {
      _$result =
          _$v ??
          _$KnowledgeProfileResponse._(
            knowledgePoint: knowledgePoint,
            subject: subject,
            masteryLevel: masteryLevel,
            masteryGrade: masteryGrade,
            totalAttempts: totalAttempts,
            correctCount: correctCount,
            correctRate: correctRate,
            recentErrorCategories: _recentErrorCategories?.build(),
            weakPoint: weakPoint,
            lastUpdated: lastUpdated,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recentErrorCategories';
        _recentErrorCategories?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'KnowledgeProfileResponse',
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
