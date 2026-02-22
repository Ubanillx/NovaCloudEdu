// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PageResult extends PageResult {
  @override
  final BuiltList<SearchResultDTO>? items;
  @override
  final int? total;
  @override
  final int? page;
  @override
  final int? size;
  @override
  final int? totalPages;

  factory _$PageResult([void Function(PageResultBuilder)? updates]) =>
      (PageResultBuilder()..update(updates))._build();

  _$PageResult._({
    this.items,
    this.total,
    this.page,
    this.size,
    this.totalPages,
  }) : super._();
  @override
  PageResult rebuild(void Function(PageResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PageResultBuilder toBuilder() => PageResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PageResult &&
        items == other.items &&
        total == other.total &&
        page == other.page &&
        size == other.size &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, size.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PageResult')
          ..add('items', items)
          ..add('total', total)
          ..add('page', page)
          ..add('size', size)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class PageResultBuilder implements Builder<PageResult, PageResultBuilder> {
  _$PageResult? _$v;

  ListBuilder<SearchResultDTO>? _items;
  ListBuilder<SearchResultDTO> get items =>
      _$this._items ??= ListBuilder<SearchResultDTO>();
  set items(ListBuilder<SearchResultDTO>? items) => _$this._items = items;

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

  PageResultBuilder() {
    PageResult._defaults(this);
  }

  PageResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items?.toBuilder();
      _total = $v.total;
      _page = $v.page;
      _size = $v.size;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PageResult other) {
    _$v = other as _$PageResult;
  }

  @override
  void update(void Function(PageResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PageResult build() => _build();

  _$PageResult _build() {
    _$PageResult _$result;
    try {
      _$result =
          _$v ??
          _$PageResult._(
            items: _items?.build(),
            total: total,
            page: page,
            size: size,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PageResult',
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
