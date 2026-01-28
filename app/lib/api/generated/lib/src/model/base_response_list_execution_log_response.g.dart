// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_execution_log_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListExecutionLogResponse
    extends BaseResponseListExecutionLogResponse {
  @override
  final int? code;
  @override
  final BuiltList<ExecutionLogResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListExecutionLogResponse([
    void Function(BaseResponseListExecutionLogResponseBuilder)? updates,
  ]) =>
      (BaseResponseListExecutionLogResponseBuilder()..update(updates))._build();

  _$BaseResponseListExecutionLogResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListExecutionLogResponse rebuild(
    void Function(BaseResponseListExecutionLogResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListExecutionLogResponseBuilder toBuilder() =>
      BaseResponseListExecutionLogResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListExecutionLogResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListExecutionLogResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListExecutionLogResponseBuilder
    implements
        Builder<
          BaseResponseListExecutionLogResponse,
          BaseResponseListExecutionLogResponseBuilder
        > {
  _$BaseResponseListExecutionLogResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ExecutionLogResponse>? _data;
  ListBuilder<ExecutionLogResponse> get data =>
      _$this._data ??= ListBuilder<ExecutionLogResponse>();
  set data(ListBuilder<ExecutionLogResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListExecutionLogResponseBuilder() {
    BaseResponseListExecutionLogResponse._defaults(this);
  }

  BaseResponseListExecutionLogResponseBuilder get _$this {
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
  void replace(BaseResponseListExecutionLogResponse other) {
    _$v = other as _$BaseResponseListExecutionLogResponse;
  }

  @override
  void update(
    void Function(BaseResponseListExecutionLogResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListExecutionLogResponse build() => _build();

  _$BaseResponseListExecutionLogResponse _build() {
    _$BaseResponseListExecutionLogResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListExecutionLogResponse._(
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
          r'BaseResponseListExecutionLogResponse',
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
