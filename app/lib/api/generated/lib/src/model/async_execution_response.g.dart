// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_execution_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AsyncExecutionResponse extends AsyncExecutionResponse {
  @override
  final String? executionId;
  @override
  final String? message;

  factory _$AsyncExecutionResponse([
    void Function(AsyncExecutionResponseBuilder)? updates,
  ]) => (AsyncExecutionResponseBuilder()..update(updates))._build();

  _$AsyncExecutionResponse._({this.executionId, this.message}) : super._();
  @override
  AsyncExecutionResponse rebuild(
    void Function(AsyncExecutionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AsyncExecutionResponseBuilder toBuilder() =>
      AsyncExecutionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AsyncExecutionResponse &&
        executionId == other.executionId &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, executionId.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AsyncExecutionResponse')
          ..add('executionId', executionId)
          ..add('message', message))
        .toString();
  }
}

class AsyncExecutionResponseBuilder
    implements Builder<AsyncExecutionResponse, AsyncExecutionResponseBuilder> {
  _$AsyncExecutionResponse? _$v;

  String? _executionId;
  String? get executionId => _$this._executionId;
  set executionId(String? executionId) => _$this._executionId = executionId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  AsyncExecutionResponseBuilder() {
    AsyncExecutionResponse._defaults(this);
  }

  AsyncExecutionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _executionId = $v.executionId;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AsyncExecutionResponse other) {
    _$v = other as _$AsyncExecutionResponse;
  }

  @override
  void update(void Function(AsyncExecutionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AsyncExecutionResponse build() => _build();

  _$AsyncExecutionResponse _build() {
    final _$result =
        _$v ??
        _$AsyncExecutionResponse._(executionId: executionId, message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
