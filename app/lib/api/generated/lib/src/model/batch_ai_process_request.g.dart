// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_ai_process_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchAiProcessRequest extends BatchAiProcessRequest {
  @override
  final BuiltList<int> articleIds;
  @override
  final bool? formatContent;
  @override
  final bool? generateSummary;

  factory _$BatchAiProcessRequest([
    void Function(BatchAiProcessRequestBuilder)? updates,
  ]) => (BatchAiProcessRequestBuilder()..update(updates))._build();

  _$BatchAiProcessRequest._({
    required this.articleIds,
    this.formatContent,
    this.generateSummary,
  }) : super._();
  @override
  BatchAiProcessRequest rebuild(
    void Function(BatchAiProcessRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BatchAiProcessRequestBuilder toBuilder() =>
      BatchAiProcessRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchAiProcessRequest &&
        articleIds == other.articleIds &&
        formatContent == other.formatContent &&
        generateSummary == other.generateSummary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, articleIds.hashCode);
    _$hash = $jc(_$hash, formatContent.hashCode);
    _$hash = $jc(_$hash, generateSummary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BatchAiProcessRequest')
          ..add('articleIds', articleIds)
          ..add('formatContent', formatContent)
          ..add('generateSummary', generateSummary))
        .toString();
  }
}

class BatchAiProcessRequestBuilder
    implements Builder<BatchAiProcessRequest, BatchAiProcessRequestBuilder> {
  _$BatchAiProcessRequest? _$v;

  ListBuilder<int>? _articleIds;
  ListBuilder<int> get articleIds => _$this._articleIds ??= ListBuilder<int>();
  set articleIds(ListBuilder<int>? articleIds) =>
      _$this._articleIds = articleIds;

  bool? _formatContent;
  bool? get formatContent => _$this._formatContent;
  set formatContent(bool? formatContent) =>
      _$this._formatContent = formatContent;

  bool? _generateSummary;
  bool? get generateSummary => _$this._generateSummary;
  set generateSummary(bool? generateSummary) =>
      _$this._generateSummary = generateSummary;

  BatchAiProcessRequestBuilder() {
    BatchAiProcessRequest._defaults(this);
  }

  BatchAiProcessRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _articleIds = $v.articleIds.toBuilder();
      _formatContent = $v.formatContent;
      _generateSummary = $v.generateSummary;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchAiProcessRequest other) {
    _$v = other as _$BatchAiProcessRequest;
  }

  @override
  void update(void Function(BatchAiProcessRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchAiProcessRequest build() => _build();

  _$BatchAiProcessRequest _build() {
    _$BatchAiProcessRequest _$result;
    try {
      _$result =
          _$v ??
          _$BatchAiProcessRequest._(
            articleIds: articleIds.build(),
            formatContent: formatContent,
            generateSummary: generateSummary,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'articleIds';
        articleIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BatchAiProcessRequest',
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
