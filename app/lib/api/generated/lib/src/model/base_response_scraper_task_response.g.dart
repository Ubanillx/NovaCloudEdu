// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_scraper_task_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseScraperTaskResponse
    extends BaseResponseScraperTaskResponse {
  @override
  final int? code;
  @override
  final ScraperTaskResponse? data;
  @override
  final String? message;

  factory _$BaseResponseScraperTaskResponse([
    void Function(BaseResponseScraperTaskResponseBuilder)? updates,
  ]) => (BaseResponseScraperTaskResponseBuilder()..update(updates))._build();

  _$BaseResponseScraperTaskResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseScraperTaskResponse rebuild(
    void Function(BaseResponseScraperTaskResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseScraperTaskResponseBuilder toBuilder() =>
      BaseResponseScraperTaskResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseScraperTaskResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseScraperTaskResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseScraperTaskResponseBuilder
    implements
        Builder<
          BaseResponseScraperTaskResponse,
          BaseResponseScraperTaskResponseBuilder
        > {
  _$BaseResponseScraperTaskResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ScraperTaskResponseBuilder? _data;
  ScraperTaskResponseBuilder get data =>
      _$this._data ??= ScraperTaskResponseBuilder();
  set data(ScraperTaskResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseScraperTaskResponseBuilder() {
    BaseResponseScraperTaskResponse._defaults(this);
  }

  BaseResponseScraperTaskResponseBuilder get _$this {
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
  void replace(BaseResponseScraperTaskResponse other) {
    _$v = other as _$BaseResponseScraperTaskResponse;
  }

  @override
  void update(void Function(BaseResponseScraperTaskResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseScraperTaskResponse build() => _build();

  _$BaseResponseScraperTaskResponse _build() {
    _$BaseResponseScraperTaskResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseScraperTaskResponse._(
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
          r'BaseResponseScraperTaskResponse',
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
