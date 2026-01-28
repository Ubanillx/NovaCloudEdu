// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelf_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserShelfDTO extends UserShelfDTO {
  @override
  final int? userId;
  @override
  final int? bookId;
  @override
  final String? bookTitle;
  @override
  final String? bookAuthor;
  @override
  final String? bookCoverUrl;
  @override
  final int? lastChapterIndex;
  @override
  final int? lastPosition;
  @override
  final num? readingProgress;
  @override
  final DateTime? addedTime;
  @override
  final DateTime? lastReadTime;

  factory _$UserShelfDTO([void Function(UserShelfDTOBuilder)? updates]) =>
      (UserShelfDTOBuilder()..update(updates))._build();

  _$UserShelfDTO._({
    this.userId,
    this.bookId,
    this.bookTitle,
    this.bookAuthor,
    this.bookCoverUrl,
    this.lastChapterIndex,
    this.lastPosition,
    this.readingProgress,
    this.addedTime,
    this.lastReadTime,
  }) : super._();
  @override
  UserShelfDTO rebuild(void Function(UserShelfDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserShelfDTOBuilder toBuilder() => UserShelfDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserShelfDTO &&
        userId == other.userId &&
        bookId == other.bookId &&
        bookTitle == other.bookTitle &&
        bookAuthor == other.bookAuthor &&
        bookCoverUrl == other.bookCoverUrl &&
        lastChapterIndex == other.lastChapterIndex &&
        lastPosition == other.lastPosition &&
        readingProgress == other.readingProgress &&
        addedTime == other.addedTime &&
        lastReadTime == other.lastReadTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, bookTitle.hashCode);
    _$hash = $jc(_$hash, bookAuthor.hashCode);
    _$hash = $jc(_$hash, bookCoverUrl.hashCode);
    _$hash = $jc(_$hash, lastChapterIndex.hashCode);
    _$hash = $jc(_$hash, lastPosition.hashCode);
    _$hash = $jc(_$hash, readingProgress.hashCode);
    _$hash = $jc(_$hash, addedTime.hashCode);
    _$hash = $jc(_$hash, lastReadTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserShelfDTO')
          ..add('userId', userId)
          ..add('bookId', bookId)
          ..add('bookTitle', bookTitle)
          ..add('bookAuthor', bookAuthor)
          ..add('bookCoverUrl', bookCoverUrl)
          ..add('lastChapterIndex', lastChapterIndex)
          ..add('lastPosition', lastPosition)
          ..add('readingProgress', readingProgress)
          ..add('addedTime', addedTime)
          ..add('lastReadTime', lastReadTime))
        .toString();
  }
}

class UserShelfDTOBuilder
    implements Builder<UserShelfDTO, UserShelfDTOBuilder> {
  _$UserShelfDTO? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _bookId;
  int? get bookId => _$this._bookId;
  set bookId(int? bookId) => _$this._bookId = bookId;

  String? _bookTitle;
  String? get bookTitle => _$this._bookTitle;
  set bookTitle(String? bookTitle) => _$this._bookTitle = bookTitle;

  String? _bookAuthor;
  String? get bookAuthor => _$this._bookAuthor;
  set bookAuthor(String? bookAuthor) => _$this._bookAuthor = bookAuthor;

  String? _bookCoverUrl;
  String? get bookCoverUrl => _$this._bookCoverUrl;
  set bookCoverUrl(String? bookCoverUrl) => _$this._bookCoverUrl = bookCoverUrl;

  int? _lastChapterIndex;
  int? get lastChapterIndex => _$this._lastChapterIndex;
  set lastChapterIndex(int? lastChapterIndex) =>
      _$this._lastChapterIndex = lastChapterIndex;

  int? _lastPosition;
  int? get lastPosition => _$this._lastPosition;
  set lastPosition(int? lastPosition) => _$this._lastPosition = lastPosition;

  num? _readingProgress;
  num? get readingProgress => _$this._readingProgress;
  set readingProgress(num? readingProgress) =>
      _$this._readingProgress = readingProgress;

  DateTime? _addedTime;
  DateTime? get addedTime => _$this._addedTime;
  set addedTime(DateTime? addedTime) => _$this._addedTime = addedTime;

  DateTime? _lastReadTime;
  DateTime? get lastReadTime => _$this._lastReadTime;
  set lastReadTime(DateTime? lastReadTime) =>
      _$this._lastReadTime = lastReadTime;

  UserShelfDTOBuilder() {
    UserShelfDTO._defaults(this);
  }

  UserShelfDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _bookId = $v.bookId;
      _bookTitle = $v.bookTitle;
      _bookAuthor = $v.bookAuthor;
      _bookCoverUrl = $v.bookCoverUrl;
      _lastChapterIndex = $v.lastChapterIndex;
      _lastPosition = $v.lastPosition;
      _readingProgress = $v.readingProgress;
      _addedTime = $v.addedTime;
      _lastReadTime = $v.lastReadTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserShelfDTO other) {
    _$v = other as _$UserShelfDTO;
  }

  @override
  void update(void Function(UserShelfDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserShelfDTO build() => _build();

  _$UserShelfDTO _build() {
    final _$result =
        _$v ??
        _$UserShelfDTO._(
          userId: userId,
          bookId: bookId,
          bookTitle: bookTitle,
          bookAuthor: bookAuthor,
          bookCoverUrl: bookCoverUrl,
          lastChapterIndex: lastChapterIndex,
          lastPosition: lastPosition,
          readingProgress: readingProgress,
          addedTime: addedTime,
          lastReadTime: lastReadTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
