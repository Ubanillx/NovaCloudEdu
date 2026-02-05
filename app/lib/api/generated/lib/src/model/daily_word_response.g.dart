// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_word_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DailyWordResponse extends DailyWordResponse {
  @override
  final int? id;
  @override
  final String? word;
  @override
  final String? pronunciationUs;
  @override
  final String? pronunciationUk;
  @override
  final String? audioUrlUs;
  @override
  final String? audioUrlUk;
  @override
  final String? translation;
  @override
  final String? example;
  @override
  final String? exampleTranslation;
  @override
  final int? difficulty;
  @override
  final String? difficultyDesc;
  @override
  final String? category;
  @override
  final String? notes;
  @override
  final Date? publishDate;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$DailyWordResponse([
    void Function(DailyWordResponseBuilder)? updates,
  ]) => (DailyWordResponseBuilder()..update(updates))._build();

  _$DailyWordResponse._({
    this.id,
    this.word,
    this.pronunciationUs,
    this.pronunciationUk,
    this.audioUrlUs,
    this.audioUrlUk,
    this.translation,
    this.example,
    this.exampleTranslation,
    this.difficulty,
    this.difficultyDesc,
    this.category,
    this.notes,
    this.publishDate,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  DailyWordResponse rebuild(void Function(DailyWordResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DailyWordResponseBuilder toBuilder() =>
      DailyWordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DailyWordResponse &&
        id == other.id &&
        word == other.word &&
        pronunciationUs == other.pronunciationUs &&
        pronunciationUk == other.pronunciationUk &&
        audioUrlUs == other.audioUrlUs &&
        audioUrlUk == other.audioUrlUk &&
        translation == other.translation &&
        example == other.example &&
        exampleTranslation == other.exampleTranslation &&
        difficulty == other.difficulty &&
        difficultyDesc == other.difficultyDesc &&
        category == other.category &&
        notes == other.notes &&
        publishDate == other.publishDate &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, word.hashCode);
    _$hash = $jc(_$hash, pronunciationUs.hashCode);
    _$hash = $jc(_$hash, pronunciationUk.hashCode);
    _$hash = $jc(_$hash, audioUrlUs.hashCode);
    _$hash = $jc(_$hash, audioUrlUk.hashCode);
    _$hash = $jc(_$hash, translation.hashCode);
    _$hash = $jc(_$hash, example.hashCode);
    _$hash = $jc(_$hash, exampleTranslation.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, difficultyDesc.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, publishDate.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DailyWordResponse')
          ..add('id', id)
          ..add('word', word)
          ..add('pronunciationUs', pronunciationUs)
          ..add('pronunciationUk', pronunciationUk)
          ..add('audioUrlUs', audioUrlUs)
          ..add('audioUrlUk', audioUrlUk)
          ..add('translation', translation)
          ..add('example', example)
          ..add('exampleTranslation', exampleTranslation)
          ..add('difficulty', difficulty)
          ..add('difficultyDesc', difficultyDesc)
          ..add('category', category)
          ..add('notes', notes)
          ..add('publishDate', publishDate)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class DailyWordResponseBuilder
    implements Builder<DailyWordResponse, DailyWordResponseBuilder> {
  _$DailyWordResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _word;
  String? get word => _$this._word;
  set word(String? word) => _$this._word = word;

  String? _pronunciationUs;
  String? get pronunciationUs => _$this._pronunciationUs;
  set pronunciationUs(String? pronunciationUs) =>
      _$this._pronunciationUs = pronunciationUs;

  String? _pronunciationUk;
  String? get pronunciationUk => _$this._pronunciationUk;
  set pronunciationUk(String? pronunciationUk) =>
      _$this._pronunciationUk = pronunciationUk;

  String? _audioUrlUs;
  String? get audioUrlUs => _$this._audioUrlUs;
  set audioUrlUs(String? audioUrlUs) => _$this._audioUrlUs = audioUrlUs;

  String? _audioUrlUk;
  String? get audioUrlUk => _$this._audioUrlUk;
  set audioUrlUk(String? audioUrlUk) => _$this._audioUrlUk = audioUrlUk;

  String? _translation;
  String? get translation => _$this._translation;
  set translation(String? translation) => _$this._translation = translation;

  String? _example;
  String? get example => _$this._example;
  set example(String? example) => _$this._example = example;

  String? _exampleTranslation;
  String? get exampleTranslation => _$this._exampleTranslation;
  set exampleTranslation(String? exampleTranslation) =>
      _$this._exampleTranslation = exampleTranslation;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  String? _difficultyDesc;
  String? get difficultyDesc => _$this._difficultyDesc;
  set difficultyDesc(String? difficultyDesc) =>
      _$this._difficultyDesc = difficultyDesc;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  Date? _publishDate;
  Date? get publishDate => _$this._publishDate;
  set publishDate(Date? publishDate) => _$this._publishDate = publishDate;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  DailyWordResponseBuilder() {
    DailyWordResponse._defaults(this);
  }

  DailyWordResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _word = $v.word;
      _pronunciationUs = $v.pronunciationUs;
      _pronunciationUk = $v.pronunciationUk;
      _audioUrlUs = $v.audioUrlUs;
      _audioUrlUk = $v.audioUrlUk;
      _translation = $v.translation;
      _example = $v.example;
      _exampleTranslation = $v.exampleTranslation;
      _difficulty = $v.difficulty;
      _difficultyDesc = $v.difficultyDesc;
      _category = $v.category;
      _notes = $v.notes;
      _publishDate = $v.publishDate;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DailyWordResponse other) {
    _$v = other as _$DailyWordResponse;
  }

  @override
  void update(void Function(DailyWordResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DailyWordResponse build() => _build();

  _$DailyWordResponse _build() {
    final _$result =
        _$v ??
        _$DailyWordResponse._(
          id: id,
          word: word,
          pronunciationUs: pronunciationUs,
          pronunciationUk: pronunciationUk,
          audioUrlUs: audioUrlUs,
          audioUrlUk: audioUrlUk,
          translation: translation,
          example: example,
          exampleTranslation: exampleTranslation,
          difficulty: difficulty,
          difficultyDesc: difficultyDesc,
          category: category,
          notes: notes,
          publishDate: publishDate,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
