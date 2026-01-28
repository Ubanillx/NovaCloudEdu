// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_content_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChapterContentDTO extends ChapterContentDTO {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final int? chapterIndex;
  @override
  final String? content;
  @override
  final int? wordCount;

  factory _$ChapterContentDTO([
    void Function(ChapterContentDTOBuilder)? updates,
  ]) => (ChapterContentDTOBuilder()..update(updates))._build();

  _$ChapterContentDTO._({
    this.id,
    this.title,
    this.chapterIndex,
    this.content,
    this.wordCount,
  }) : super._();
  @override
  ChapterContentDTO rebuild(void Function(ChapterContentDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterContentDTOBuilder toBuilder() =>
      ChapterContentDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterContentDTO &&
        id == other.id &&
        title == other.title &&
        chapterIndex == other.chapterIndex &&
        content == other.content &&
        wordCount == other.wordCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, wordCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChapterContentDTO')
          ..add('id', id)
          ..add('title', title)
          ..add('chapterIndex', chapterIndex)
          ..add('content', content)
          ..add('wordCount', wordCount))
        .toString();
  }
}

class ChapterContentDTOBuilder
    implements Builder<ChapterContentDTO, ChapterContentDTOBuilder> {
  _$ChapterContentDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _chapterIndex;
  int? get chapterIndex => _$this._chapterIndex;
  set chapterIndex(int? chapterIndex) => _$this._chapterIndex = chapterIndex;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  int? _wordCount;
  int? get wordCount => _$this._wordCount;
  set wordCount(int? wordCount) => _$this._wordCount = wordCount;

  ChapterContentDTOBuilder() {
    ChapterContentDTO._defaults(this);
  }

  ChapterContentDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _chapterIndex = $v.chapterIndex;
      _content = $v.content;
      _wordCount = $v.wordCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterContentDTO other) {
    _$v = other as _$ChapterContentDTO;
  }

  @override
  void update(void Function(ChapterContentDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterContentDTO build() => _build();

  _$ChapterContentDTO _build() {
    final _$result =
        _$v ??
        _$ChapterContentDTO._(
          id: id,
          title: title,
          chapterIndex: chapterIndex,
          content: content,
          wordCount: wordCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
