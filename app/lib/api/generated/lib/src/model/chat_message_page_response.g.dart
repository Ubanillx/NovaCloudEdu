// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatMessagePageResponse extends ChatMessagePageResponse {
  @override
  final BuiltList<ChatMessageResponse>? messages;
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? size;
  @override
  final int? totalPages;
  @override
  final bool? hasMore;

  factory _$ChatMessagePageResponse([
    void Function(ChatMessagePageResponseBuilder)? updates,
  ]) => (ChatMessagePageResponseBuilder()..update(updates))._build();

  _$ChatMessagePageResponse._({
    this.messages,
    this.total,
    this.page,
    this.size,
    this.totalPages,
    this.hasMore,
  }) : super._();
  @override
  ChatMessagePageResponse rebuild(
    void Function(ChatMessagePageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChatMessagePageResponseBuilder toBuilder() =>
      ChatMessagePageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatMessagePageResponse &&
        messages == other.messages &&
        total == other.total &&
        page == other.page &&
        size == other.size &&
        totalPages == other.totalPages &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatMessagePageResponse')
          ..add('messages', messages)
          ..add('total', total)
          ..add('page', page)
          ..add('size', size)
          ..add('totalPages', totalPages)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class ChatMessagePageResponseBuilder
    implements
        Builder<ChatMessagePageResponse, ChatMessagePageResponseBuilder> {
  _$ChatMessagePageResponse? _$v;

  ListBuilder<ChatMessageResponse>? _messages;
  ListBuilder<ChatMessageResponse> get messages =>
      _$this._messages ??= ListBuilder<ChatMessageResponse>();
  set messages(ListBuilder<ChatMessageResponse>? messages) =>
      _$this._messages = messages;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  ChatMessagePageResponseBuilder() {
    ChatMessagePageResponse._defaults(this);
  }

  ChatMessagePageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _messages = $v.messages?.toBuilder();
      _total = $v.total;
      _page = $v.page;
      _size = $v.size;
      _totalPages = $v.totalPages;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatMessagePageResponse other) {
    _$v = other as _$ChatMessagePageResponse;
  }

  @override
  void update(void Function(ChatMessagePageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatMessagePageResponse build() => _build();

  _$ChatMessagePageResponse _build() {
    _$ChatMessagePageResponse _$result;
    try {
      _$result =
          _$v ??
          _$ChatMessagePageResponse._(
            messages: _messages?.build(),
            total: total,
            page: page,
            size: size,
            totalPages: totalPages,
            hasMore: hasMore,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        _messages?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChatMessagePageResponse',
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
