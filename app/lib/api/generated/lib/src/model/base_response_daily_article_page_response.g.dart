// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_daily_article_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDailyArticlePageResponse
    extends BaseResponseDailyArticlePageResponse {
  @override
  final int? code;
  @override
  final DailyArticlePageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDailyArticlePageResponse([
    void Function(BaseResponseDailyArticlePageResponseBuilder)? updates,
  ]) =>
      (BaseResponseDailyArticlePageResponseBuilder()..update(updates))._build();

  _$BaseResponseDailyArticlePageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDailyArticlePageResponse rebuild(
    void Function(BaseResponseDailyArticlePageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDailyArticlePageResponseBuilder toBuilder() =>
      BaseResponseDailyArticlePageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDailyArticlePageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDailyArticlePageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDailyArticlePageResponseBuilder
    implements
        Builder<
          BaseResponseDailyArticlePageResponse,
          BaseResponseDailyArticlePageResponseBuilder
        > {
  _$BaseResponseDailyArticlePageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DailyArticlePageResponseBuilder? _data;
  DailyArticlePageResponseBuilder get data =>
      _$this._data ??= DailyArticlePageResponseBuilder();
  set data(DailyArticlePageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDailyArticlePageResponseBuilder() {
    BaseResponseDailyArticlePageResponse._defaults(this);
  }

  BaseResponseDailyArticlePageResponseBuilder get _$this {
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
  void replace(BaseResponseDailyArticlePageResponse other) {
    _$v = other as _$BaseResponseDailyArticlePageResponse;
  }

  @override
  void update(
    void Function(BaseResponseDailyArticlePageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDailyArticlePageResponse build() => _build();

  _$BaseResponseDailyArticlePageResponse _build() {
    _$BaseResponseDailyArticlePageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDailyArticlePageResponse._(
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
          r'BaseResponseDailyArticlePageResponse',
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
