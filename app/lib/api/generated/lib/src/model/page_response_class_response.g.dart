// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_class_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResponseClassResponse extends PageResponseClassResponse {
  @override
  final BuiltList<ClassResponse>? list;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$PageResponseClassResponse([
    void Function(PageResponseClassResponseBuilder)? updates,
  ]) => (PageResponseClassResponseBuilder()..update(updates))._build();

  _$PageResponseClassResponse._({
    this.list,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  PageResponseClassResponse rebuild(
    void Function(PageResponseClassResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PageResponseClassResponseBuilder toBuilder() =>
      PageResponseClassResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResponseClassResponse &&
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
    return (newBuiltValueToStringHelper(r'PageResponseClassResponse')
          ..add('list', list)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class PageResponseClassResponseBuilder
    implements
        Builder<PageResponseClassResponse, PageResponseClassResponseBuilder> {
  _$PageResponseClassResponse? _$v;

  ListBuilder<ClassResponse>? _list;
  ListBuilder<ClassResponse> get list =>
      _$this._list ??= ListBuilder<ClassResponse>();
  set list(ListBuilder<ClassResponse>? list) => _$this._list = list;

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

  PageResponseClassResponseBuilder() {
    PageResponseClassResponse._defaults(this);
  }

  PageResponseClassResponseBuilder get _$this {
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
  void replace(PageResponseClassResponse other) {
    _$v = other as _$PageResponseClassResponse;
  }

  @override
  void update(void Function(PageResponseClassResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResponseClassResponse build() => _build();

  _$PageResponseClassResponse _build() {
    _$PageResponseClassResponse _$result;
    try {
      _$result =
          _$v ??
          _$PageResponseClassResponse._(
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
          r'PageResponseClassResponse',
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
