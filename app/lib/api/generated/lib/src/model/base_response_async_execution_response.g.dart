// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_async_execution_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseAsyncExecutionResponse
    extends BaseResponseAsyncExecutionResponse {
  @override
  final int? code;
  @override
  final AsyncExecutionResponse? data;
  @override
  final String? message;

  factory _$BaseResponseAsyncExecutionResponse([
    void Function(BaseResponseAsyncExecutionResponseBuilder)? updates,
  ]) => (BaseResponseAsyncExecutionResponseBuilder()..update(updates))._build();

  _$BaseResponseAsyncExecutionResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseAsyncExecutionResponse rebuild(
    void Function(BaseResponseAsyncExecutionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseAsyncExecutionResponseBuilder toBuilder() =>
      BaseResponseAsyncExecutionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseAsyncExecutionResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseAsyncExecutionResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseAsyncExecutionResponseBuilder
    implements
        Builder<
          BaseResponseAsyncExecutionResponse,
          BaseResponseAsyncExecutionResponseBuilder
        > {
  _$BaseResponseAsyncExecutionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  AsyncExecutionResponseBuilder? _data;
  AsyncExecutionResponseBuilder get data =>
      _$this._data ??= AsyncExecutionResponseBuilder();
  set data(AsyncExecutionResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseAsyncExecutionResponseBuilder() {
    BaseResponseAsyncExecutionResponse._defaults(this);
  }

  BaseResponseAsyncExecutionResponseBuilder get _$this {
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
  void replace(BaseResponseAsyncExecutionResponse other) {
    _$v = other as _$BaseResponseAsyncExecutionResponse;
  }

  @override
  void update(
    void Function(BaseResponseAsyncExecutionResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseAsyncExecutionResponse build() => _build();

  _$BaseResponseAsyncExecutionResponse _build() {
    _$BaseResponseAsyncExecutionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseAsyncExecutionResponse._(
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
          r'BaseResponseAsyncExecutionResponse',
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
