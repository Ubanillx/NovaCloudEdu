// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_quiz_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReadingQuizId extends ReadingQuizId {
  @override
  final int? value;

  factory _$ReadingQuizId([void Function(ReadingQuizIdBuilder)? updates]) =>
      (ReadingQuizIdBuilder()..update(updates))._build();

  _$ReadingQuizId._({this.value}) : super._();
  @override
  ReadingQuizId rebuild(void Function(ReadingQuizIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadingQuizIdBuilder toBuilder() => ReadingQuizIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingQuizId && value == other.value;
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
      r'ReadingQuizId',
    )..add('value', value)).toString();
  }
}

class ReadingQuizIdBuilder
    implements Builder<ReadingQuizId, ReadingQuizIdBuilder> {
  _$ReadingQuizId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  ReadingQuizIdBuilder() {
    ReadingQuizId._defaults(this);
  }

  ReadingQuizIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadingQuizId other) {
    _$v = other as _$ReadingQuizId;
  }

  @override
  void update(void Function(ReadingQuizIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadingQuizId build() => _build();

  _$ReadingQuizId _build() {
    final _$result = _$v ?? _$ReadingQuizId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
