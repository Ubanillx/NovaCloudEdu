// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_scraper_task_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseScraperTaskPageResponse
    extends BaseResponseScraperTaskPageResponse {
  @override
  final int? code;
  @override
  final ScraperTaskPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseScraperTaskPageResponse([
    void Function(BaseResponseScraperTaskPageResponseBuilder)? updates,
  ]) =>
      (BaseResponseScraperTaskPageResponseBuilder()..update(updates))._build();

  _$BaseResponseScraperTaskPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseScraperTaskPageResponse rebuild(
    void Function(BaseResponseScraperTaskPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseScraperTaskPageResponseBuilder toBuilder() =>
      BaseResponseScraperTaskPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseScraperTaskPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseScraperTaskPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseScraperTaskPageResponseBuilder
    implements
        Builder<
          BaseResponseScraperTaskPageResponse,
          BaseResponseScraperTaskPageResponseBuilder
        > {
  _$BaseResponseScraperTaskPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ScraperTaskPageResponseBuilder? _data;
  ScraperTaskPageResponseBuilder get data =>
      _$this._data ??= ScraperTaskPageResponseBuilder();
  set data(ScraperTaskPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseScraperTaskPageResponseBuilder() {
    BaseResponseScraperTaskPageResponse._defaults(this);
  }

  BaseResponseScraperTaskPageResponseBuilder get _$this {
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
  void replace(BaseResponseScraperTaskPageResponse other) {
    _$v = other as _$BaseResponseScraperTaskPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseScraperTaskPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseScraperTaskPageResponse build() => _build();

  _$BaseResponseScraperTaskPageResponse _build() {
    _$BaseResponseScraperTaskPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseScraperTaskPageResponse._(
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
          r'BaseResponseScraperTaskPageResponse',
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
