// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grading_stats_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GradingStatsResponse extends GradingStatsResponse {
  @override
  final int? totalSubmissions;
  @override
  final double? avgScoreRate;
  @override
  final BuiltList<ScoreTrendItem>? scoreTrend;
  @override
  final BuiltMap<String, double>? subjectScoreRates;
  @override
  final BuiltList<ErrorCategoryCount>? errorDistribution;

  factory _$GradingStatsResponse([
    void Function(GradingStatsResponseBuilder)? updates,
  ]) => (GradingStatsResponseBuilder()..update(updates))._build();

  _$GradingStatsResponse._({
    this.totalSubmissions,
    this.avgScoreRate,
    this.scoreTrend,
    this.subjectScoreRates,
    this.errorDistribution,
  }) : super._();
  @override
  GradingStatsResponse rebuild(
    void Function(GradingStatsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GradingStatsResponseBuilder toBuilder() =>
      GradingStatsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GradingStatsResponse &&
        totalSubmissions == other.totalSubmissions &&
        avgScoreRate == other.avgScoreRate &&
        scoreTrend == other.scoreTrend &&
        subjectScoreRates == other.subjectScoreRates &&
        errorDistribution == other.errorDistribution;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalSubmissions.hashCode);
    _$hash = $jc(_$hash, avgScoreRate.hashCode);
    _$hash = $jc(_$hash, scoreTrend.hashCode);
    _$hash = $jc(_$hash, subjectScoreRates.hashCode);
    _$hash = $jc(_$hash, errorDistribution.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GradingStatsResponse')
          ..add('totalSubmissions', totalSubmissions)
          ..add('avgScoreRate', avgScoreRate)
          ..add('scoreTrend', scoreTrend)
          ..add('subjectScoreRates', subjectScoreRates)
          ..add('errorDistribution', errorDistribution))
        .toString();
  }
}

class GradingStatsResponseBuilder
    implements Builder<GradingStatsResponse, GradingStatsResponseBuilder> {
  _$GradingStatsResponse? _$v;

  int? _totalSubmissions;
  int? get totalSubmissions => _$this._totalSubmissions;
  set totalSubmissions(int? totalSubmissions) =>
      _$this._totalSubmissions = totalSubmissions;

  double? _avgScoreRate;
  double? get avgScoreRate => _$this._avgScoreRate;
  set avgScoreRate(double? avgScoreRate) => _$this._avgScoreRate = avgScoreRate;

  ListBuilder<ScoreTrendItem>? _scoreTrend;
  ListBuilder<ScoreTrendItem> get scoreTrend =>
      _$this._scoreTrend ??= ListBuilder<ScoreTrendItem>();
  set scoreTrend(ListBuilder<ScoreTrendItem>? scoreTrend) =>
      _$this._scoreTrend = scoreTrend;

  MapBuilder<String, double>? _subjectScoreRates;
  MapBuilder<String, double> get subjectScoreRates =>
      _$this._subjectScoreRates ??= MapBuilder<String, double>();
  set subjectScoreRates(MapBuilder<String, double>? subjectScoreRates) =>
      _$this._subjectScoreRates = subjectScoreRates;

  ListBuilder<ErrorCategoryCount>? _errorDistribution;
  ListBuilder<ErrorCategoryCount> get errorDistribution =>
      _$this._errorDistribution ??= ListBuilder<ErrorCategoryCount>();
  set errorDistribution(ListBuilder<ErrorCategoryCount>? errorDistribution) =>
      _$this._errorDistribution = errorDistribution;

  GradingStatsResponseBuilder() {
    GradingStatsResponse._defaults(this);
  }

  GradingStatsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalSubmissions = $v.totalSubmissions;
      _avgScoreRate = $v.avgScoreRate;
      _scoreTrend = $v.scoreTrend?.toBuilder();
      _subjectScoreRates = $v.subjectScoreRates?.toBuilder();
      _errorDistribution = $v.errorDistribution?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GradingStatsResponse other) {
    _$v = other as _$GradingStatsResponse;
  }

  @override
  void update(void Function(GradingStatsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GradingStatsResponse build() => _build();

  _$GradingStatsResponse _build() {
    _$GradingStatsResponse _$result;
    try {
      _$result =
          _$v ??
          _$GradingStatsResponse._(
            totalSubmissions: totalSubmissions,
            avgScoreRate: avgScoreRate,
            scoreTrend: _scoreTrend?.build(),
            subjectScoreRates: _subjectScoreRates?.build(),
            errorDistribution: _errorDistribution?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'scoreTrend';
        _scoreTrend?.build();
        _$failedField = 'subjectScoreRates';
        _subjectScoreRates?.build();
        _$failedField = 'errorDistribution';
        _errorDistribution?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GradingStatsResponse',
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
