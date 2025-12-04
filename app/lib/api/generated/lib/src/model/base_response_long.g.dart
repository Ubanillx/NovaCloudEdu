// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_long.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseLong extends BaseResponseLong {
  @override
  final int? code;
  @override
  final int? data;
  @override
  final String? message;

  factory _$BaseResponseLong(
          [void Function(BaseResponseLongBuilder)? updates]) =>
      (BaseResponseLongBuilder()..update(updates))._build();

  _$BaseResponseLong._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseLong rebuild(void Function(BaseResponseLongBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseLongBuilder toBuilder() =>
      BaseResponseLongBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseLong &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BaseResponseLong')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseLongBuilder
    implements Builder<BaseResponseLong, BaseResponseLongBuilder> {
  _$BaseResponseLong? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  int? _data;
  int? get data => _$this._data;
  set data(int? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseLongBuilder() {
    BaseResponseLong._defaults(this);
  }

  BaseResponseLongBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseLong other) {
    _$v = other as _$BaseResponseLong;
  }

  @override
  void update(void Function(BaseResponseLongBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseLong build() => _build();

  _$BaseResponseLong _build() {
    final _$result = _$v ??
        _$BaseResponseLong._(
          code: code,
          data: data,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
