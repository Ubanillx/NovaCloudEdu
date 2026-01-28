// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PostDetailResponse extends PostDetailResponse {
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
  @override
  final bool? hasThumb;
  @override
  final bool? hasFavour;

  factory _$PostDetailResponse([
    void Function(PostDetailResponseBuilder)? updates,
  ]) => (PostDetailResponseBuilder()..update(updates))._build();

  _$PostDetailResponse._({
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
    this.hasThumb,
    this.hasFavour,
  }) : super._();
  @override
  PostDetailResponse rebuild(
    void Function(PostDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PostDetailResponseBuilder toBuilder() =>
      PostDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PostDetailResponse &&
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
        updateTime == other.updateTime &&
        hasThumb == other.hasThumb &&
        hasFavour == other.hasFavour;
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
    _$hash = $jc(_$hash, hasThumb.hashCode);
    _$hash = $jc(_$hash, hasFavour.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PostDetailResponse')
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
          ..add('updateTime', updateTime)
          ..add('hasThumb', hasThumb)
          ..add('hasFavour', hasFavour))
        .toString();
  }
}

class PostDetailResponseBuilder
    implements Builder<PostDetailResponse, PostDetailResponseBuilder> {
  _$PostDetailResponse? _$v;

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

  bool? _hasThumb;
  bool? get hasThumb => _$this._hasThumb;
  set hasThumb(bool? hasThumb) => _$this._hasThumb = hasThumb;

  bool? _hasFavour;
  bool? get hasFavour => _$this._hasFavour;
  set hasFavour(bool? hasFavour) => _$this._hasFavour = hasFavour;

  PostDetailResponseBuilder() {
    PostDetailResponse._defaults(this);
  }

  PostDetailResponseBuilder get _$this {
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
      _hasThumb = $v.hasThumb;
      _hasFavour = $v.hasFavour;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PostDetailResponse other) {
    _$v = other as _$PostDetailResponse;
  }

  @override
  void update(void Function(PostDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PostDetailResponse build() => _build();

  _$PostDetailResponse _build() {
    _$PostDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$PostDetailResponse._(
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
            hasThumb: hasThumb,
            hasFavour: hasFavour,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PostDetailResponse',
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
