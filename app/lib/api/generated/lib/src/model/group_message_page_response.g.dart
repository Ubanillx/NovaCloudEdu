// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_message_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GroupMessagePageResponse extends GroupMessagePageResponse {
  @override
  final BuiltList<GroupMessageItem>? messages;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$GroupMessagePageResponse([
    void Function(GroupMessagePageResponseBuilder)? updates,
  ]) => (GroupMessagePageResponseBuilder()..update(updates))._build();

  _$GroupMessagePageResponse._({
    this.messages,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  GroupMessagePageResponse rebuild(
    void Function(GroupMessagePageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GroupMessagePageResponseBuilder toBuilder() =>
      GroupMessagePageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupMessagePageResponse &&
        messages == other.messages &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GroupMessagePageResponse')
          ..add('messages', messages)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class GroupMessagePageResponseBuilder
    implements
        Builder<GroupMessagePageResponse, GroupMessagePageResponseBuilder> {
  _$GroupMessagePageResponse? _$v;

  ListBuilder<GroupMessageItem>? _messages;
  ListBuilder<GroupMessageItem> get messages =>
      _$this._messages ??= ListBuilder<GroupMessageItem>();
  set messages(ListBuilder<GroupMessageItem>? messages) =>
      _$this._messages = messages;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  GroupMessagePageResponseBuilder() {
    GroupMessagePageResponse._defaults(this);
  }

  GroupMessagePageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _messages = $v.messages?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupMessagePageResponse other) {
    _$v = other as _$GroupMessagePageResponse;
  }

  @override
  void update(void Function(GroupMessagePageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupMessagePageResponse build() => _build();

  _$GroupMessagePageResponse _build() {
    _$GroupMessagePageResponse _$result;
    try {
      _$result =
          _$v ??
          _$GroupMessagePageResponse._(
            messages: _messages?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        _messages?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GroupMessagePageResponse',
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
