// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grant_membership_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GrantMembershipRequest extends GrantMembershipRequest {
  @override
  final int userId;
  @override
  final int planId;

  factory _$GrantMembershipRequest([
    void Function(GrantMembershipRequestBuilder)? updates,
  ]) => (GrantMembershipRequestBuilder()..update(updates))._build();

  _$GrantMembershipRequest._({required this.userId, required this.planId})
    : super._();
  @override
  GrantMembershipRequest rebuild(
    void Function(GrantMembershipRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GrantMembershipRequestBuilder toBuilder() =>
      GrantMembershipRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GrantMembershipRequest &&
        userId == other.userId &&
        planId == other.planId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GrantMembershipRequest')
          ..add('userId', userId)
          ..add('planId', planId))
        .toString();
  }
}

class GrantMembershipRequestBuilder
    implements Builder<GrantMembershipRequest, GrantMembershipRequestBuilder> {
  _$GrantMembershipRequest? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _planId;
  int? get planId => _$this._planId;
  set planId(int? planId) => _$this._planId = planId;

  GrantMembershipRequestBuilder() {
    GrantMembershipRequest._defaults(this);
  }

  GrantMembershipRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _planId = $v.planId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GrantMembershipRequest other) {
    _$v = other as _$GrantMembershipRequest;
  }

  @override
  void update(void Function(GrantMembershipRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GrantMembershipRequest build() => _build();

  _$GrantMembershipRequest _build() {
    final _$result =
        _$v ??
        _$GrantMembershipRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'GrantMembershipRequest',
            'userId',
          ),
          planId: BuiltValueNullFieldError.checkNotNull(
            planId,
            r'GrantMembershipRequest',
            'planId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
