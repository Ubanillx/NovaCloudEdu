// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_word_book_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserWordBookResponse extends UserWordBookResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? wordId;
  @override
  final int? learningStatus;
  @override
  final String? learningStatusDesc;
  @override
  final DateTime? collectedTime;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final DailyWordResponse? word;

  factory _$UserWordBookResponse([
    void Function(UserWordBookResponseBuilder)? updates,
  ]) => (UserWordBookResponseBuilder()..update(updates))._build();

  _$UserWordBookResponse._({
    this.id,
    this.userId,
    this.wordId,
    this.learningStatus,
    this.learningStatusDesc,
    this.collectedTime,
    this.createTime,
    this.updateTime,
    this.word,
  }) : super._();
  @override
  UserWordBookResponse rebuild(
    void Function(UserWordBookResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserWordBookResponseBuilder toBuilder() =>
      UserWordBookResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserWordBookResponse &&
        id == other.id &&
        userId == other.userId &&
        wordId == other.wordId &&
        learningStatus == other.learningStatus &&
        learningStatusDesc == other.learningStatusDesc &&
        collectedTime == other.collectedTime &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        word == other.word;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, wordId.hashCode);
    _$hash = $jc(_$hash, learningStatus.hashCode);
    _$hash = $jc(_$hash, learningStatusDesc.hashCode);
    _$hash = $jc(_$hash, collectedTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, word.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserWordBookResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('wordId', wordId)
          ..add('learningStatus', learningStatus)
          ..add('learningStatusDesc', learningStatusDesc)
          ..add('collectedTime', collectedTime)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('word', word))
        .toString();
  }
}

class UserWordBookResponseBuilder
    implements Builder<UserWordBookResponse, UserWordBookResponseBuilder> {
  _$UserWordBookResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _wordId;
  int? get wordId => _$this._wordId;
  set wordId(int? wordId) => _$this._wordId = wordId;

  int? _learningStatus;
  int? get learningStatus => _$this._learningStatus;
  set learningStatus(int? learningStatus) =>
      _$this._learningStatus = learningStatus;

  String? _learningStatusDesc;
  String? get learningStatusDesc => _$this._learningStatusDesc;
  set learningStatusDesc(String? learningStatusDesc) =>
      _$this._learningStatusDesc = learningStatusDesc;

  DateTime? _collectedTime;
  DateTime? get collectedTime => _$this._collectedTime;
  set collectedTime(DateTime? collectedTime) =>
      _$this._collectedTime = collectedTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  DailyWordResponseBuilder? _word;
  DailyWordResponseBuilder get word =>
      _$this._word ??= DailyWordResponseBuilder();
  set word(DailyWordResponseBuilder? word) => _$this._word = word;

  UserWordBookResponseBuilder() {
    UserWordBookResponse._defaults(this);
  }

  UserWordBookResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _wordId = $v.wordId;
      _learningStatus = $v.learningStatus;
      _learningStatusDesc = $v.learningStatusDesc;
      _collectedTime = $v.collectedTime;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _word = $v.word?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserWordBookResponse other) {
    _$v = other as _$UserWordBookResponse;
  }

  @override
  void update(void Function(UserWordBookResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserWordBookResponse build() => _build();

  _$UserWordBookResponse _build() {
    _$UserWordBookResponse _$result;
    try {
      _$result =
          _$v ??
          _$UserWordBookResponse._(
            id: id,
            userId: userId,
            wordId: wordId,
            learningStatus: learningStatus,
            learningStatusDesc: learningStatusDesc,
            collectedTime: collectedTime,
            createTime: createTime,
            updateTime: updateTime,
            word: _word?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'word';
        _word?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UserWordBookResponse',
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
