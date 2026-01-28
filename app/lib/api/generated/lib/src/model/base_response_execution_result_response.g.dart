// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_execution_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseExecutionResultResponse
    extends BaseResponseExecutionResultResponse {
  @override
  final int? code;
  @override
  final ExecutionResultResponse? data;
  @override
  final String? message;

  factory _$BaseResponseExecutionResultResponse([
    void Function(BaseResponseExecutionResultResponseBuilder)? updates,
  ]) =>
      (BaseResponseExecutionResultResponseBuilder()..update(updates))._build();

  _$BaseResponseExecutionResultResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseExecutionResultResponse rebuild(
    void Function(BaseResponseExecutionResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseExecutionResultResponseBuilder toBuilder() =>
      BaseResponseExecutionResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseExecutionResultResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseExecutionResultResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseExecutionResultResponseBuilder
    implements
        Builder<
          BaseResponseExecutionResultResponse,
          BaseResponseExecutionResultResponseBuilder
        > {
  _$BaseResponseExecutionResultResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ExecutionResultResponseBuilder? _data;
  ExecutionResultResponseBuilder get data =>
      _$this._data ??= ExecutionResultResponseBuilder();
  set data(ExecutionResultResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseExecutionResultResponseBuilder() {
    BaseResponseExecutionResultResponse._defaults(this);
  }

  BaseResponseExecutionResultResponseBuilder get _$this {
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
  void replace(BaseResponseExecutionResultResponse other) {
    _$v = other as _$BaseResponseExecutionResultResponse;
  }

  @override
  void update(
    void Function(BaseResponseExecutionResultResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseExecutionResultResponse build() => _build();

  _$BaseResponseExecutionResultResponse _build() {
    _$BaseResponseExecutionResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseExecutionResultResponse._(
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
          r'BaseResponseExecutionResultResponse',
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
