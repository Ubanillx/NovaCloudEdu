// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_trend_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScoreTrendItem extends ScoreTrendItem {
  @override
  final String? submissionId;
  @override
  final int? score;
  @override
  final int? maxScore;
  @override
  final String? subject;
  @override
  final String? createTime;

  factory _$ScoreTrendItem([void Function(ScoreTrendItemBuilder)? updates]) =>
      (ScoreTrendItemBuilder()..update(updates))._build();

  _$ScoreTrendItem._({
    this.submissionId,
    this.score,
    this.maxScore,
    this.subject,
    this.createTime,
  }) : super._();
  @override
  ScoreTrendItem rebuild(void Function(ScoreTrendItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoreTrendItemBuilder toBuilder() => ScoreTrendItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoreTrendItem &&
        submissionId == other.submissionId &&
        score == other.score &&
        maxScore == other.maxScore &&
        subject == other.subject &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, submissionId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoreTrendItem')
          ..add('submissionId', submissionId)
          ..add('score', score)
          ..add('maxScore', maxScore)
          ..add('subject', subject)
          ..add('createTime', createTime))
        .toString();
  }
}

class ScoreTrendItemBuilder
    implements Builder<ScoreTrendItem, ScoreTrendItemBuilder> {
  _$ScoreTrendItem? _$v;

  String? _submissionId;
  String? get submissionId => _$this._submissionId;
  set submissionId(String? submissionId) => _$this._submissionId = submissionId;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  int? _maxScore;
  int? get maxScore => _$this._maxScore;
  set maxScore(int? maxScore) => _$this._maxScore = maxScore;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _createTime;
  String? get createTime => _$this._createTime;
  set createTime(String? createTime) => _$this._createTime = createTime;

  ScoreTrendItemBuilder() {
    ScoreTrendItem._defaults(this);
  }

  ScoreTrendItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _submissionId = $v.submissionId;
      _score = $v.score;
      _maxScore = $v.maxScore;
      _subject = $v.subject;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoreTrendItem other) {
    _$v = other as _$ScoreTrendItem;
  }

  @override
  void update(void Function(ScoreTrendItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoreTrendItem build() => _build();

  _$ScoreTrendItem _build() {
    final _$result =
        _$v ??
        _$ScoreTrendItem._(
          submissionId: submissionId,
          score: score,
          maxScore: maxScore,
          subject: subject,
          createTime: createTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
