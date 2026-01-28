// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReplyResponse extends ReplyResponse {
  @override
  final int? id;
  @override
  final int? postId;
  @override
  final int? commentId;
  @override
  final int? userId;
  @override
  final String? content;
  @override
  final String? ipAddress;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ReplyResponse([void Function(ReplyResponseBuilder)? updates]) =>
      (ReplyResponseBuilder()..update(updates))._build();

  _$ReplyResponse._({
    this.id,
    this.postId,
    this.commentId,
    this.userId,
    this.content,
    this.ipAddress,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ReplyResponse rebuild(void Function(ReplyResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReplyResponseBuilder toBuilder() => ReplyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReplyResponse &&
        id == other.id &&
        postId == other.postId &&
        commentId == other.commentId &&
        userId == other.userId &&
        content == other.content &&
        ipAddress == other.ipAddress &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, postId.hashCode);
    _$hash = $jc(_$hash, commentId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReplyResponse')
          ..add('id', id)
          ..add('postId', postId)
          ..add('commentId', commentId)
          ..add('userId', userId)
          ..add('content', content)
          ..add('ipAddress', ipAddress)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ReplyResponseBuilder
    implements Builder<ReplyResponse, ReplyResponseBuilder> {
  _$ReplyResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _postId;
  int? get postId => _$this._postId;
  set postId(int? postId) => _$this._postId = postId;

  int? _commentId;
  int? get commentId => _$this._commentId;
  set commentId(int? commentId) => _$this._commentId = commentId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ReplyResponseBuilder() {
    ReplyResponse._defaults(this);
  }

  ReplyResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _postId = $v.postId;
      _commentId = $v.commentId;
      _userId = $v.userId;
      _content = $v.content;
      _ipAddress = $v.ipAddress;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReplyResponse other) {
    _$v = other as _$ReplyResponse;
  }

  @override
  void update(void Function(ReplyResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReplyResponse build() => _build();

  _$ReplyResponse _build() {
    final _$result =
        _$v ??
        _$ReplyResponse._(
          id: id,
          postId: postId,
          commentId: commentId,
          userId: userId,
          content: content,
          ipAddress: ipAddress,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
