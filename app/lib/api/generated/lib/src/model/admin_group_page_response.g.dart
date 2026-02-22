// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_group_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminGroupPageResponse extends AdminGroupPageResponse {
  @override
  final BuiltList<GroupResponse>? list;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$AdminGroupPageResponse([
    void Function(AdminGroupPageResponseBuilder)? updates,
  ]) => (AdminGroupPageResponseBuilder()..update(updates))._build();

  _$AdminGroupPageResponse._({
    this.list,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  AdminGroupPageResponse rebuild(
    void Function(AdminGroupPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminGroupPageResponseBuilder toBuilder() =>
      AdminGroupPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminGroupPageResponse &&
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
    return (newBuiltValueToStringHelper(r'AdminGroupPageResponse')
          ..add('list', list)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class AdminGroupPageResponseBuilder
    implements Builder<AdminGroupPageResponse, AdminGroupPageResponseBuilder> {
  _$AdminGroupPageResponse? _$v;

  ListBuilder<GroupResponse>? _list;
  ListBuilder<GroupResponse> get list =>
      _$this._list ??= ListBuilder<GroupResponse>();
  set list(ListBuilder<GroupResponse>? list) => _$this._list = list;

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

  AdminGroupPageResponseBuilder() {
    AdminGroupPageResponse._defaults(this);
  }

  AdminGroupPageResponseBuilder get _$this {
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
  void replace(AdminGroupPageResponse other) {
    _$v = other as _$AdminGroupPageResponse;
  }

  @override
  void update(void Function(AdminGroupPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AdminGroupPageResponse build() => _build();

  _$AdminGroupPageResponse _build() {
    _$AdminGroupPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$AdminGroupPageResponse._(
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
          r'AdminGroupPageResponse',
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
