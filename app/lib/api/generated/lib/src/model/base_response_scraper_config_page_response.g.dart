// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_scraper_config_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseScraperConfigPageResponse
    extends BaseResponseScraperConfigPageResponse {
  @override
  final int? code;
  @override
  final ScraperConfigPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseScraperConfigPageResponse([
    void Function(BaseResponseScraperConfigPageResponseBuilder)? updates,
  ]) => (BaseResponseScraperConfigPageResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseScraperConfigPageResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseScraperConfigPageResponse rebuild(
    void Function(BaseResponseScraperConfigPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseScraperConfigPageResponseBuilder toBuilder() =>
      BaseResponseScraperConfigPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseScraperConfigPageResponse &&
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
            r'BaseResponseScraperConfigPageResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseScraperConfigPageResponseBuilder
    implements
        Builder<
          BaseResponseScraperConfigPageResponse,
          BaseResponseScraperConfigPageResponseBuilder
        > {
  _$BaseResponseScraperConfigPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ScraperConfigPageResponseBuilder? _data;
  ScraperConfigPageResponseBuilder get data =>
      _$this._data ??= ScraperConfigPageResponseBuilder();
  set data(ScraperConfigPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseScraperConfigPageResponseBuilder() {
    BaseResponseScraperConfigPageResponse._defaults(this);
  }

  BaseResponseScraperConfigPageResponseBuilder get _$this {
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
  void replace(BaseResponseScraperConfigPageResponse other) {
    _$v = other as _$BaseResponseScraperConfigPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseScraperConfigPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseScraperConfigPageResponse build() => _build();

  _$BaseResponseScraperConfigPageResponse _build() {
    _$BaseResponseScraperConfigPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseScraperConfigPageResponse._(
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
          r'BaseResponseScraperConfigPageResponse',
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
