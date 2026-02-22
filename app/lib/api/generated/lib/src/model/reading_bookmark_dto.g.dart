// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_bookmark_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReadingBookmarkDTO extends ReadingBookmarkDTO {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? bookId;
  @override
  final int? chapterId;
  @override
  final int? chapterIndex;
  @override
  final int? position;
  @override
  final String? bookmarkTitle;
  @override
  final String? note;
  @override
  final DateTime? createTime;

  factory _$ReadingBookmarkDTO([
    void Function(ReadingBookmarkDTOBuilder)? updates,
  ]) => (ReadingBookmarkDTOBuilder()..update(updates))._build();

  _$ReadingBookmarkDTO._({
    this.id,
    this.userId,
    this.bookId,
    this.chapterId,
    this.chapterIndex,
    this.position,
    this.bookmarkTitle,
    this.note,
    this.createTime,
  }) : super._();
  @override
  ReadingBookmarkDTO rebuild(
    void Function(ReadingBookmarkDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReadingBookmarkDTOBuilder toBuilder() =>
      ReadingBookmarkDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingBookmarkDTO &&
        id == other.id &&
        userId == other.userId &&
        bookId == other.bookId &&
        chapterId == other.chapterId &&
        chapterIndex == other.chapterIndex &&
        position == other.position &&
        bookmarkTitle == other.bookmarkTitle &&
        note == other.note &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, bookmarkTitle.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReadingBookmarkDTO')
          ..add('id', id)
          ..add('userId', userId)
          ..add('bookId', bookId)
          ..add('chapterId', chapterId)
          ..add('chapterIndex', chapterIndex)
          ..add('position', position)
          ..add('bookmarkTitle', bookmarkTitle)
          ..add('note', note)
          ..add('createTime', createTime))
        .toString();
  }
}

class ReadingBookmarkDTOBuilder
    implements Builder<ReadingBookmarkDTO, ReadingBookmarkDTOBuilder> {
  _$ReadingBookmarkDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _bookId;
  int? get bookId => _$this._bookId;
  set bookId(int? bookId) => _$this._bookId = bookId;

  int? _chapterId;
  int? get chapterId => _$this._chapterId;
  set chapterId(int? chapterId) => _$this._chapterId = chapterId;

  int? _chapterIndex;
  int? get chapterIndex => _$this._chapterIndex;
  set chapterIndex(int? chapterIndex) => _$this._chapterIndex = chapterIndex;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  String? _bookmarkTitle;
  String? get bookmarkTitle => _$this._bookmarkTitle;
  set bookmarkTitle(String? bookmarkTitle) =>
      _$this._bookmarkTitle = bookmarkTitle;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  ReadingBookmarkDTOBuilder() {
    ReadingBookmarkDTO._defaults(this);
  }

  ReadingBookmarkDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _bookId = $v.bookId;
      _chapterId = $v.chapterId;
      _chapterIndex = $v.chapterIndex;
      _position = $v.position;
      _bookmarkTitle = $v.bookmarkTitle;
      _note = $v.note;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadingBookmarkDTO other) {
    _$v = other as _$ReadingBookmarkDTO;
  }

  @override
  void update(void Function(ReadingBookmarkDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadingBookmarkDTO build() => _build();

  _$ReadingBookmarkDTO _build() {
    final _$result =
        _$v ??
        _$ReadingBookmarkDTO._(
          id: id,
          userId: userId,
          bookId: bookId,
          chapterId: chapterId,
          chapterIndex: chapterIndex,
          position: position,
          bookmarkTitle: bookmarkTitle,
          note: note,
          createTime: createTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
