// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_scrape_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseScrapeResultResponse
    extends BaseResponseScrapeResultResponse {
  @override
  final int? code;
  @override
  final ScrapeResultResponse? data;
  @override
  final String? message;

  factory _$BaseResponseScrapeResultResponse([
    void Function(BaseResponseScrapeResultResponseBuilder)? updates,
  ]) => (BaseResponseScrapeResultResponseBuilder()..update(updates))._build();

  _$BaseResponseScrapeResultResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseScrapeResultResponse rebuild(
    void Function(BaseResponseScrapeResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseScrapeResultResponseBuilder toBuilder() =>
      BaseResponseScrapeResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseScrapeResultResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseScrapeResultResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseScrapeResultResponseBuilder
    implements
        Builder<
          BaseResponseScrapeResultResponse,
          BaseResponseScrapeResultResponseBuilder
        > {
  _$BaseResponseScrapeResultResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ScrapeResultResponseBuilder? _data;
  ScrapeResultResponseBuilder get data =>
      _$this._data ??= ScrapeResultResponseBuilder();
  set data(ScrapeResultResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseScrapeResultResponseBuilder() {
    BaseResponseScrapeResultResponse._defaults(this);
  }

  BaseResponseScrapeResultResponseBuilder get _$this {
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
  void replace(BaseResponseScrapeResultResponse other) {
    _$v = other as _$BaseResponseScrapeResultResponse;
  }

  @override
  void update(void Function(BaseResponseScrapeResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseScrapeResultResponse build() => _build();

  _$BaseResponseScrapeResultResponse _build() {
    _$BaseResponseScrapeResultResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseScrapeResultResponse._(
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
          r'BaseResponseScrapeResultResponse',
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
