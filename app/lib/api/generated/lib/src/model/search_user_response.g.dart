// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchUserResponse extends SearchUserResponse {
  @override
  final int? userId;
  @override
  final String? userAccount;
  @override
  final String? userName;
  @override
  final String? userAvatar;
  @override
  final String? userProfile;
  @override
  final bool? isFriend;
  @override
  final bool? hasPendingRequest;

  factory _$SearchUserResponse([
    void Function(SearchUserResponseBuilder)? updates,
  ]) => (SearchUserResponseBuilder()..update(updates))._build();

  _$SearchUserResponse._({
    this.userId,
    this.userAccount,
    this.userName,
    this.userAvatar,
    this.userProfile,
    this.isFriend,
    this.hasPendingRequest,
  }) : super._();
  @override
  SearchUserResponse rebuild(
    void Function(SearchUserResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SearchUserResponseBuilder toBuilder() =>
      SearchUserResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchUserResponse &&
        userId == other.userId &&
        userAccount == other.userAccount &&
        userName == other.userName &&
        userAvatar == other.userAvatar &&
        userProfile == other.userProfile &&
        isFriend == other.isFriend &&
        hasPendingRequest == other.hasPendingRequest;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userAccount.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userAvatar.hashCode);
    _$hash = $jc(_$hash, userProfile.hashCode);
    _$hash = $jc(_$hash, isFriend.hashCode);
    _$hash = $jc(_$hash, hasPendingRequest.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchUserResponse')
          ..add('userId', userId)
          ..add('userAccount', userAccount)
          ..add('userName', userName)
          ..add('userAvatar', userAvatar)
          ..add('userProfile', userProfile)
          ..add('isFriend', isFriend)
          ..add('hasPendingRequest', hasPendingRequest))
        .toString();
  }
}

class SearchUserResponseBuilder
    implements Builder<SearchUserResponse, SearchUserResponseBuilder> {
  _$SearchUserResponse? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _userAccount;
  String? get userAccount => _$this._userAccount;
  set userAccount(String? userAccount) => _$this._userAccount = userAccount;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userAvatar;
  String? get userAvatar => _$this._userAvatar;
  set userAvatar(String? userAvatar) => _$this._userAvatar = userAvatar;

  String? _userProfile;
  String? get userProfile => _$this._userProfile;
  set userProfile(String? userProfile) => _$this._userProfile = userProfile;

  bool? _isFriend;
  bool? get isFriend => _$this._isFriend;
  set isFriend(bool? isFriend) => _$this._isFriend = isFriend;

  bool? _hasPendingRequest;
  bool? get hasPendingRequest => _$this._hasPendingRequest;
  set hasPendingRequest(bool? hasPendingRequest) =>
      _$this._hasPendingRequest = hasPendingRequest;

  SearchUserResponseBuilder() {
    SearchUserResponse._defaults(this);
  }

  SearchUserResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _userAccount = $v.userAccount;
      _userName = $v.userName;
      _userAvatar = $v.userAvatar;
      _userProfile = $v.userProfile;
      _isFriend = $v.isFriend;
      _hasPendingRequest = $v.hasPendingRequest;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchUserResponse other) {
    _$v = other as _$SearchUserResponse;
  }

  @override
  void update(void Function(SearchUserResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchUserResponse build() => _build();

  _$SearchUserResponse _build() {
    final _$result =
        _$v ??
        _$SearchUserResponse._(
          userId: userId,
          userAccount: userAccount,
          userName: userName,
          userAvatar: userAvatar,
          userProfile: userProfile,
          isFriend: isFriend,
          hasPendingRequest: hasPendingRequest,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
