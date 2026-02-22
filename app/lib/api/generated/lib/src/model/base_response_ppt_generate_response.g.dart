// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_ppt_generate_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePptGenerateResponse
    extends BaseResponsePptGenerateResponse {
  @override
  final int? code;
  @override
  final PptGenerateResponse? data;
  @override
  final String? message;

  factory _$BaseResponsePptGenerateResponse([
    void Function(BaseResponsePptGenerateResponseBuilder)? updates,
  ]) => (BaseResponsePptGenerateResponseBuilder()..update(updates))._build();

  _$BaseResponsePptGenerateResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponsePptGenerateResponse rebuild(
    void Function(BaseResponsePptGenerateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePptGenerateResponseBuilder toBuilder() =>
      BaseResponsePptGenerateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePptGenerateResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponsePptGenerateResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePptGenerateResponseBuilder
    implements
        Builder<
          BaseResponsePptGenerateResponse,
          BaseResponsePptGenerateResponseBuilder
        > {
  _$BaseResponsePptGenerateResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PptGenerateResponseBuilder? _data;
  PptGenerateResponseBuilder get data =>
      _$this._data ??= PptGenerateResponseBuilder();
  set data(PptGenerateResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePptGenerateResponseBuilder() {
    BaseResponsePptGenerateResponse._defaults(this);
  }

  BaseResponsePptGenerateResponseBuilder get _$this {
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
  void replace(BaseResponsePptGenerateResponse other) {
    _$v = other as _$BaseResponsePptGenerateResponse;
  }

  @override
  void update(void Function(BaseResponsePptGenerateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePptGenerateResponse build() => _build();

  _$BaseResponsePptGenerateResponse _build() {
    _$BaseResponsePptGenerateResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePptGenerateResponse._(
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
          r'BaseResponsePptGenerateResponse',
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
