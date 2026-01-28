// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommentResponse extends CommentResponse {
  @override
  final int? id;
  @override
  final int? postId;
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

  factory _$CommentResponse([void Function(CommentResponseBuilder)? updates]) =>
      (CommentResponseBuilder()..update(updates))._build();

  _$CommentResponse._({
    this.id,
    this.postId,
    this.userId,
    this.content,
    this.ipAddress,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  CommentResponse rebuild(void Function(CommentResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentResponseBuilder toBuilder() => CommentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentResponse &&
        id == other.id &&
        postId == other.postId &&
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
    return (newBuiltValueToStringHelper(r'CommentResponse')
          ..add('id', id)
          ..add('postId', postId)
          ..add('userId', userId)
          ..add('content', content)
          ..add('ipAddress', ipAddress)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class CommentResponseBuilder
    implements Builder<CommentResponse, CommentResponseBuilder> {
  _$CommentResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _postId;
  int? get postId => _$this._postId;
  set postId(int? postId) => _$this._postId = postId;

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

  CommentResponseBuilder() {
    CommentResponse._defaults(this);
  }

  CommentResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _postId = $v.postId;
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
  void replace(CommentResponse other) {
    _$v = other as _$CommentResponse;
  }

  @override
  void update(void Function(CommentResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommentResponse build() => _build();

  _$CommentResponse _build() {
    final _$result =
        _$v ??
        _$CommentResponse._(
          id: id,
          postId: postId,
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
