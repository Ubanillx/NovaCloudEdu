// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_execution_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListExecutionResultResponse
    extends BaseResponseListExecutionResultResponse {
  @override
  final int? code;
  @override
  final BuiltList<ExecutionResultResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListExecutionResultResponse([
    void Function(BaseResponseListExecutionResultResponseBuilder)? updates,
  ]) => (BaseResponseListExecutionResultResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListExecutionResultResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListExecutionResultResponse rebuild(
    void Function(BaseResponseListExecutionResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListExecutionResultResponseBuilder toBuilder() =>
      BaseResponseListExecutionResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListExecutionResultResponse &&
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
    return (newBuiltValueToStringHelper(
            r'BaseResponseListExecutionResultResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListExecutionResultResponseBuilder
    implements
        Builder<
          BaseResponseListExecutionResultResponse,
          BaseResponseListExecutionResultResponseBuilder
        > {
  _$BaseResponseListExecutionResultResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ExecutionResultResponse>? _data;
  ListBuilder<ExecutionResultResponse> get data =>
      _$this._data ??= ListBuilder<ExecutionResultResponse>();
  set data(ListBuilder<ExecutionResultResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListExecutionResultResponseBuilder() {
    BaseResponseListExecutionResultResponse._defaults(this);
  }

  BaseResponseListExecutionResultResponseBuilder get _$this {
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
  void replace(BaseResponseListExecutionResultResponse other) {
    _$v = other as _$BaseResponseListExecutionResultResponse;
  }

  @override
  void update(
    void Function(BaseResponseListExecutionResultResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListExecutionResultResponse build() => _build();

  _$BaseResponseListExecutionResultResponse _build() {
    _$BaseResponseListExecutionResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListExecutionResultResponse._(
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
          r'BaseResponseListExecutionResultResponse',
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
