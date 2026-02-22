// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_grading_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGradingResultResponse
    extends BaseResponseGradingResultResponse {
  @override
  final int? code;
  @override
  final GradingResultResponse? data;
  @override
  final String? message;

  factory _$BaseResponseGradingResultResponse([
    void Function(BaseResponseGradingResultResponseBuilder)? updates,
  ]) => (BaseResponseGradingResultResponseBuilder()..update(updates))._build();

  _$BaseResponseGradingResultResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseGradingResultResponse rebuild(
    void Function(BaseResponseGradingResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGradingResultResponseBuilder toBuilder() =>
      BaseResponseGradingResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGradingResultResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseGradingResultResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGradingResultResponseBuilder
    implements
        Builder<
          BaseResponseGradingResultResponse,
          BaseResponseGradingResultResponseBuilder
        > {
  _$BaseResponseGradingResultResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GradingResultResponseBuilder? _data;
  GradingResultResponseBuilder get data =>
      _$this._data ??= GradingResultResponseBuilder();
  set data(GradingResultResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGradingResultResponseBuilder() {
    BaseResponseGradingResultResponse._defaults(this);
  }

  BaseResponseGradingResultResponseBuilder get _$this {
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
  void replace(BaseResponseGradingResultResponse other) {
    _$v = other as _$BaseResponseGradingResultResponse;
  }

  @override
  void update(
    void Function(BaseResponseGradingResultResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGradingResultResponse build() => _build();

  _$BaseResponseGradingResultResponse _build() {
    _$BaseResponseGradingResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGradingResultResponse._(
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
          r'BaseResponseGradingResultResponse',
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
