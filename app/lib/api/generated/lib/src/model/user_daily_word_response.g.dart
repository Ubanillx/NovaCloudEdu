// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_daily_word_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserDailyWordResponse extends UserDailyWordResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? wordId;
  @override
  final bool? studied;
  @override
  final bool? collected;
  @override
  final int? masteryLevel;
  @override
  final String? masteryLevelDesc;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final DailyWordResponse? word;

  factory _$UserDailyWordResponse([
    void Function(UserDailyWordResponseBuilder)? updates,
  ]) => (UserDailyWordResponseBuilder()..update(updates))._build();

  _$UserDailyWordResponse._({
    this.id,
    this.userId,
    this.wordId,
    this.studied,
    this.collected,
    this.masteryLevel,
    this.masteryLevelDesc,
    this.createTime,
    this.updateTime,
    this.word,
  }) : super._();
  @override
  UserDailyWordResponse rebuild(
    void Function(UserDailyWordResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserDailyWordResponseBuilder toBuilder() =>
      UserDailyWordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserDailyWordResponse &&
        id == other.id &&
        userId == other.userId &&
        wordId == other.wordId &&
        studied == other.studied &&
        collected == other.collected &&
        masteryLevel == other.masteryLevel &&
        masteryLevelDesc == other.masteryLevelDesc &&
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
    _$hash = $jc(_$hash, studied.hashCode);
    _$hash = $jc(_$hash, collected.hashCode);
    _$hash = $jc(_$hash, masteryLevel.hashCode);
    _$hash = $jc(_$hash, masteryLevelDesc.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, word.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserDailyWordResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('wordId', wordId)
          ..add('studied', studied)
          ..add('collected', collected)
          ..add('masteryLevel', masteryLevel)
          ..add('masteryLevelDesc', masteryLevelDesc)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('word', word))
        .toString();
  }
}

class UserDailyWordResponseBuilder
    implements Builder<UserDailyWordResponse, UserDailyWordResponseBuilder> {
  _$UserDailyWordResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _wordId;
  int? get wordId => _$this._wordId;
  set wordId(int? wordId) => _$this._wordId = wordId;

  bool? _studied;
  bool? get studied => _$this._studied;
  set studied(bool? studied) => _$this._studied = studied;

  bool? _collected;
  bool? get collected => _$this._collected;
  set collected(bool? collected) => _$this._collected = collected;

  int? _masteryLevel;
  int? get masteryLevel => _$this._masteryLevel;
  set masteryLevel(int? masteryLevel) => _$this._masteryLevel = masteryLevel;

  String? _masteryLevelDesc;
  String? get masteryLevelDesc => _$this._masteryLevelDesc;
  set masteryLevelDesc(String? masteryLevelDesc) =>
      _$this._masteryLevelDesc = masteryLevelDesc;

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

  UserDailyWordResponseBuilder() {
    UserDailyWordResponse._defaults(this);
  }

  UserDailyWordResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _wordId = $v.wordId;
      _studied = $v.studied;
      _collected = $v.collected;
      _masteryLevel = $v.masteryLevel;
      _masteryLevelDesc = $v.masteryLevelDesc;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _word = $v.word?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserDailyWordResponse other) {
    _$v = other as _$UserDailyWordResponse;
  }

  @override
  void update(void Function(UserDailyWordResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserDailyWordResponse build() => _build();

  _$UserDailyWordResponse _build() {
    _$UserDailyWordResponse _$result;
    try {
      _$result =
          _$v ??
          _$UserDailyWordResponse._(
            id: id,
            userId: userId,
            wordId: wordId,
            studied: studied,
            collected: collected,
            masteryLevel: masteryLevel,
            masteryLevelDesc: masteryLevelDesc,
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
          r'UserDailyWordResponse',
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
