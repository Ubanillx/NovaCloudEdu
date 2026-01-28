// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterId extends ChapterId {
  @override
  final int? value;

  factory _$ChapterId([void Function(ChapterIdBuilder)? updates]) =>
      (ChapterIdBuilder()..update(updates))._build();

  _$ChapterId._({this.value}) : super._();
  @override
  ChapterId rebuild(void Function(ChapterIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterIdBuilder toBuilder() => ChapterIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterId && value == other.value;
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
      r'ChapterId',
    )..add('value', value)).toString();
  }
}

class ChapterIdBuilder implements Builder<ChapterId, ChapterIdBuilder> {
  _$ChapterId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  ChapterIdBuilder() {
    ChapterId._defaults(this);
  }

  ChapterIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterId other) {
    _$v = other as _$ChapterId;
  }

  @override
  void update(void Function(ChapterIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterId build() => _build();

  _$ChapterId _build() {
    final _$result = _$v ?? _$ChapterId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
