// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_string.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseString extends BaseResponseString {
  @override
  final int? code;
  @override
  final String? data;
  @override
  final String? message;

  factory _$BaseResponseString(
          [void Function(BaseResponseStringBuilder)? updates]) =>
      (BaseResponseStringBuilder()..update(updates))._build();

  _$BaseResponseString._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseString rebuild(
          void Function(BaseResponseStringBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseStringBuilder toBuilder() =>
      BaseResponseStringBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseString &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseString')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseStringBuilder
    implements Builder<BaseResponseString, BaseResponseStringBuilder> {
  _$BaseResponseString? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseStringBuilder() {
    BaseResponseString._defaults(this);
  }

  BaseResponseStringBuilder get _$this {
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
  void replace(BaseResponseString other) {
    _$v = other as _$BaseResponseString;
  }

  @override
  void update(void Function(BaseResponseStringBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseString build() => _build();

  _$BaseResponseString _build() {
    final _$result = _$v ??
        _$BaseResponseString._(
          code: code,
          data: data,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
