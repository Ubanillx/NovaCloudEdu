// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GroupPage extends GroupPage {
  @override
  final BuiltList<ChatGroup>? groups;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$GroupPage([void Function(GroupPageBuilder)? updates]) =>
      (GroupPageBuilder()..update(updates))._build();

  _$GroupPage._({
    this.groups,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  GroupPage rebuild(void Function(GroupPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupPageBuilder toBuilder() => GroupPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupPage &&
        groups == other.groups &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groups.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GroupPage')
          ..add('groups', groups)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class GroupPageBuilder implements Builder<GroupPage, GroupPageBuilder> {
  _$GroupPage? _$v;

  ListBuilder<ChatGroup>? _groups;
  ListBuilder<ChatGroup> get groups =>
      _$this._groups ??= ListBuilder<ChatGroup>();
  set groups(ListBuilder<ChatGroup>? groups) => _$this._groups = groups;

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

  GroupPageBuilder() {
    GroupPage._defaults(this);
  }

  GroupPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groups = $v.groups?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupPage other) {
    _$v = other as _$GroupPage;
  }

  @override
  void update(void Function(GroupPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupPage build() => _build();

  _$GroupPage _build() {
    _$GroupPage _$result;
    try {
      _$result =
          _$v ??
          _$GroupPage._(
            groups: _groups?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'groups';
        _groups?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GroupPage',
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
