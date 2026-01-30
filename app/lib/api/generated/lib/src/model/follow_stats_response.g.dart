// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_stats_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FollowStatsResponse extends FollowStatsResponse {
  @override
  final int? followingCount;
  @override
  final int? followerCount;

  factory _$FollowStatsResponse([
    void Function(FollowStatsResponseBuilder)? updates,
  ]) => (FollowStatsResponseBuilder()..update(updates))._build();

  _$FollowStatsResponse._({this.followingCount, this.followerCount})
    : super._();
  @override
  FollowStatsResponse rebuild(
    void Function(FollowStatsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FollowStatsResponseBuilder toBuilder() =>
      FollowStatsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowStatsResponse &&
        followingCount == other.followingCount &&
        followerCount == other.followerCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, followingCount.hashCode);
    _$hash = $jc(_$hash, followerCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FollowStatsResponse')
          ..add('followingCount', followingCount)
          ..add('followerCount', followerCount))
        .toString();
  }
}

class FollowStatsResponseBuilder
    implements Builder<FollowStatsResponse, FollowStatsResponseBuilder> {
  _$FollowStatsResponse? _$v;

  int? _followingCount;
  int? get followingCount => _$this._followingCount;
  set followingCount(int? followingCount) =>
      _$this._followingCount = followingCount;

  int? _followerCount;
  int? get followerCount => _$this._followerCount;
  set followerCount(int? followerCount) =>
      _$this._followerCount = followerCount;

  FollowStatsResponseBuilder() {
    FollowStatsResponse._defaults(this);
  }

  FollowStatsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _followingCount = $v.followingCount;
      _followerCount = $v.followerCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FollowStatsResponse other) {
    _$v = other as _$FollowStatsResponse;
  }

  @override
  void update(void Function(FollowStatsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FollowStatsResponse build() => _build();

  _$FollowStatsResponse _build() {
    final _$result =
        _$v ??
        _$FollowStatsResponse._(
          followingCount: followingCount,
          followerCount: followerCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
