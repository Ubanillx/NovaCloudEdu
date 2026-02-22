// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reading_note_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateReadingNoteCommand extends CreateReadingNoteCommand {
  @override
  final int userId;
  @override
  final int chapterId;
  @override
  final String noteContent;
  @override
  final int? chapterIndex;
  @override
  final String? selectedText;
  @override
  final int? startPosition;
  @override
  final int? endPosition;
  @override
  final String? noteColor;

  factory _$CreateReadingNoteCommand([
    void Function(CreateReadingNoteCommandBuilder)? updates,
  ]) => (CreateReadingNoteCommandBuilder()..update(updates))._build();

  _$CreateReadingNoteCommand._({
    required this.userId,
    required this.chapterId,
    required this.noteContent,
    this.chapterIndex,
    this.selectedText,
    this.startPosition,
    this.endPosition,
    this.noteColor,
  }) : super._();
  @override
  CreateReadingNoteCommand rebuild(
    void Function(CreateReadingNoteCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReadingNoteCommandBuilder toBuilder() =>
      CreateReadingNoteCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReadingNoteCommand &&
        userId == other.userId &&
        chapterId == other.chapterId &&
        noteContent == other.noteContent &&
        chapterIndex == other.chapterIndex &&
        selectedText == other.selectedText &&
        startPosition == other.startPosition &&
        endPosition == other.endPosition &&
        noteColor == other.noteColor;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, noteContent.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, selectedText.hashCode);
    _$hash = $jc(_$hash, startPosition.hashCode);
    _$hash = $jc(_$hash, endPosition.hashCode);
    _$hash = $jc(_$hash, noteColor.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateReadingNoteCommand')
          ..add('userId', userId)
          ..add('chapterId', chapterId)
          ..add('noteContent', noteContent)
          ..add('chapterIndex', chapterIndex)
          ..add('selectedText', selectedText)
          ..add('startPosition', startPosition)
          ..add('endPosition', endPosition)
          ..add('noteColor', noteColor))
        .toString();
  }
}

class CreateReadingNoteCommandBuilder
    implements
        Builder<CreateReadingNoteCommand, CreateReadingNoteCommandBuilder> {
  _$CreateReadingNoteCommand? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _chapterId;
  int? get chapterId => _$this._chapterId;
  set chapterId(int? chapterId) => _$this._chapterId = chapterId;

  String? _noteContent;
  String? get noteContent => _$this._noteContent;
  set noteContent(String? noteContent) => _$this._noteContent = noteContent;

  int? _chapterIndex;
  int? get chapterIndex => _$this._chapterIndex;
  set chapterIndex(int? chapterIndex) => _$this._chapterIndex = chapterIndex;

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

  CreateReadingNoteCommandBuilder() {
    CreateReadingNoteCommand._defaults(this);
  }

  CreateReadingNoteCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _chapterId = $v.chapterId;
      _noteContent = $v.noteContent;
      _chapterIndex = $v.chapterIndex;
      _selectedText = $v.selectedText;
      _startPosition = $v.startPosition;
      _endPosition = $v.endPosition;
      _noteColor = $v.noteColor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReadingNoteCommand other) {
    _$v = other as _$CreateReadingNoteCommand;
  }

  @override
  void update(void Function(CreateReadingNoteCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReadingNoteCommand build() => _build();

  _$CreateReadingNoteCommand _build() {
    final _$result =
        _$v ??
        _$CreateReadingNoteCommand._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'CreateReadingNoteCommand',
            'userId',
          ),
          chapterId: BuiltValueNullFieldError.checkNotNull(
            chapterId,
            r'CreateReadingNoteCommand',
            'chapterId',
          ),
          noteContent: BuiltValueNullFieldError.checkNotNull(
            noteContent,
            r'CreateReadingNoteCommand',
            'noteContent',
          ),
          chapterIndex: chapterIndex,
          selectedText: selectedText,
          startPosition: startPosition,
          endPosition: endPosition,
          noteColor: noteColor,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
