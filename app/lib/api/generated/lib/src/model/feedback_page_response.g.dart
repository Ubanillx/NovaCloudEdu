// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeedbackPageResponse extends FeedbackPageResponse {
  @override
  final BuiltList<FeedbackResponse>? list;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$FeedbackPageResponse([
    void Function(FeedbackPageResponseBuilder)? updates,
  ]) => (FeedbackPageResponseBuilder()..update(updates))._build();

  _$FeedbackPageResponse._({
    this.list,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  FeedbackPageResponse rebuild(
    void Function(FeedbackPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FeedbackPageResponseBuilder toBuilder() =>
      FeedbackPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedbackPageResponse &&
        list == other.list &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, list.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeedbackPageResponse')
          ..add('list', list)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class FeedbackPageResponseBuilder
    implements Builder<FeedbackPageResponse, FeedbackPageResponseBuilder> {
  _$FeedbackPageResponse? _$v;

  ListBuilder<FeedbackResponse>? _list;
  ListBuilder<FeedbackResponse> get list =>
      _$this._list ??= ListBuilder<FeedbackResponse>();
  set list(ListBuilder<FeedbackResponse>? list) => _$this._list = list;

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

  FeedbackPageResponseBuilder() {
    FeedbackPageResponse._defaults(this);
  }

  FeedbackPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _list = $v.list?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedbackPageResponse other) {
    _$v = other as _$FeedbackPageResponse;
  }

  @override
  void update(void Function(FeedbackPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeedbackPageResponse build() => _build();

  _$FeedbackPageResponse _build() {
    _$FeedbackPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$FeedbackPageResponse._(
            list: _list?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'list';
        _list?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FeedbackPageResponse',
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
