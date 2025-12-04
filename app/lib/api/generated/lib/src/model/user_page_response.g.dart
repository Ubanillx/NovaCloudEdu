// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserPageResponse extends UserPageResponse {
  @override
  final BuiltList<UserDetailResponse>? users;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$UserPageResponse(
          [void Function(UserPageResponseBuilder)? updates]) =>
      (UserPageResponseBuilder()..update(updates))._build();

  _$UserPageResponse._(
      {this.users, this.total, this.pageNum, this.pageSize, this.totalPages})
      : super._();
  @override
  UserPageResponse rebuild(void Function(UserPageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserPageResponseBuilder toBuilder() =>
      UserPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserPageResponse &&
        users == other.users &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserPageResponse')
          ..add('users', users)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class UserPageResponseBuilder
    implements Builder<UserPageResponse, UserPageResponseBuilder> {
  _$UserPageResponse? _$v;

  ListBuilder<UserDetailResponse>? _users;
  ListBuilder<UserDetailResponse> get users =>
      _$this._users ??= ListBuilder<UserDetailResponse>();
  set users(ListBuilder<UserDetailResponse>? users) => _$this._users = users;

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

  UserPageResponseBuilder() {
    UserPageResponse._defaults(this);
  }

  UserPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _users = $v.users?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserPageResponse other) {
    _$v = other as _$UserPageResponse;
  }

  @override
  void update(void Function(UserPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserPageResponse build() => _build();

  _$UserPageResponse _build() {
    _$UserPageResponse _$result;
    try {
      _$result = _$v ??
          _$UserPageResponse._(
            users: _users?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        _users?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UserPageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
