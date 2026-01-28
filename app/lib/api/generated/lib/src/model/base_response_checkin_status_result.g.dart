// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_checkin_status_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseCheckinStatusResult
    extends BaseResponseCheckinStatusResult {
  @override
  final int? code;
  @override
  final CheckinStatusResult? data;
  @override
  final String? message;

  factory _$BaseResponseCheckinStatusResult([
    void Function(BaseResponseCheckinStatusResultBuilder)? updates,
  ]) => (BaseResponseCheckinStatusResultBuilder()..update(updates))._build();

  _$BaseResponseCheckinStatusResult._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseCheckinStatusResult rebuild(
    void Function(BaseResponseCheckinStatusResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseCheckinStatusResultBuilder toBuilder() =>
      BaseResponseCheckinStatusResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseCheckinStatusResult &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseCheckinStatusResult')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseCheckinStatusResultBuilder
    implements
        Builder<
          BaseResponseCheckinStatusResult,
          BaseResponseCheckinStatusResultBuilder
        > {
  _$BaseResponseCheckinStatusResult? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  CheckinStatusResultBuilder? _data;
  CheckinStatusResultBuilder get data =>
      _$this._data ??= CheckinStatusResultBuilder();
  set data(CheckinStatusResultBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseCheckinStatusResultBuilder() {
    BaseResponseCheckinStatusResult._defaults(this);
  }

  BaseResponseCheckinStatusResultBuilder get _$this {
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
  void replace(BaseResponseCheckinStatusResult other) {
    _$v = other as _$BaseResponseCheckinStatusResult;
  }

  @override
  void update(void Function(BaseResponseCheckinStatusResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseCheckinStatusResult build() => _build();

  _$BaseResponseCheckinStatusResult _build() {
    _$BaseResponseCheckinStatusResult _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseCheckinStatusResult._(
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
          r'BaseResponseCheckinStatusResult',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
