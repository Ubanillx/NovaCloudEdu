// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeedbackDetailResponse extends FeedbackDetailResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final String? feedbackType;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? attachment;
  @override
  final int? status;
  @override
  final String? statusDesc;
  @override
  final int? adminId;
  @override
  final DateTime? processTime;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final BuiltList<FeedbackReplyResponse>? replies;

  factory _$FeedbackDetailResponse([
    void Function(FeedbackDetailResponseBuilder)? updates,
  ]) => (FeedbackDetailResponseBuilder()..update(updates))._build();

  _$FeedbackDetailResponse._({
    this.id,
    this.userId,
    this.feedbackType,
    this.title,
    this.content,
    this.attachment,
    this.status,
    this.statusDesc,
    this.adminId,
    this.processTime,
    this.createTime,
    this.updateTime,
    this.replies,
  }) : super._();
  @override
  FeedbackDetailResponse rebuild(
    void Function(FeedbackDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FeedbackDetailResponseBuilder toBuilder() =>
      FeedbackDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedbackDetailResponse &&
        id == other.id &&
        userId == other.userId &&
        feedbackType == other.feedbackType &&
        title == other.title &&
        content == other.content &&
        attachment == other.attachment &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        adminId == other.adminId &&
        processTime == other.processTime &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        replies == other.replies;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, feedbackType.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, attachment.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, adminId.hashCode);
    _$hash = $jc(_$hash, processTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, replies.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeedbackDetailResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('feedbackType', feedbackType)
          ..add('title', title)
          ..add('content', content)
          ..add('attachment', attachment)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('adminId', adminId)
          ..add('processTime', processTime)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('replies', replies))
        .toString();
  }
}

class FeedbackDetailResponseBuilder
    implements Builder<FeedbackDetailResponse, FeedbackDetailResponseBuilder> {
  _$FeedbackDetailResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _feedbackType;
  String? get feedbackType => _$this._feedbackType;
  set feedbackType(String? feedbackType) => _$this._feedbackType = feedbackType;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _attachment;
  String? get attachment => _$this._attachment;
  set attachment(String? attachment) => _$this._attachment = attachment;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _statusDesc;
  String? get statusDesc => _$this._statusDesc;
  set statusDesc(String? statusDesc) => _$this._statusDesc = statusDesc;

  int? _adminId;
  int? get adminId => _$this._adminId;
  set adminId(int? adminId) => _$this._adminId = adminId;

  DateTime? _processTime;
  DateTime? get processTime => _$this._processTime;
  set processTime(DateTime? processTime) => _$this._processTime = processTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ListBuilder<FeedbackReplyResponse>? _replies;
  ListBuilder<FeedbackReplyResponse> get replies =>
      _$this._replies ??= ListBuilder<FeedbackReplyResponse>();
  set replies(ListBuilder<FeedbackReplyResponse>? replies) =>
      _$this._replies = replies;

  FeedbackDetailResponseBuilder() {
    FeedbackDetailResponse._defaults(this);
  }

  FeedbackDetailResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _feedbackType = $v.feedbackType;
      _title = $v.title;
      _content = $v.content;
      _attachment = $v.attachment;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _adminId = $v.adminId;
      _processTime = $v.processTime;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _replies = $v.replies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedbackDetailResponse other) {
    _$v = other as _$FeedbackDetailResponse;
  }

  @override
  void update(void Function(FeedbackDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeedbackDetailResponse build() => _build();

  _$FeedbackDetailResponse _build() {
    _$FeedbackDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$FeedbackDetailResponse._(
            id: id,
            userId: userId,
            feedbackType: feedbackType,
            title: title,
            content: content,
            attachment: attachment,
            status: status,
            statusDesc: statusDesc,
            adminId: adminId,
            processTime: processTime,
            createTime: createTime,
            updateTime: updateTime,
            replies: _replies?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'replies';
        _replies?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FeedbackDetailResponse',
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
