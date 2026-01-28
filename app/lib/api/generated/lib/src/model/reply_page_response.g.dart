// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReplyPageResponse extends ReplyPageResponse {
  @override
  final BuiltList<ReplyResponse>? replies;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$ReplyPageResponse([
    void Function(ReplyPageResponseBuilder)? updates,
  ]) => (ReplyPageResponseBuilder()..update(updates))._build();

  _$ReplyPageResponse._({
    this.replies,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  ReplyPageResponse rebuild(void Function(ReplyPageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyPageResponseBuilder toBuilder() =>
      ReplyPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReplyPageResponse &&
        replies == other.replies &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, replies.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReplyPageResponse')
          ..add('replies', replies)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class ReplyPageResponseBuilder
    implements Builder<ReplyPageResponse, ReplyPageResponseBuilder> {
  _$ReplyPageResponse? _$v;

  ListBuilder<ReplyResponse>? _replies;
  ListBuilder<ReplyResponse> get replies =>
      _$this._replies ??= ListBuilder<ReplyResponse>();
  set replies(ListBuilder<ReplyResponse>? replies) => _$this._replies = replies;

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

  ReplyPageResponseBuilder() {
    ReplyPageResponse._defaults(this);
  }

  ReplyPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _replies = $v.replies?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReplyPageResponse other) {
    _$v = other as _$ReplyPageResponse;
  }

  @override
  void update(void Function(ReplyPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReplyPageResponse build() => _build();

  _$ReplyPageResponse _build() {
    _$ReplyPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$ReplyPageResponse._(
            replies: _replies?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'replies';
        _replies?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ReplyPageResponse',
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
