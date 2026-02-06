// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_process_article_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AiProcessArticleRequest extends AiProcessArticleRequest {
  @override
  final int articleId;
  @override
  final bool? formatContent;
  @override
  final bool? generateSummary;
  @override
  final int? summaryMaxLength;

  factory _$AiProcessArticleRequest([
    void Function(AiProcessArticleRequestBuilder)? updates,
  ]) => (AiProcessArticleRequestBuilder()..update(updates))._build();

  _$AiProcessArticleRequest._({
    required this.articleId,
    this.formatContent,
    this.generateSummary,
    this.summaryMaxLength,
  }) : super._();
  @override
  AiProcessArticleRequest rebuild(
    void Function(AiProcessArticleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AiProcessArticleRequestBuilder toBuilder() =>
      AiProcessArticleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AiProcessArticleRequest &&
        articleId == other.articleId &&
        formatContent == other.formatContent &&
        generateSummary == other.generateSummary &&
        summaryMaxLength == other.summaryMaxLength;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, articleId.hashCode);
    _$hash = $jc(_$hash, formatContent.hashCode);
    _$hash = $jc(_$hash, generateSummary.hashCode);
    _$hash = $jc(_$hash, summaryMaxLength.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AiProcessArticleRequest')
          ..add('articleId', articleId)
          ..add('formatContent', formatContent)
          ..add('generateSummary', generateSummary)
          ..add('summaryMaxLength', summaryMaxLength))
        .toString();
  }
}

class AiProcessArticleRequestBuilder
    implements
        Builder<AiProcessArticleRequest, AiProcessArticleRequestBuilder> {
  _$AiProcessArticleRequest? _$v;

  int? _articleId;
  int? get articleId => _$this._articleId;
  set articleId(int? articleId) => _$this._articleId = articleId;

  bool? _formatContent;
  bool? get formatContent => _$this._formatContent;
  set formatContent(bool? formatContent) =>
      _$this._formatContent = formatContent;

  bool? _generateSummary;
  bool? get generateSummary => _$this._generateSummary;
  set generateSummary(bool? generateSummary) =>
      _$this._generateSummary = generateSummary;

  int? _summaryMaxLength;
  int? get summaryMaxLength => _$this._summaryMaxLength;
  set summaryMaxLength(int? summaryMaxLength) =>
      _$this._summaryMaxLength = summaryMaxLength;

  AiProcessArticleRequestBuilder() {
    AiProcessArticleRequest._defaults(this);
  }

  AiProcessArticleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _articleId = $v.articleId;
      _formatContent = $v.formatContent;
      _generateSummary = $v.generateSummary;
      _summaryMaxLength = $v.summaryMaxLength;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AiProcessArticleRequest other) {
    _$v = other as _$AiProcessArticleRequest;
  }

  @override
  void update(void Function(AiProcessArticleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AiProcessArticleRequest build() => _build();

  _$AiProcessArticleRequest _build() {
    final _$result =
        _$v ??
        _$AiProcessArticleRequest._(
          articleId: BuiltValueNullFieldError.checkNotNull(
            articleId,
            r'AiProcessArticleRequest',
            'articleId',
          ),
          formatContent: formatContent,
          generateSummary: generateSummary,
          summaryMaxLength: summaryMaxLength,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
