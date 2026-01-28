// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_application_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewApplicationRequest extends ReviewApplicationRequest {
  @override
  final int applicationId;
  @override
  final bool approved;
  @override
  final String? rejectReason;

  factory _$ReviewApplicationRequest([
    void Function(ReviewApplicationRequestBuilder)? updates,
  ]) => (ReviewApplicationRequestBuilder()..update(updates))._build();

  _$ReviewApplicationRequest._({
    required this.applicationId,
    required this.approved,
    this.rejectReason,
  }) : super._();
  @override
  ReviewApplicationRequest rebuild(
    void Function(ReviewApplicationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewApplicationRequestBuilder toBuilder() =>
      ReviewApplicationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewApplicationRequest &&
        applicationId == other.applicationId &&
        approved == other.approved &&
        rejectReason == other.rejectReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, applicationId.hashCode);
    _$hash = $jc(_$hash, approved.hashCode);
    _$hash = $jc(_$hash, rejectReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewApplicationRequest')
          ..add('applicationId', applicationId)
          ..add('approved', approved)
          ..add('rejectReason', rejectReason))
        .toString();
  }
}

class ReviewApplicationRequestBuilder
    implements
        Builder<ReviewApplicationRequest, ReviewApplicationRequestBuilder> {
  _$ReviewApplicationRequest? _$v;

  int? _applicationId;
  int? get applicationId => _$this._applicationId;
  set applicationId(int? applicationId) =>
      _$this._applicationId = applicationId;

  bool? _approved;
  bool? get approved => _$this._approved;
  set approved(bool? approved) => _$this._approved = approved;

  String? _rejectReason;
  String? get rejectReason => _$this._rejectReason;
  set rejectReason(String? rejectReason) => _$this._rejectReason = rejectReason;

  ReviewApplicationRequestBuilder() {
    ReviewApplicationRequest._defaults(this);
  }

  ReviewApplicationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _applicationId = $v.applicationId;
      _approved = $v.approved;
      _rejectReason = $v.rejectReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewApplicationRequest other) {
    _$v = other as _$ReviewApplicationRequest;
  }

  @override
  void update(void Function(ReviewApplicationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewApplicationRequest build() => _build();

  _$ReviewApplicationRequest _build() {
    final _$result =
        _$v ??
        _$ReviewApplicationRequest._(
          applicationId: BuiltValueNullFieldError.checkNotNull(
            applicationId,
            r'ReviewApplicationRequest',
            'applicationId',
          ),
          approved: BuiltValueNullFieldError.checkNotNull(
            approved,
            r'ReviewApplicationRequest',
            'approved',
          ),
          rejectReason: rejectReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
