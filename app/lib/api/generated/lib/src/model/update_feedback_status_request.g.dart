// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_feedback_status_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateFeedbackStatusRequest extends UpdateFeedbackStatusRequest {
  @override
  final int feedbackId;
  @override
  final int status;

  factory _$UpdateFeedbackStatusRequest([
    void Function(UpdateFeedbackStatusRequestBuilder)? updates,
  ]) => (UpdateFeedbackStatusRequestBuilder()..update(updates))._build();

  _$UpdateFeedbackStatusRequest._({
    required this.feedbackId,
    required this.status,
  }) : super._();
  @override
  UpdateFeedbackStatusRequest rebuild(
    void Function(UpdateFeedbackStatusRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateFeedbackStatusRequestBuilder toBuilder() =>
      UpdateFeedbackStatusRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateFeedbackStatusRequest &&
        feedbackId == other.feedbackId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feedbackId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateFeedbackStatusRequest')
          ..add('feedbackId', feedbackId)
          ..add('status', status))
        .toString();
  }
}

class UpdateFeedbackStatusRequestBuilder
    implements
        Builder<
          UpdateFeedbackStatusRequest,
          UpdateFeedbackStatusRequestBuilder
        > {
  _$UpdateFeedbackStatusRequest? _$v;

  int? _feedbackId;
  int? get feedbackId => _$this._feedbackId;
  set feedbackId(int? feedbackId) => _$this._feedbackId = feedbackId;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  UpdateFeedbackStatusRequestBuilder() {
    UpdateFeedbackStatusRequest._defaults(this);
  }

  UpdateFeedbackStatusRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feedbackId = $v.feedbackId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateFeedbackStatusRequest other) {
    _$v = other as _$UpdateFeedbackStatusRequest;
  }

  @override
  void update(void Function(UpdateFeedbackStatusRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateFeedbackStatusRequest build() => _build();

  _$UpdateFeedbackStatusRequest _build() {
    final _$result =
        _$v ??
        _$UpdateFeedbackStatusRequest._(
          feedbackId: BuiltValueNullFieldError.checkNotNull(
            feedbackId,
            r'UpdateFeedbackStatusRequest',
            'feedbackId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'UpdateFeedbackStatusRequest',
            'status',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
