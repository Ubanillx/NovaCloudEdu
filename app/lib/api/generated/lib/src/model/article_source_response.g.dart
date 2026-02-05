// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_source_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ArticleSourceResponse extends ArticleSourceResponse {
  @override
  final String? code;
  @override
  final String? name;
  @override
  final String? baseUrl;
  @override
  final String? description;

  factory _$ArticleSourceResponse([
    void Function(ArticleSourceResponseBuilder)? updates,
  ]) => (ArticleSourceResponseBuilder()..update(updates))._build();

  _$ArticleSourceResponse._({
    this.code,
    this.name,
    this.baseUrl,
    this.description,
  }) : super._();
  @override
  ArticleSourceResponse rebuild(
    void Function(ArticleSourceResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ArticleSourceResponseBuilder toBuilder() =>
      ArticleSourceResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArticleSourceResponse &&
        code == other.code &&
        name == other.name &&
        baseUrl == other.baseUrl &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, baseUrl.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ArticleSourceResponse')
          ..add('code', code)
          ..add('name', name)
          ..add('baseUrl', baseUrl)
          ..add('description', description))
        .toString();
  }
}

class ArticleSourceResponseBuilder
    implements Builder<ArticleSourceResponse, ArticleSourceResponseBuilder> {
  _$ArticleSourceResponse? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _baseUrl;
  String? get baseUrl => _$this._baseUrl;
  set baseUrl(String? baseUrl) => _$this._baseUrl = baseUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ArticleSourceResponseBuilder() {
    ArticleSourceResponse._defaults(this);
  }

  ArticleSourceResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _name = $v.name;
      _baseUrl = $v.baseUrl;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArticleSourceResponse other) {
    _$v = other as _$ArticleSourceResponse;
  }

  @override
  void update(void Function(ArticleSourceResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ArticleSourceResponse build() => _build();

  _$ArticleSourceResponse _build() {
    final _$result =
        _$v ??
        _$ArticleSourceResponse._(
          code: code,
          name: name,
          baseUrl: baseUrl,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
