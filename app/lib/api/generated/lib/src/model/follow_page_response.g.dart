// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FollowPageResponse extends FollowPageResponse {
  @override
  final BuiltList<FollowUserResponse>? users;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$FollowPageResponse([
    void Function(FollowPageResponseBuilder)? updates,
  ]) => (FollowPageResponseBuilder()..update(updates))._build();

  _$FollowPageResponse._({
    this.users,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  FollowPageResponse rebuild(
    void Function(FollowPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FollowPageResponseBuilder toBuilder() =>
      FollowPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowPageResponse &&
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
    return (newBuiltValueToStringHelper(r'FollowPageResponse')
          ..add('users', users)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class FollowPageResponseBuilder
    implements Builder<FollowPageResponse, FollowPageResponseBuilder> {
  _$FollowPageResponse? _$v;

  ListBuilder<FollowUserResponse>? _users;
  ListBuilder<FollowUserResponse> get users =>
      _$this._users ??= ListBuilder<FollowUserResponse>();
  set users(ListBuilder<FollowUserResponse>? users) => _$this._users = users;

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

  FollowPageResponseBuilder() {
    FollowPageResponse._defaults(this);
  }

  FollowPageResponseBuilder get _$this {
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
  void replace(FollowPageResponse other) {
    _$v = other as _$FollowPageResponse;
  }

  @override
  void update(void Function(FollowPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FollowPageResponse build() => _build();

  _$FollowPageResponse _build() {
    _$FollowPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$FollowPageResponse._(
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
          r'FollowPageResponse',
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
