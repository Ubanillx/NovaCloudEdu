// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_article_source_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListArticleSourceResponse
    extends BaseResponseListArticleSourceResponse {
  @override
  final int? code;
  @override
  final BuiltList<ArticleSourceResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListArticleSourceResponse([
    void Function(BaseResponseListArticleSourceResponseBuilder)? updates,
  ]) => (BaseResponseListArticleSourceResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListArticleSourceResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListArticleSourceResponse rebuild(
    void Function(BaseResponseListArticleSourceResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListArticleSourceResponseBuilder toBuilder() =>
      BaseResponseListArticleSourceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListArticleSourceResponse &&
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
            r'BaseResponseListArticleSourceResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListArticleSourceResponseBuilder
    implements
        Builder<
          BaseResponseListArticleSourceResponse,
          BaseResponseListArticleSourceResponseBuilder
        > {
  _$BaseResponseListArticleSourceResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ArticleSourceResponse>? _data;
  ListBuilder<ArticleSourceResponse> get data =>
      _$this._data ??= ListBuilder<ArticleSourceResponse>();
  set data(ListBuilder<ArticleSourceResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListArticleSourceResponseBuilder() {
    BaseResponseListArticleSourceResponse._defaults(this);
  }

  BaseResponseListArticleSourceResponseBuilder get _$this {
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
  void replace(BaseResponseListArticleSourceResponse other) {
    _$v = other as _$BaseResponseListArticleSourceResponse;
  }

  @override
  void update(
    void Function(BaseResponseListArticleSourceResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListArticleSourceResponse build() => _build();

  _$BaseResponseListArticleSourceResponse _build() {
    _$BaseResponseListArticleSourceResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListArticleSourceResponse._(
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
          r'BaseResponseListArticleSourceResponse',
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
