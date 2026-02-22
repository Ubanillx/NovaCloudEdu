// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_book_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UploadBookCommand extends UploadBookCommand {
  @override
  final Uint8List file;
  @override
  final String title;
  @override
  final int adminId;
  @override
  final String? author;
  @override
  final Uint8List? cover;

  factory _$UploadBookCommand([
    void Function(UploadBookCommandBuilder)? updates,
  ]) => (UploadBookCommandBuilder()..update(updates))._build();

  _$UploadBookCommand._({
    required this.file,
    required this.title,
    required this.adminId,
    this.author,
    this.cover,
  }) : super._();
  @override
  UploadBookCommand rebuild(void Function(UploadBookCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UploadBookCommandBuilder toBuilder() =>
      UploadBookCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UploadBookCommand &&
        file == other.file &&
        title == other.title &&
        adminId == other.adminId &&
        author == other.author &&
        cover == other.cover;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, file.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, adminId.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, cover.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UploadBookCommand')
          ..add('file', file)
          ..add('title', title)
          ..add('adminId', adminId)
          ..add('author', author)
          ..add('cover', cover))
        .toString();
  }
}

class UploadBookCommandBuilder
    implements Builder<UploadBookCommand, UploadBookCommandBuilder> {
  _$UploadBookCommand? _$v;

  Uint8List? _file;
  Uint8List? get file => _$this._file;
  set file(Uint8List? file) => _$this._file = file;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _adminId;
  int? get adminId => _$this._adminId;
  set adminId(int? adminId) => _$this._adminId = adminId;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  Uint8List? _cover;
  Uint8List? get cover => _$this._cover;
  set cover(Uint8List? cover) => _$this._cover = cover;

  UploadBookCommandBuilder() {
    UploadBookCommand._defaults(this);
  }

  UploadBookCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _file = $v.file;
      _title = $v.title;
      _adminId = $v.adminId;
      _author = $v.author;
      _cover = $v.cover;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UploadBookCommand other) {
    _$v = other as _$UploadBookCommand;
  }

  @override
  void update(void Function(UploadBookCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UploadBookCommand build() => _build();

  _$UploadBookCommand _build() {
    final _$result =
        _$v ??
        _$UploadBookCommand._(
          file: BuiltValueNullFieldError.checkNotNull(
            file,
            r'UploadBookCommand',
            'file',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'UploadBookCommand',
            'title',
          ),
          adminId: BuiltValueNullFieldError.checkNotNull(
            adminId,
            r'UploadBookCommand',
            'adminId',
          ),
          author: author,
          cover: cover,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
