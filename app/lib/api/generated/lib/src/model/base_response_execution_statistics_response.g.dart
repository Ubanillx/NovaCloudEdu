// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_execution_statistics_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseExecutionStatisticsResponse
    extends BaseResponseExecutionStatisticsResponse {
  @override
  final int? code;
  @override
  final ExecutionStatisticsResponse? data;
  @override
  final String? message;

  factory _$BaseResponseExecutionStatisticsResponse([
    void Function(BaseResponseExecutionStatisticsResponseBuilder)? updates,
  ]) => (BaseResponseExecutionStatisticsResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseExecutionStatisticsResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseExecutionStatisticsResponse rebuild(
    void Function(BaseResponseExecutionStatisticsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseExecutionStatisticsResponseBuilder toBuilder() =>
      BaseResponseExecutionStatisticsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseExecutionStatisticsResponse &&
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
            r'BaseResponseExecutionStatisticsResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseExecutionStatisticsResponseBuilder
    implements
        Builder<
          BaseResponseExecutionStatisticsResponse,
          BaseResponseExecutionStatisticsResponseBuilder
        > {
  _$BaseResponseExecutionStatisticsResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ExecutionStatisticsResponseBuilder? _data;
  ExecutionStatisticsResponseBuilder get data =>
      _$this._data ??= ExecutionStatisticsResponseBuilder();
  set data(ExecutionStatisticsResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseExecutionStatisticsResponseBuilder() {
    BaseResponseExecutionStatisticsResponse._defaults(this);
  }

  BaseResponseExecutionStatisticsResponseBuilder get _$this {
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
  void replace(BaseResponseExecutionStatisticsResponse other) {
    _$v = other as _$BaseResponseExecutionStatisticsResponse;
  }

  @override
  void update(
    void Function(BaseResponseExecutionStatisticsResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseExecutionStatisticsResponse build() => _build();

  _$BaseResponseExecutionStatisticsResponse _build() {
    _$BaseResponseExecutionStatisticsResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseExecutionStatisticsResponse._(
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
          r'BaseResponseExecutionStatisticsResponse',
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
