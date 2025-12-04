// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_boolean.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseBoolean extends BaseResponseBoolean {
  @override
  final int? code;
  @override
  final bool? data;
  @override
  final String? message;

  factory _$BaseResponseBoolean(
          [void Function(BaseResponseBooleanBuilder)? updates]) =>
      (BaseResponseBooleanBuilder()..update(updates))._build();

  _$BaseResponseBoolean._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseBoolean rebuild(
          void Function(BaseResponseBooleanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseBooleanBuilder toBuilder() =>
      BaseResponseBooleanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseBoolean &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseBoolean')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseBooleanBuilder
    implements Builder<BaseResponseBoolean, BaseResponseBooleanBuilder> {
  _$BaseResponseBoolean? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  bool? _data;
  bool? get data => _$this._data;
  set data(bool? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseBooleanBuilder() {
    BaseResponseBoolean._defaults(this);
  }

  BaseResponseBooleanBuilder get _$this {
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
  void replace(BaseResponseBoolean other) {
    _$v = other as _$BaseResponseBoolean;
  }

  @override
  void update(void Function(BaseResponseBooleanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseBoolean build() => _build();

  _$BaseResponseBoolean _build() {
    final _$result = _$v ??
        _$BaseResponseBoolean._(
          code: code,
          data: data,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
