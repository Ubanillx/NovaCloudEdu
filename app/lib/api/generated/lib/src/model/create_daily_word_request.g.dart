// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_daily_word_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateDailyWordRequest extends CreateDailyWordRequest {
  @override
  final String word;
  @override
  final String translation;
  @override
  final int difficulty;
  @override
  final Date publishDate;
  @override
  final String? pronunciationUs;
  @override
  final String? pronunciationUk;
  @override
  final String? audioUrlUs;
  @override
  final String? audioUrlUk;
  @override
  final String? example;
  @override
  final String? exampleTranslation;
  @override
  final String? category;
  @override
  final String? notes;

  factory _$CreateDailyWordRequest([
    void Function(CreateDailyWordRequestBuilder)? updates,
  ]) => (CreateDailyWordRequestBuilder()..update(updates))._build();

  _$CreateDailyWordRequest._({
    required this.word,
    required this.translation,
    required this.difficulty,
    required this.publishDate,
    this.pronunciationUs,
    this.pronunciationUk,
    this.audioUrlUs,
    this.audioUrlUk,
    this.example,
    this.exampleTranslation,
    this.category,
    this.notes,
  }) : super._();
  @override
  CreateDailyWordRequest rebuild(
    void Function(CreateDailyWordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateDailyWordRequestBuilder toBuilder() =>
      CreateDailyWordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDailyWordRequest &&
        word == other.word &&
        translation == other.translation &&
        difficulty == other.difficulty &&
        publishDate == other.publishDate &&
        pronunciationUs == other.pronunciationUs &&
        pronunciationUk == other.pronunciationUk &&
        audioUrlUs == other.audioUrlUs &&
        audioUrlUk == other.audioUrlUk &&
        example == other.example &&
        exampleTranslation == other.exampleTranslation &&
        category == other.category &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, word.hashCode);
    _$hash = $jc(_$hash, translation.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, publishDate.hashCode);
    _$hash = $jc(_$hash, pronunciationUs.hashCode);
    _$hash = $jc(_$hash, pronunciationUk.hashCode);
    _$hash = $jc(_$hash, audioUrlUs.hashCode);
    _$hash = $jc(_$hash, audioUrlUk.hashCode);
    _$hash = $jc(_$hash, example.hashCode);
    _$hash = $jc(_$hash, exampleTranslation.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateDailyWordRequest')
          ..add('word', word)
          ..add('translation', translation)
          ..add('difficulty', difficulty)
          ..add('publishDate', publishDate)
          ..add('pronunciationUs', pronunciationUs)
          ..add('pronunciationUk', pronunciationUk)
          ..add('audioUrlUs', audioUrlUs)
          ..add('audioUrlUk', audioUrlUk)
          ..add('example', example)
          ..add('exampleTranslation', exampleTranslation)
          ..add('category', category)
          ..add('notes', notes))
        .toString();
  }
}

class CreateDailyWordRequestBuilder
    implements Builder<CreateDailyWordRequest, CreateDailyWordRequestBuilder> {
  _$CreateDailyWordRequest? _$v;

  String? _word;
  String? get word => _$this._word;
  set word(String? word) => _$this._word = word;

  String? _translation;
  String? get translation => _$this._translation;
  set translation(String? translation) => _$this._translation = translation;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  Date? _publishDate;
  Date? get publishDate => _$this._publishDate;
  set publishDate(Date? publishDate) => _$this._publishDate = publishDate;

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

  String? _example;
  String? get example => _$this._example;
  set example(String? example) => _$this._example = example;

  String? _exampleTranslation;
  String? get exampleTranslation => _$this._exampleTranslation;
  set exampleTranslation(String? exampleTranslation) =>
      _$this._exampleTranslation = exampleTranslation;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  CreateDailyWordRequestBuilder() {
    CreateDailyWordRequest._defaults(this);
  }

  CreateDailyWordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _word = $v.word;
      _translation = $v.translation;
      _difficulty = $v.difficulty;
      _publishDate = $v.publishDate;
      _pronunciationUs = $v.pronunciationUs;
      _pronunciationUk = $v.pronunciationUk;
      _audioUrlUs = $v.audioUrlUs;
      _audioUrlUk = $v.audioUrlUk;
      _example = $v.example;
      _exampleTranslation = $v.exampleTranslation;
      _category = $v.category;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateDailyWordRequest other) {
    _$v = other as _$CreateDailyWordRequest;
  }

  @override
  void update(void Function(CreateDailyWordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDailyWordRequest build() => _build();

  _$CreateDailyWordRequest _build() {
    final _$result =
        _$v ??
        _$CreateDailyWordRequest._(
          word: BuiltValueNullFieldError.checkNotNull(
            word,
            r'CreateDailyWordRequest',
            'word',
          ),
          translation: BuiltValueNullFieldError.checkNotNull(
            translation,
            r'CreateDailyWordRequest',
            'translation',
          ),
          difficulty: BuiltValueNullFieldError.checkNotNull(
            difficulty,
            r'CreateDailyWordRequest',
            'difficulty',
          ),
          publishDate: BuiltValueNullFieldError.checkNotNull(
            publishDate,
            r'CreateDailyWordRequest',
            'publishDate',
          ),
          pronunciationUs: pronunciationUs,
          pronunciationUk: pronunciationUk,
          audioUrlUs: audioUrlUs,
          audioUrlUk: audioUrlUk,
          example: example,
          exampleTranslation: exampleTranslation,
          category: category,
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
