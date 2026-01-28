// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MemberPage extends MemberPage {
  @override
  final BuiltList<ChatGroupMember>? members;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$MemberPage([void Function(MemberPageBuilder)? updates]) =>
      (MemberPageBuilder()..update(updates))._build();

  _$MemberPage._({
    this.members,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  MemberPage rebuild(void Function(MemberPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MemberPageBuilder toBuilder() => MemberPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MemberPage &&
        members == other.members &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, members.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MemberPage')
          ..add('members', members)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class MemberPageBuilder implements Builder<MemberPage, MemberPageBuilder> {
  _$MemberPage? _$v;

  ListBuilder<ChatGroupMember>? _members;
  ListBuilder<ChatGroupMember> get members =>
      _$this._members ??= ListBuilder<ChatGroupMember>();
  set members(ListBuilder<ChatGroupMember>? members) =>
      _$this._members = members;

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

  MemberPageBuilder() {
    MemberPage._defaults(this);
  }

  MemberPageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _members = $v.members?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MemberPage other) {
    _$v = other as _$MemberPage;
  }

  @override
  void update(void Function(MemberPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MemberPage build() => _build();

  _$MemberPage _build() {
    _$MemberPage _$result;
    try {
      _$result =
          _$v ??
          _$MemberPage._(
            members: _members?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'members';
        _members?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MemberPage',
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
