// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_integer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseInteger extends BaseResponseInteger {
  @override
  final int? code;
  @override
  final int? data;
  @override
  final String? message;

  factory _$BaseResponseInteger([
    void Function(BaseResponseIntegerBuilder)? updates,
  ]) => (BaseResponseIntegerBuilder()..update(updates))._build();

  _$BaseResponseInteger._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseInteger rebuild(
    void Function(BaseResponseIntegerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseIntegerBuilder toBuilder() =>
      BaseResponseIntegerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseInteger &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseInteger')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseIntegerBuilder
    implements Builder<BaseResponseInteger, BaseResponseIntegerBuilder> {
  _$BaseResponseInteger? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  int? _data;
  int? get data => _$this._data;
  set data(int? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseIntegerBuilder() {
    BaseResponseInteger._defaults(this);
  }

  BaseResponseIntegerBuilder get _$this {
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
  void replace(BaseResponseInteger other) {
    _$v = other as _$BaseResponseInteger;
  }

  @override
  void update(void Function(BaseResponseIntegerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseInteger build() => _build();

  _$BaseResponseInteger _build() {
    final _$result =
        _$v ??
        _$BaseResponseInteger._(code: code, data: data, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
