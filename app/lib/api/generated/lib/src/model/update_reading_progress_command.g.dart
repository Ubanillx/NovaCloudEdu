// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_reading_progress_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateReadingProgressCommand extends UpdateReadingProgressCommand {
  @override
  final int userId;
  @override
  final int bookId;
  @override
  final int chapterIndex;
  @override
  final int position;

  factory _$UpdateReadingProgressCommand([
    void Function(UpdateReadingProgressCommandBuilder)? updates,
  ]) => (UpdateReadingProgressCommandBuilder()..update(updates))._build();

  _$UpdateReadingProgressCommand._({
    required this.userId,
    required this.bookId,
    required this.chapterIndex,
    required this.position,
  }) : super._();
  @override
  UpdateReadingProgressCommand rebuild(
    void Function(UpdateReadingProgressCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateReadingProgressCommandBuilder toBuilder() =>
      UpdateReadingProgressCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateReadingProgressCommand &&
        userId == other.userId &&
        bookId == other.bookId &&
        chapterIndex == other.chapterIndex &&
        position == other.position;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, chapterIndex.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateReadingProgressCommand')
          ..add('userId', userId)
          ..add('bookId', bookId)
          ..add('chapterIndex', chapterIndex)
          ..add('position', position))
        .toString();
  }
}

class UpdateReadingProgressCommandBuilder
    implements
        Builder<
          UpdateReadingProgressCommand,
          UpdateReadingProgressCommandBuilder
        > {
  _$UpdateReadingProgressCommand? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _bookId;
  int? get bookId => _$this._bookId;
  set bookId(int? bookId) => _$this._bookId = bookId;

  int? _chapterIndex;
  int? get chapterIndex => _$this._chapterIndex;
  set chapterIndex(int? chapterIndex) => _$this._chapterIndex = chapterIndex;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  UpdateReadingProgressCommandBuilder() {
    UpdateReadingProgressCommand._defaults(this);
  }

  UpdateReadingProgressCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _bookId = $v.bookId;
      _chapterIndex = $v.chapterIndex;
      _position = $v.position;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateReadingProgressCommand other) {
    _$v = other as _$UpdateReadingProgressCommand;
  }

  @override
  void update(void Function(UpdateReadingProgressCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateReadingProgressCommand build() => _build();

  _$UpdateReadingProgressCommand _build() {
    final _$result =
        _$v ??
        _$UpdateReadingProgressCommand._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'UpdateReadingProgressCommand',
            'userId',
          ),
          bookId: BuiltValueNullFieldError.checkNotNull(
            bookId,
            r'UpdateReadingProgressCommand',
            'bookId',
          ),
          chapterIndex: BuiltValueNullFieldError.checkNotNull(
            chapterIndex,
            r'UpdateReadingProgressCommand',
            'chapterIndex',
          ),
          position: BuiltValueNullFieldError.checkNotNull(
            position,
            r'UpdateReadingProgressCommand',
            'position',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
