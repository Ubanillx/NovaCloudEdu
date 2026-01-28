// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterDTO extends ChapterDTO {
  @override
  final int? id;
  @override
  final int? bookId;
  @override
  final String? title;
  @override
  final int? chapterIndex;
  @override
  final int? wordCount;

  factory _$ChapterDTO([void Function(ChapterDTOBuilder)? updates]) =>
      (ChapterDTOBuilder()..update(updates))._build();

  _$ChapterDTO._({
    this.id,
    this.bookId,
    this.title,
    this.chapterIndex,
    this.wordCount,
  }) : super._();
  @override
  ChapterDTO rebuild(void Function(ChapterDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterDTOBuilder toBuilder() => ChapterDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterDTO &&
        id == other.id &&
        bookId == other.bookId &&
        title == other.title &&
        chapterIndex == other.chapterIndex &&
        wordCount == other.wordCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, wordCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChapterDTO')
          ..add('id', id)
          ..add('bookId', bookId)
          ..add('title', title)
          ..add('chapterIndex', chapterIndex)
          ..add('wordCount', wordCount))
        .toString();
  }
}

class ChapterDTOBuilder implements Builder<ChapterDTO, ChapterDTOBuilder> {
  _$ChapterDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _bookId;
  int? get bookId => _$this._bookId;
  set bookId(int? bookId) => _$this._bookId = bookId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _chapterIndex;
  int? get chapterIndex => _$this._chapterIndex;
  set chapterIndex(int? chapterIndex) => _$this._chapterIndex = chapterIndex;

  int? _wordCount;
  int? get wordCount => _$this._wordCount;
  set wordCount(int? wordCount) => _$this._wordCount = wordCount;

  ChapterDTOBuilder() {
    ChapterDTO._defaults(this);
  }

  ChapterDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _bookId = $v.bookId;
      _title = $v.title;
      _chapterIndex = $v.chapterIndex;
      _wordCount = $v.wordCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterDTO other) {
    _$v = other as _$ChapterDTO;
  }

  @override
  void update(void Function(ChapterDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterDTO build() => _build();

  _$ChapterDTO _build() {
    final _$result =
        _$v ??
        _$ChapterDTO._(
          id: id,
          bookId: bookId,
          title: title,
          chapterIndex: chapterIndex,
          wordCount: wordCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
