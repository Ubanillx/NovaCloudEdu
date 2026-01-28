// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookId extends BookId {
  @override
  final int? value;

  factory _$BookId([void Function(BookIdBuilder)? updates]) =>
      (BookIdBuilder()..update(updates))._build();

  _$BookId._({this.value}) : super._();
  @override
  BookId rebuild(void Function(BookIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookIdBuilder toBuilder() => BookIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookId && value == other.value;
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
      r'BookId',
    )..add('value', value)).toString();
  }
}

class BookIdBuilder implements Builder<BookId, BookIdBuilder> {
  _$BookId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  BookIdBuilder() {
    BookId._defaults(this);
  }

  BookIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookId other) {
    _$v = other as _$BookId;
  }

  @override
  void update(void Function(BookIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BookId build() => _build();

  _$BookId _build() {
    final _$result = _$v ?? _$BookId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
