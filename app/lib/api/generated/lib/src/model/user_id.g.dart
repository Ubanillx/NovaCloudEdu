// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserId extends UserId {
  @override
  final int? value;

  factory _$UserId([void Function(UserIdBuilder)? updates]) =>
      (UserIdBuilder()..update(updates))._build();

  _$UserId._({this.value}) : super._();
  @override
  UserId rebuild(void Function(UserIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserIdBuilder toBuilder() => UserIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserId && value == other.value;
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
      r'UserId',
    )..add('value', value)).toString();
  }
}

class UserIdBuilder implements Builder<UserId, UserIdBuilder> {
  _$UserId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  UserIdBuilder() {
    UserId._defaults(this);
  }

  UserIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserId other) {
    _$v = other as _$UserId;
  }

  @override
  void update(void Function(UserIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserId build() => _build();

  _$UserId _build() {
    final _$result = _$v ?? _$UserId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
