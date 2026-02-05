// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_scraper_config_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseScraperConfigResponse
    extends BaseResponseScraperConfigResponse {
  @override
  final int? code;
  @override
  final ScraperConfigResponse? data;
  @override
  final String? message;

  factory _$BaseResponseScraperConfigResponse([
    void Function(BaseResponseScraperConfigResponseBuilder)? updates,
  ]) => (BaseResponseScraperConfigResponseBuilder()..update(updates))._build();

  _$BaseResponseScraperConfigResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseScraperConfigResponse rebuild(
    void Function(BaseResponseScraperConfigResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseScraperConfigResponseBuilder toBuilder() =>
      BaseResponseScraperConfigResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseScraperConfigResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseScraperConfigResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseScraperConfigResponseBuilder
    implements
        Builder<
          BaseResponseScraperConfigResponse,
          BaseResponseScraperConfigResponseBuilder
        > {
  _$BaseResponseScraperConfigResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ScraperConfigResponseBuilder? _data;
  ScraperConfigResponseBuilder get data =>
      _$this._data ??= ScraperConfigResponseBuilder();
  set data(ScraperConfigResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseScraperConfigResponseBuilder() {
    BaseResponseScraperConfigResponse._defaults(this);
  }

  BaseResponseScraperConfigResponseBuilder get _$this {
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
  void replace(BaseResponseScraperConfigResponse other) {
    _$v = other as _$BaseResponseScraperConfigResponse;
  }

  @override
  void update(
    void Function(BaseResponseScraperConfigResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseScraperConfigResponse build() => _build();

  _$BaseResponseScraperConfigResponse _build() {
    _$BaseResponseScraperConfigResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseScraperConfigResponse._(
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
          r'BaseResponseScraperConfigResponse',
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
