// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_book_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WordBookStats extends WordBookStats {
  @override
  final int? total;
  @override
  final int? notLearned;
  @override
  final int? learned;
  @override
  final int? mastered;

  factory _$WordBookStats([void Function(WordBookStatsBuilder)? updates]) =>
      (WordBookStatsBuilder()..update(updates))._build();

  _$WordBookStats._({this.total, this.notLearned, this.learned, this.mastered})
    : super._();
  @override
  WordBookStats rebuild(void Function(WordBookStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WordBookStatsBuilder toBuilder() => WordBookStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WordBookStats &&
        total == other.total &&
        notLearned == other.notLearned &&
        learned == other.learned &&
        mastered == other.mastered;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, notLearned.hashCode);
    _$hash = $jc(_$hash, learned.hashCode);
    _$hash = $jc(_$hash, mastered.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WordBookStats')
          ..add('total', total)
          ..add('notLearned', notLearned)
          ..add('learned', learned)
          ..add('mastered', mastered))
        .toString();
  }
}

class WordBookStatsBuilder
    implements Builder<WordBookStats, WordBookStatsBuilder> {
  _$WordBookStats? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _notLearned;
  int? get notLearned => _$this._notLearned;
  set notLearned(int? notLearned) => _$this._notLearned = notLearned;

  int? _learned;
  int? get learned => _$this._learned;
  set learned(int? learned) => _$this._learned = learned;

  int? _mastered;
  int? get mastered => _$this._mastered;
  set mastered(int? mastered) => _$this._mastered = mastered;

  WordBookStatsBuilder() {
    WordBookStats._defaults(this);
  }

  WordBookStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _notLearned = $v.notLearned;
      _learned = $v.learned;
      _mastered = $v.mastered;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WordBookStats other) {
    _$v = other as _$WordBookStats;
  }

  @override
  void update(void Function(WordBookStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WordBookStats build() => _build();

  _$WordBookStats _build() {
    final _$result =
        _$v ??
        _$WordBookStats._(
          total: total,
          notLearned: notLearned,
          learned: learned,
          mastered: mastered,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
