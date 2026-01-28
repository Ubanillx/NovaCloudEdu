// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommentPageResponse extends CommentPageResponse {
  @override
  final BuiltList<CommentResponse>? comments;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$CommentPageResponse([
    void Function(CommentPageResponseBuilder)? updates,
  ]) => (CommentPageResponseBuilder()..update(updates))._build();

  _$CommentPageResponse._({
    this.comments,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  CommentPageResponse rebuild(
    void Function(CommentPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CommentPageResponseBuilder toBuilder() =>
      CommentPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentPageResponse &&
        comments == other.comments &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, comments.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommentPageResponse')
          ..add('comments', comments)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class CommentPageResponseBuilder
    implements Builder<CommentPageResponse, CommentPageResponseBuilder> {
  _$CommentPageResponse? _$v;

  ListBuilder<CommentResponse>? _comments;
  ListBuilder<CommentResponse> get comments =>
      _$this._comments ??= ListBuilder<CommentResponse>();
  set comments(ListBuilder<CommentResponse>? comments) =>
      _$this._comments = comments;

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

  CommentPageResponseBuilder() {
    CommentPageResponse._defaults(this);
  }

  CommentPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comments = $v.comments?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommentPageResponse other) {
    _$v = other as _$CommentPageResponse;
  }

  @override
  void update(void Function(CommentPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommentPageResponse build() => _build();

  _$CommentPageResponse _build() {
    _$CommentPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$CommentPageResponse._(
            comments: _comments?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'comments';
        _comments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CommentPageResponse',
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
