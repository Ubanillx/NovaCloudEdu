// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BookDTO extends BookDTO {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? author;
  @override
  final String? coverUrl;
  @override
  final String? originFileUrl;
  @override
  final String? fileType;
  @override
  final String? status;
  @override
  final int? totalChapters;
  @override
  final int? wordCount;
  @override
  final int? fileSize;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$BookDTO([void Function(BookDTOBuilder)? updates]) =>
      (BookDTOBuilder()..update(updates))._build();

  _$BookDTO._({
    this.id,
    this.title,
    this.author,
    this.coverUrl,
    this.originFileUrl,
    this.fileType,
    this.status,
    this.totalChapters,
    this.wordCount,
    this.fileSize,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  BookDTO rebuild(void Function(BookDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BookDTOBuilder toBuilder() => BookDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BookDTO &&
        id == other.id &&
        title == other.title &&
        author == other.author &&
        coverUrl == other.coverUrl &&
        originFileUrl == other.originFileUrl &&
        fileType == other.fileType &&
        status == other.status &&
        totalChapters == other.totalChapters &&
        wordCount == other.wordCount &&
        fileSize == other.fileSize &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, coverUrl.hashCode);
    _$hash = $jc(_$hash, originFileUrl.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalChapters.hashCode);
    _$hash = $jc(_$hash, wordCount.hashCode);
    _$hash = $jc(_$hash, fileSize.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BookDTO')
          ..add('id', id)
          ..add('title', title)
          ..add('author', author)
          ..add('coverUrl', coverUrl)
          ..add('originFileUrl', originFileUrl)
          ..add('fileType', fileType)
          ..add('status', status)
          ..add('totalChapters', totalChapters)
          ..add('wordCount', wordCount)
          ..add('fileSize', fileSize)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class BookDTOBuilder implements Builder<BookDTO, BookDTOBuilder> {
  _$BookDTO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _coverUrl;
  String? get coverUrl => _$this._coverUrl;
  set coverUrl(String? coverUrl) => _$this._coverUrl = coverUrl;

  String? _originFileUrl;
  String? get originFileUrl => _$this._originFileUrl;
  set originFileUrl(String? originFileUrl) =>
      _$this._originFileUrl = originFileUrl;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _totalChapters;
  int? get totalChapters => _$this._totalChapters;
  set totalChapters(int? totalChapters) =>
      _$this._totalChapters = totalChapters;

  int? _wordCount;
  int? get wordCount => _$this._wordCount;
  set wordCount(int? wordCount) => _$this._wordCount = wordCount;

  int? _fileSize;
  int? get fileSize => _$this._fileSize;
  set fileSize(int? fileSize) => _$this._fileSize = fileSize;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  BookDTOBuilder() {
    BookDTO._defaults(this);
  }

  BookDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _author = $v.author;
      _coverUrl = $v.coverUrl;
      _originFileUrl = $v.originFileUrl;
      _fileType = $v.fileType;
      _status = $v.status;
      _totalChapters = $v.totalChapters;
      _wordCount = $v.wordCount;
      _fileSize = $v.fileSize;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BookDTO other) {
    _$v = other as _$BookDTO;
  }

  @override
  void update(void Function(BookDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BookDTO build() => _build();

  _$BookDTO _build() {
    final _$result =
        _$v ??
        _$BookDTO._(
          id: id,
          title: title,
          author: author,
          coverUrl: coverUrl,
          originFileUrl: originFileUrl,
          fileType: fileType,
          status: status,
          totalChapters: totalChapters,
          wordCount: wordCount,
          fileSize: fileSize,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
