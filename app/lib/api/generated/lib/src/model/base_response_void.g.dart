// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_void.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseVoid extends BaseResponseVoid {
  @override
  final int? code;
  @override
  final JsonObject? data;
  @override
  final String? message;

  factory _$BaseResponseVoid([
    void Function(BaseResponseVoidBuilder)? updates,
  ]) => (BaseResponseVoidBuilder()..update(updates))._build();

  _$BaseResponseVoid._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseVoid rebuild(void Function(BaseResponseVoidBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseVoidBuilder toBuilder() =>
      BaseResponseVoidBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseVoid &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseVoid')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseVoidBuilder
    implements Builder<BaseResponseVoid, BaseResponseVoidBuilder> {
  _$BaseResponseVoid? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseVoidBuilder() {
    BaseResponseVoid._defaults(this);
  }

  BaseResponseVoidBuilder get _$this {
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
  void replace(BaseResponseVoid other) {
    _$v = other as _$BaseResponseVoid;
  }

  @override
  void update(void Function(BaseResponseVoidBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseVoid build() => _build();

  _$BaseResponseVoid _build() {
    final _$result =
        _$v ?? _$BaseResponseVoid._(code: code, data: data, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
