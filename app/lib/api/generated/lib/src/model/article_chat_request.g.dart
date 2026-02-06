// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_chat_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ArticleChatRequest extends ArticleChatRequest {
  @override
  final int articleId;
  @override
  final String message;
  @override
  final BuiltList<BuiltMap<String, String>>? history;

  factory _$ArticleChatRequest([
    void Function(ArticleChatRequestBuilder)? updates,
  ]) => (ArticleChatRequestBuilder()..update(updates))._build();

  _$ArticleChatRequest._({
    required this.articleId,
    required this.message,
    this.history,
  }) : super._();
  @override
  ArticleChatRequest rebuild(
    void Function(ArticleChatRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ArticleChatRequestBuilder toBuilder() =>
      ArticleChatRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArticleChatRequest &&
        articleId == other.articleId &&
        message == other.message &&
        history == other.history;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, articleId.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, history.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ArticleChatRequest')
          ..add('articleId', articleId)
          ..add('message', message)
          ..add('history', history))
        .toString();
  }
}

class ArticleChatRequestBuilder
    implements Builder<ArticleChatRequest, ArticleChatRequestBuilder> {
  _$ArticleChatRequest? _$v;

  int? _articleId;
  int? get articleId => _$this._articleId;
  set articleId(int? articleId) => _$this._articleId = articleId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<BuiltMap<String, String>>? _history;
  ListBuilder<BuiltMap<String, String>> get history =>
      _$this._history ??= ListBuilder<BuiltMap<String, String>>();
  set history(ListBuilder<BuiltMap<String, String>>? history) =>
      _$this._history = history;

  ArticleChatRequestBuilder() {
    ArticleChatRequest._defaults(this);
  }

  ArticleChatRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _articleId = $v.articleId;
      _message = $v.message;
      _history = $v.history?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArticleChatRequest other) {
    _$v = other as _$ArticleChatRequest;
  }

  @override
  void update(void Function(ArticleChatRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ArticleChatRequest build() => _build();

  _$ArticleChatRequest _build() {
    _$ArticleChatRequest _$result;
    try {
      _$result =
          _$v ??
          _$ArticleChatRequest._(
            articleId: BuiltValueNullFieldError.checkNotNull(
              articleId,
              r'ArticleChatRequest',
              'articleId',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'ArticleChatRequest',
              'message',
            ),
            history: _history?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'history';
        _history?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ArticleChatRequest',
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
