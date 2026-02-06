// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_ai_process_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseAiProcessResultResponse
    extends BaseResponseAiProcessResultResponse {
  @override
  final int? code;
  @override
  final AiProcessResultResponse? data;
  @override
  final String? message;

  factory _$BaseResponseAiProcessResultResponse([
    void Function(BaseResponseAiProcessResultResponseBuilder)? updates,
  ]) =>
      (BaseResponseAiProcessResultResponseBuilder()..update(updates))._build();

  _$BaseResponseAiProcessResultResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseAiProcessResultResponse rebuild(
    void Function(BaseResponseAiProcessResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseAiProcessResultResponseBuilder toBuilder() =>
      BaseResponseAiProcessResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseAiProcessResultResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseAiProcessResultResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseAiProcessResultResponseBuilder
    implements
        Builder<
          BaseResponseAiProcessResultResponse,
          BaseResponseAiProcessResultResponseBuilder
        > {
  _$BaseResponseAiProcessResultResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  AiProcessResultResponseBuilder? _data;
  AiProcessResultResponseBuilder get data =>
      _$this._data ??= AiProcessResultResponseBuilder();
  set data(AiProcessResultResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseAiProcessResultResponseBuilder() {
    BaseResponseAiProcessResultResponse._defaults(this);
  }

  BaseResponseAiProcessResultResponseBuilder get _$this {
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
  void replace(BaseResponseAiProcessResultResponse other) {
    _$v = other as _$BaseResponseAiProcessResultResponse;
  }

  @override
  void update(
    void Function(BaseResponseAiProcessResultResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseAiProcessResultResponse build() => _build();

  _$BaseResponseAiProcessResultResponse _build() {
    _$BaseResponseAiProcessResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseAiProcessResultResponse._(
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
          r'BaseResponseAiProcessResultResponse',
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
