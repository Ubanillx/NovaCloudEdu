// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueryUserRequest extends QueryUserRequest {
  @override
  final String? userName;
  @override
  final String? userAccount;
  @override
  final String? userPhone;
  @override
  final String? userEmail;
  @override
  final String? role;
  @override
  final bool? banned;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$QueryUserRequest(
          [void Function(QueryUserRequestBuilder)? updates]) =>
      (QueryUserRequestBuilder()..update(updates))._build();

  _$QueryUserRequest._(
      {this.userName,
      this.userAccount,
      this.userPhone,
      this.userEmail,
      this.role,
      this.banned,
      this.pageNum,
      this.pageSize})
      : super._();
  @override
  QueryUserRequest rebuild(void Function(QueryUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueryUserRequestBuilder toBuilder() =>
      QueryUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryUserRequest &&
        userName == other.userName &&
        userAccount == other.userAccount &&
        userPhone == other.userPhone &&
        userEmail == other.userEmail &&
        role == other.role &&
        banned == other.banned &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userPhone.hashCode);
    _$hash = $jc(_$hash, userEmail.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, banned.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueryUserRequest')
          ..add('userName', userName)
          ..add('userAccount', userAccount)
          ..add('userPhone', userPhone)
          ..add('userEmail', userEmail)
          ..add('role', role)
          ..add('banned', banned)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class QueryUserRequestBuilder
    implements Builder<QueryUserRequest, QueryUserRequestBuilder> {
  _$QueryUserRequest? _$v;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAccount;
  String? get userAccount => _$this._userAccount;
  set userAccount(String? userAccount) => _$this._userAccount = userAccount;

  String? _userPhone;
  String? get userPhone => _$this._userPhone;
  set userPhone(String? userPhone) => _$this._userPhone = userPhone;

  String? _userEmail;
  String? get userEmail => _$this._userEmail;
  set userEmail(String? userEmail) => _$this._userEmail = userEmail;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  bool? _banned;
  bool? get banned => _$this._banned;
  set banned(bool? banned) => _$this._banned = banned;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  QueryUserRequestBuilder() {
    QueryUserRequest._defaults(this);
  }

  QueryUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userName = $v.userName;
      _userAccount = $v.userAccount;
      _userPhone = $v.userPhone;
      _userEmail = $v.userEmail;
      _role = $v.role;
      _banned = $v.banned;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryUserRequest other) {
    _$v = other as _$QueryUserRequest;
  }

  @override
  void update(void Function(QueryUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueryUserRequest build() => _build();

  _$QueryUserRequest _build() {
    final _$result = _$v ??
        _$QueryUserRequest._(
          userName: userName,
          userAccount: userAccount,
          userPhone: userPhone,
          userEmail: userEmail,
          role: role,
          banned: banned,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
