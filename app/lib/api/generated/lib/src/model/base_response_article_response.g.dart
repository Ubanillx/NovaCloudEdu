// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseArticleResponse extends BaseResponseArticleResponse {
  @override
  final int? code;
  @override
  final ArticleResponse? data;
  @override
  final String? message;

  factory _$BaseResponseArticleResponse([
    void Function(BaseResponseArticleResponseBuilder)? updates,
  ]) => (BaseResponseArticleResponseBuilder()..update(updates))._build();

  _$BaseResponseArticleResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseArticleResponse rebuild(
    void Function(BaseResponseArticleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseArticleResponseBuilder toBuilder() =>
      BaseResponseArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseArticleResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseArticleResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseArticleResponseBuilder
    implements
        Builder<
          BaseResponseArticleResponse,
          BaseResponseArticleResponseBuilder
        > {
  _$BaseResponseArticleResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ArticleResponseBuilder? _data;
  ArticleResponseBuilder get data => _$this._data ??= ArticleResponseBuilder();
  set data(ArticleResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseArticleResponseBuilder() {
    BaseResponseArticleResponse._defaults(this);
  }

  BaseResponseArticleResponseBuilder get _$this {
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
  void replace(BaseResponseArticleResponse other) {
    _$v = other as _$BaseResponseArticleResponse;
  }

  @override
  void update(void Function(BaseResponseArticleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseArticleResponse build() => _build();

  _$BaseResponseArticleResponse _build() {
    _$BaseResponseArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseArticleResponse._(
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
          r'BaseResponseArticleResponse',
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
