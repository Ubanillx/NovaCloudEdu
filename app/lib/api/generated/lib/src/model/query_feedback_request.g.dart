// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_feedback_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueryFeedbackRequest extends QueryFeedbackRequest {
  @override
  final int? userId;
  @override
  final String? feedbackType;
  @override
  final int? status;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$QueryFeedbackRequest([
    void Function(QueryFeedbackRequestBuilder)? updates,
  ]) => (QueryFeedbackRequestBuilder()..update(updates))._build();

  _$QueryFeedbackRequest._({
    this.userId,
    this.feedbackType,
    this.status,
    this.pageNum,
    this.pageSize,
  }) : super._();
  @override
  QueryFeedbackRequest rebuild(
    void Function(QueryFeedbackRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  QueryFeedbackRequestBuilder toBuilder() =>
      QueryFeedbackRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryFeedbackRequest &&
        userId == other.userId &&
        feedbackType == other.feedbackType &&
        status == other.status &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, feedbackType.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueryFeedbackRequest')
          ..add('userId', userId)
          ..add('feedbackType', feedbackType)
          ..add('status', status)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class QueryFeedbackRequestBuilder
    implements Builder<QueryFeedbackRequest, QueryFeedbackRequestBuilder> {
  _$QueryFeedbackRequest? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _feedbackType;
  String? get feedbackType => _$this._feedbackType;
  set feedbackType(String? feedbackType) => _$this._feedbackType = feedbackType;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  QueryFeedbackRequestBuilder() {
    QueryFeedbackRequest._defaults(this);
  }

  QueryFeedbackRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _feedbackType = $v.feedbackType;
      _status = $v.status;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryFeedbackRequest other) {
    _$v = other as _$QueryFeedbackRequest;
  }

  @override
  void update(void Function(QueryFeedbackRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueryFeedbackRequest build() => _build();

  _$QueryFeedbackRequest _build() {
    final _$result =
        _$v ??
        _$QueryFeedbackRequest._(
          userId: userId,
          feedbackType: feedbackType,
          status: status,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
