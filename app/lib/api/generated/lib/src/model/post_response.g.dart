// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PostResponse extends PostResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final BuiltList<String>? tags;
  @override
  final int? thumbNum;
  @override
  final int? favourNum;
  @override
  final int? commentNum;
  @override
  final int? userId;
  @override
  final String? ipAddress;
  @override
  final String? postType;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$PostResponse([void Function(PostResponseBuilder)? updates]) =>
      (PostResponseBuilder()..update(updates))._build();

  _$PostResponse._({
    this.id,
    this.title,
    this.content,
    this.tags,
    this.thumbNum,
    this.favourNum,
    this.commentNum,
    this.userId,
    this.ipAddress,
    this.postType,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  PostResponse rebuild(void Function(PostResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PostResponseBuilder toBuilder() => PostResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostResponse &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        tags == other.tags &&
        thumbNum == other.thumbNum &&
        favourNum == other.favourNum &&
        commentNum == other.commentNum &&
        userId == other.userId &&
        ipAddress == other.ipAddress &&
        postType == other.postType &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, thumbNum.hashCode);
    _$hash = $jc(_$hash, favourNum.hashCode);
    _$hash = $jc(_$hash, commentNum.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, postType.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PostResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('tags', tags)
          ..add('thumbNum', thumbNum)
          ..add('favourNum', favourNum)
          ..add('commentNum', commentNum)
          ..add('userId', userId)
          ..add('ipAddress', ipAddress)
          ..add('postType', postType)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class PostResponseBuilder
    implements Builder<PostResponse, PostResponseBuilder> {
  _$PostResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  int? _thumbNum;
  int? get thumbNum => _$this._thumbNum;
  set thumbNum(int? thumbNum) => _$this._thumbNum = thumbNum;

  int? _favourNum;
  int? get favourNum => _$this._favourNum;
  set favourNum(int? favourNum) => _$this._favourNum = favourNum;

  int? _commentNum;
  int? get commentNum => _$this._commentNum;
  set commentNum(int? commentNum) => _$this._commentNum = commentNum;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  String? _postType;
  String? get postType => _$this._postType;
  set postType(String? postType) => _$this._postType = postType;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  PostResponseBuilder() {
    PostResponse._defaults(this);
  }

  PostResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _content = $v.content;
      _tags = $v.tags?.toBuilder();
      _thumbNum = $v.thumbNum;
      _favourNum = $v.favourNum;
      _commentNum = $v.commentNum;
      _userId = $v.userId;
      _ipAddress = $v.ipAddress;
      _postType = $v.postType;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostResponse other) {
    _$v = other as _$PostResponse;
  }

  @override
  void update(void Function(PostResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PostResponse build() => _build();

  _$PostResponse _build() {
    _$PostResponse _$result;
    try {
      _$result =
          _$v ??
          _$PostResponse._(
            id: id,
            title: title,
            content: content,
            tags: _tags?.build(),
            thumbNum: thumbNum,
            favourNum: favourNum,
            commentNum: commentNum,
            userId: userId,
            ipAddress: ipAddress,
            postType: postType,
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PostResponse',
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
