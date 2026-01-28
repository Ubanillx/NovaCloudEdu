// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_summary_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterSummaryId extends ChapterSummaryId {
  @override
  final int? value;

  factory _$ChapterSummaryId([
    void Function(ChapterSummaryIdBuilder)? updates,
  ]) => (ChapterSummaryIdBuilder()..update(updates))._build();

  _$ChapterSummaryId._({this.value}) : super._();
  @override
  ChapterSummaryId rebuild(void Function(ChapterSummaryIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterSummaryIdBuilder toBuilder() =>
      ChapterSummaryIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterSummaryId && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ChapterSummaryId',
    )..add('value', value)).toString();
  }
}

class ChapterSummaryIdBuilder
    implements Builder<ChapterSummaryId, ChapterSummaryIdBuilder> {
  _$ChapterSummaryId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  ChapterSummaryIdBuilder() {
    ChapterSummaryId._defaults(this);
  }

  ChapterSummaryIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterSummaryId other) {
    _$v = other as _$ChapterSummaryId;
  }

  @override
  void update(void Function(ChapterSummaryIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterSummaryId build() => _build();

  _$ChapterSummaryId _build() {
    final _$result = _$v ?? _$ChapterSummaryId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
