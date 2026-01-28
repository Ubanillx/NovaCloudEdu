// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_reply_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeedbackReplyResponse extends FeedbackReplyResponse {
  @override
  final int? id;
  @override
  final int? feedbackId;
  @override
  final int? senderId;
  @override
  final int? senderRole;
  @override
  final String? senderRoleDesc;
  @override
  final String? content;
  @override
  final String? attachment;
  @override
  final bool? isRead;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$FeedbackReplyResponse([
    void Function(FeedbackReplyResponseBuilder)? updates,
  ]) => (FeedbackReplyResponseBuilder()..update(updates))._build();

  _$FeedbackReplyResponse._({
    this.id,
    this.feedbackId,
    this.senderId,
    this.senderRole,
    this.senderRoleDesc,
    this.content,
    this.attachment,
    this.isRead,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  FeedbackReplyResponse rebuild(
    void Function(FeedbackReplyResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FeedbackReplyResponseBuilder toBuilder() =>
      FeedbackReplyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedbackReplyResponse &&
        id == other.id &&
        feedbackId == other.feedbackId &&
        senderId == other.senderId &&
        senderRole == other.senderRole &&
        senderRoleDesc == other.senderRoleDesc &&
        content == other.content &&
        attachment == other.attachment &&
        isRead == other.isRead &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, feedbackId.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, senderRole.hashCode);
    _$hash = $jc(_$hash, senderRoleDesc.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, attachment.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeedbackReplyResponse')
          ..add('id', id)
          ..add('feedbackId', feedbackId)
          ..add('senderId', senderId)
          ..add('senderRole', senderRole)
          ..add('senderRoleDesc', senderRoleDesc)
          ..add('content', content)
          ..add('attachment', attachment)
          ..add('isRead', isRead)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class FeedbackReplyResponseBuilder
    implements Builder<FeedbackReplyResponse, FeedbackReplyResponseBuilder> {
  _$FeedbackReplyResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _feedbackId;
  int? get feedbackId => _$this._feedbackId;
  set feedbackId(int? feedbackId) => _$this._feedbackId = feedbackId;

  int? _senderId;
  int? get senderId => _$this._senderId;
  set senderId(int? senderId) => _$this._senderId = senderId;

  int? _senderRole;
  int? get senderRole => _$this._senderRole;
  set senderRole(int? senderRole) => _$this._senderRole = senderRole;

  String? _senderRoleDesc;
  String? get senderRoleDesc => _$this._senderRoleDesc;
  set senderRoleDesc(String? senderRoleDesc) =>
      _$this._senderRoleDesc = senderRoleDesc;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _attachment;
  String? get attachment => _$this._attachment;
  set attachment(String? attachment) => _$this._attachment = attachment;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  FeedbackReplyResponseBuilder() {
    FeedbackReplyResponse._defaults(this);
  }

  FeedbackReplyResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _feedbackId = $v.feedbackId;
      _senderId = $v.senderId;
      _senderRole = $v.senderRole;
      _senderRoleDesc = $v.senderRoleDesc;
      _content = $v.content;
      _attachment = $v.attachment;
      _isRead = $v.isRead;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedbackReplyResponse other) {
    _$v = other as _$FeedbackReplyResponse;
  }

  @override
  void update(void Function(FeedbackReplyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeedbackReplyResponse build() => _build();

  _$FeedbackReplyResponse _build() {
    final _$result =
        _$v ??
        _$FeedbackReplyResponse._(
          id: id,
          feedbackId: feedbackId,
          senderId: senderId,
          senderRole: senderRole,
          senderRoleDesc: senderRoleDesc,
          content: content,
          attachment: attachment,
          isRead: isRead,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
