// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_membership_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PurchaseMembershipRequest extends PurchaseMembershipRequest {
  @override
  final int planId;

  factory _$PurchaseMembershipRequest([
    void Function(PurchaseMembershipRequestBuilder)? updates,
  ]) => (PurchaseMembershipRequestBuilder()..update(updates))._build();

  _$PurchaseMembershipRequest._({required this.planId}) : super._();
  @override
  PurchaseMembershipRequest rebuild(
    void Function(PurchaseMembershipRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PurchaseMembershipRequestBuilder toBuilder() =>
      PurchaseMembershipRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PurchaseMembershipRequest && planId == other.planId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'PurchaseMembershipRequest',
    )..add('planId', planId)).toString();
  }
}

class PurchaseMembershipRequestBuilder
    implements
        Builder<PurchaseMembershipRequest, PurchaseMembershipRequestBuilder> {
  _$PurchaseMembershipRequest? _$v;

  int? _planId;
  int? get planId => _$this._planId;
  set planId(int? planId) => _$this._planId = planId;

  PurchaseMembershipRequestBuilder() {
    PurchaseMembershipRequest._defaults(this);
  }

  PurchaseMembershipRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _planId = $v.planId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PurchaseMembershipRequest other) {
    _$v = other as _$PurchaseMembershipRequest;
  }

  @override
  void update(void Function(PurchaseMembershipRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PurchaseMembershipRequest build() => _build();

  _$PurchaseMembershipRequest _build() {
    final _$result =
        _$v ??
        _$PurchaseMembershipRequest._(
          planId: BuiltValueNullFieldError.checkNotNull(
            planId,
            r'PurchaseMembershipRequest',
            'planId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
