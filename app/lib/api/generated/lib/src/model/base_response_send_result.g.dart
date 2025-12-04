// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_send_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseSendResult extends BaseResponseSendResult {
  @override
  final int? code;
  @override
  final SendResult? data;
  @override
  final String? message;

  factory _$BaseResponseSendResult(
          [void Function(BaseResponseSendResultBuilder)? updates]) =>
      (BaseResponseSendResultBuilder()..update(updates))._build();

  _$BaseResponseSendResult._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseSendResult rebuild(
          void Function(BaseResponseSendResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseSendResultBuilder toBuilder() =>
      BaseResponseSendResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseSendResult &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseSendResult')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseSendResultBuilder
    implements Builder<BaseResponseSendResult, BaseResponseSendResultBuilder> {
  _$BaseResponseSendResult? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  SendResultBuilder? _data;
  SendResultBuilder get data => _$this._data ??= SendResultBuilder();
  set data(SendResultBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseSendResultBuilder() {
    BaseResponseSendResult._defaults(this);
  }

  BaseResponseSendResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseSendResult other) {
    _$v = other as _$BaseResponseSendResult;
  }

  @override
  void update(void Function(BaseResponseSendResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseSendResult build() => _build();

  _$BaseResponseSendResult _build() {
    _$BaseResponseSendResult _$result;
    try {
      _$result = _$v ??
          _$BaseResponseSendResult._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BaseResponseSendResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
