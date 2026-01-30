// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_user_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FollowUserResponse extends FollowUserResponse {
  @override
  final int? userId;
  @override
  final DateTime? followTime;

  factory _$FollowUserResponse([
    void Function(FollowUserResponseBuilder)? updates,
  ]) => (FollowUserResponseBuilder()..update(updates))._build();

  _$FollowUserResponse._({this.userId, this.followTime}) : super._();
  @override
  FollowUserResponse rebuild(
    void Function(FollowUserResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FollowUserResponseBuilder toBuilder() =>
      FollowUserResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowUserResponse &&
        userId == other.userId &&
        followTime == other.followTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, followTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FollowUserResponse')
          ..add('userId', userId)
          ..add('followTime', followTime))
        .toString();
  }
}

class FollowUserResponseBuilder
    implements Builder<FollowUserResponse, FollowUserResponseBuilder> {
  _$FollowUserResponse? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  DateTime? _followTime;
  DateTime? get followTime => _$this._followTime;
  set followTime(DateTime? followTime) => _$this._followTime = followTime;

  FollowUserResponseBuilder() {
    FollowUserResponse._defaults(this);
  }

  FollowUserResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _followTime = $v.followTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FollowUserResponse other) {
    _$v = other as _$FollowUserResponse;
  }

  @override
  void update(void Function(FollowUserResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FollowUserResponse build() => _build();

  _$FollowUserResponse _build() {
    final _$result =
        _$v ?? _$FollowUserResponse._(userId: userId, followTime: followTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
