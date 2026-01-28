// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatHistoryRequestDTO extends ChatHistoryRequestDTO {
  @override
  final int partnerId;
  @override
  final int? page;
  @override
  final int? size;
  @override
  final int? beforeMessageId;

  factory _$ChatHistoryRequestDTO([
    void Function(ChatHistoryRequestDTOBuilder)? updates,
  ]) => (ChatHistoryRequestDTOBuilder()..update(updates))._build();

  _$ChatHistoryRequestDTO._({
    required this.partnerId,
    this.page,
    this.size,
    this.beforeMessageId,
  }) : super._();
  @override
  ChatHistoryRequestDTO rebuild(
    void Function(ChatHistoryRequestDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChatHistoryRequestDTOBuilder toBuilder() =>
      ChatHistoryRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatHistoryRequestDTO &&
        partnerId == other.partnerId &&
        page == other.page &&
        size == other.size &&
        beforeMessageId == other.beforeMessageId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, partnerId.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, beforeMessageId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatHistoryRequestDTO')
          ..add('partnerId', partnerId)
          ..add('page', page)
          ..add('size', size)
          ..add('beforeMessageId', beforeMessageId))
        .toString();
  }
}

class ChatHistoryRequestDTOBuilder
    implements Builder<ChatHistoryRequestDTO, ChatHistoryRequestDTOBuilder> {
  _$ChatHistoryRequestDTO? _$v;

  int? _partnerId;
  int? get partnerId => _$this._partnerId;
  set partnerId(int? partnerId) => _$this._partnerId = partnerId;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _size;
  int? get size => _$this._size;
  set size(int? size) => _$this._size = size;

  int? _beforeMessageId;
  int? get beforeMessageId => _$this._beforeMessageId;
  set beforeMessageId(int? beforeMessageId) =>
      _$this._beforeMessageId = beforeMessageId;

  ChatHistoryRequestDTOBuilder() {
    ChatHistoryRequestDTO._defaults(this);
  }

  ChatHistoryRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _partnerId = $v.partnerId;
      _page = $v.page;
      _size = $v.size;
      _beforeMessageId = $v.beforeMessageId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatHistoryRequestDTO other) {
    _$v = other as _$ChatHistoryRequestDTO;
  }

  @override
  void update(void Function(ChatHistoryRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatHistoryRequestDTO build() => _build();

  _$ChatHistoryRequestDTO _build() {
    final _$result =
        _$v ??
        _$ChatHistoryRequestDTO._(
          partnerId: BuiltValueNullFieldError.checkNotNull(
            partnerId,
            r'ChatHistoryRequestDTO',
            'partnerId',
          ),
          page: page,
          size: size,
          beforeMessageId: beforeMessageId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
