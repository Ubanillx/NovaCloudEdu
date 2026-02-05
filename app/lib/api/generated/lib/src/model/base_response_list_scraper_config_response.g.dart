// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_scraper_config_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListScraperConfigResponse
    extends BaseResponseListScraperConfigResponse {
  @override
  final int? code;
  @override
  final BuiltList<ScraperConfigResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListScraperConfigResponse([
    void Function(BaseResponseListScraperConfigResponseBuilder)? updates,
  ]) => (BaseResponseListScraperConfigResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListScraperConfigResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListScraperConfigResponse rebuild(
    void Function(BaseResponseListScraperConfigResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListScraperConfigResponseBuilder toBuilder() =>
      BaseResponseListScraperConfigResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListScraperConfigResponse &&
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
            r'BaseResponseListScraperConfigResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListScraperConfigResponseBuilder
    implements
        Builder<
          BaseResponseListScraperConfigResponse,
          BaseResponseListScraperConfigResponseBuilder
        > {
  _$BaseResponseListScraperConfigResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ScraperConfigResponse>? _data;
  ListBuilder<ScraperConfigResponse> get data =>
      _$this._data ??= ListBuilder<ScraperConfigResponse>();
  set data(ListBuilder<ScraperConfigResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListScraperConfigResponseBuilder() {
    BaseResponseListScraperConfigResponse._defaults(this);
  }

  BaseResponseListScraperConfigResponseBuilder get _$this {
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
  void replace(BaseResponseListScraperConfigResponse other) {
    _$v = other as _$BaseResponseListScraperConfigResponse;
  }

  @override
  void update(
    void Function(BaseResponseListScraperConfigResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListScraperConfigResponse build() => _build();

  _$BaseResponseListScraperConfigResponse _build() {
    _$BaseResponseListScraperConfigResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListScraperConfigResponse._(
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
          r'BaseResponseListScraperConfigResponse',
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
