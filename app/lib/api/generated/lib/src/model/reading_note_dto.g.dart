// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_note_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReadingNoteDTO extends ReadingNoteDTO {
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
  final String? noteContent;
  @override
  final String? selectedText;
  @override
  final int? startPosition;
  @override
  final int? endPosition;
  @override
  final String? noteColor;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ReadingNoteDTO([void Function(ReadingNoteDTOBuilder)? updates]) =>
      (ReadingNoteDTOBuilder()..update(updates))._build();

  _$ReadingNoteDTO._({
    this.id,
    this.userId,
    this.bookId,
    this.chapterId,
    this.chapterIndex,
    this.noteContent,
    this.selectedText,
    this.startPosition,
    this.endPosition,
    this.noteColor,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ReadingNoteDTO rebuild(void Function(ReadingNoteDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadingNoteDTOBuilder toBuilder() => ReadingNoteDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingNoteDTO &&
        id == other.id &&
        userId == other.userId &&
        bookId == other.bookId &&
        chapterId == other.chapterId &&
        chapterIndex == other.chapterIndex &&
        noteContent == other.noteContent &&
        selectedText == other.selectedText &&
        startPosition == other.startPosition &&
        endPosition == other.endPosition &&
        noteColor == other.noteColor &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, noteContent.hashCode);
    _$hash = $jc(_$hash, selectedText.hashCode);
    _$hash = $jc(_$hash, startPosition.hashCode);
    _$hash = $jc(_$hash, endPosition.hashCode);
    _$hash = $jc(_$hash, noteColor.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReadingNoteDTO')
          ..add('id', id)
          ..add('userId', userId)
          ..add('bookId', bookId)
          ..add('chapterId', chapterId)
          ..add('chapterIndex', chapterIndex)
          ..add('noteContent', noteContent)
          ..add('selectedText', selectedText)
          ..add('startPosition', startPosition)
          ..add('endPosition', endPosition)
          ..add('noteColor', noteColor)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ReadingNoteDTOBuilder
    implements Builder<ReadingNoteDTO, ReadingNoteDTOBuilder> {
  _$ReadingNoteDTO? _$v;

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

  String? _noteContent;
  String? get noteContent => _$this._noteContent;
  set noteContent(String? noteContent) => _$this._noteContent = noteContent;

  String? _selectedText;
  String? get selectedText => _$this._selectedText;
  set selectedText(String? selectedText) => _$this._selectedText = selectedText;

  int? _startPosition;
  int? get startPosition => _$this._startPosition;
  set startPosition(int? startPosition) =>
      _$this._startPosition = startPosition;

  int? _endPosition;
  int? get endPosition => _$this._endPosition;
  set endPosition(int? endPosition) => _$this._endPosition = endPosition;

  String? _noteColor;
  String? get noteColor => _$this._noteColor;
  set noteColor(String? noteColor) => _$this._noteColor = noteColor;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ReadingNoteDTOBuilder() {
    ReadingNoteDTO._defaults(this);
  }

  ReadingNoteDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _bookId = $v.bookId;
      _chapterId = $v.chapterId;
      _chapterIndex = $v.chapterIndex;
      _noteContent = $v.noteContent;
      _selectedText = $v.selectedText;
      _startPosition = $v.startPosition;
      _endPosition = $v.endPosition;
      _noteColor = $v.noteColor;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadingNoteDTO other) {
    _$v = other as _$ReadingNoteDTO;
  }

  @override
  void update(void Function(ReadingNoteDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadingNoteDTO build() => _build();

  _$ReadingNoteDTO _build() {
    final _$result =
        _$v ??
        _$ReadingNoteDTO._(
          id: id,
          userId: userId,
          bookId: bookId,
          chapterId: chapterId,
          chapterIndex: chapterIndex,
          noteContent: noteContent,
          selectedText: selectedText,
          startPosition: startPosition,
          endPosition: endPosition,
          noteColor: noteColor,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
