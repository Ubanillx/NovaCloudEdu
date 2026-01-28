// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_upload_file_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUploadFileResponse extends BaseResponseUploadFileResponse {
  @override
  final int? code;
  @override
  final UploadFileResponse? data;
  @override
  final String? message;

  factory _$BaseResponseUploadFileResponse([
    void Function(BaseResponseUploadFileResponseBuilder)? updates,
  ]) => (BaseResponseUploadFileResponseBuilder()..update(updates))._build();

  _$BaseResponseUploadFileResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseUploadFileResponse rebuild(
    void Function(BaseResponseUploadFileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseUploadFileResponseBuilder toBuilder() =>
      BaseResponseUploadFileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUploadFileResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseUploadFileResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUploadFileResponseBuilder
    implements
        Builder<
          BaseResponseUploadFileResponse,
          BaseResponseUploadFileResponseBuilder
        > {
  _$BaseResponseUploadFileResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UploadFileResponseBuilder? _data;
  UploadFileResponseBuilder get data =>
      _$this._data ??= UploadFileResponseBuilder();
  set data(UploadFileResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUploadFileResponseBuilder() {
    BaseResponseUploadFileResponse._defaults(this);
  }

  BaseResponseUploadFileResponseBuilder get _$this {
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
  void replace(BaseResponseUploadFileResponse other) {
    _$v = other as _$BaseResponseUploadFileResponse;
  }

  @override
  void update(void Function(BaseResponseUploadFileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUploadFileResponse build() => _build();

  _$BaseResponseUploadFileResponse _build() {
    _$BaseResponseUploadFileResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseUploadFileResponse._(
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
          r'BaseResponseUploadFileResponse',
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
