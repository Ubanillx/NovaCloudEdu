// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_tts_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseTtsResponse extends BaseResponseTtsResponse {
  @override
  final int? code;
  @override
  final TtsResponse? data;
  @override
  final String? message;

  factory _$BaseResponseTtsResponse([
    void Function(BaseResponseTtsResponseBuilder)? updates,
  ]) => (BaseResponseTtsResponseBuilder()..update(updates))._build();

  _$BaseResponseTtsResponse._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseTtsResponse rebuild(
    void Function(BaseResponseTtsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseTtsResponseBuilder toBuilder() =>
      BaseResponseTtsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseTtsResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseTtsResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseTtsResponseBuilder
    implements
        Builder<BaseResponseTtsResponse, BaseResponseTtsResponseBuilder> {
  _$BaseResponseTtsResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  TtsResponseBuilder? _data;
  TtsResponseBuilder get data => _$this._data ??= TtsResponseBuilder();
  set data(TtsResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseTtsResponseBuilder() {
    BaseResponseTtsResponse._defaults(this);
  }

  BaseResponseTtsResponseBuilder get _$this {
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
  void replace(BaseResponseTtsResponse other) {
    _$v = other as _$BaseResponseTtsResponse;
  }

  @override
  void update(void Function(BaseResponseTtsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseTtsResponse build() => _build();

  _$BaseResponseTtsResponse _build() {
    _$BaseResponseTtsResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseTtsResponse._(
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
          r'BaseResponseTtsResponse',
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
