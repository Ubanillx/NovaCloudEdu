// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QuestionResponse extends QuestionResponse {
  @override
  final int? id;
  @override
  final String? type;
  @override
  final String? typeDesc;
  @override
  final String? subject;
  @override
  final String? subjectDesc;
  @override
  final String? grade;
  @override
  final int? difficulty;
  @override
  final String? difficultyDesc;
  @override
  final String? content;
  @override
  final String? options;
  @override
  final String? answer;
  @override
  final String? explanation;
  @override
  final BuiltList<String>? knowledgeTags;
  @override
  final String? imageUrl;
  @override
  final String? source_;
  @override
  final int? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$QuestionResponse([
    void Function(QuestionResponseBuilder)? updates,
  ]) => (QuestionResponseBuilder()..update(updates))._build();

  _$QuestionResponse._({
    this.id,
    this.type,
    this.typeDesc,
    this.subject,
    this.subjectDesc,
    this.grade,
    this.difficulty,
    this.difficultyDesc,
    this.content,
    this.options,
    this.answer,
    this.explanation,
    this.knowledgeTags,
    this.imageUrl,
    this.source_,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  QuestionResponse rebuild(void Function(QuestionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuestionResponseBuilder toBuilder() =>
      QuestionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuestionResponse &&
        id == other.id &&
        type == other.type &&
        typeDesc == other.typeDesc &&
        subject == other.subject &&
        subjectDesc == other.subjectDesc &&
        grade == other.grade &&
        difficulty == other.difficulty &&
        difficultyDesc == other.difficultyDesc &&
        content == other.content &&
        options == other.options &&
        answer == other.answer &&
        explanation == other.explanation &&
        knowledgeTags == other.knowledgeTags &&
        imageUrl == other.imageUrl &&
        source_ == other.source_ &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, typeDesc.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, subjectDesc.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, difficultyDesc.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, options.hashCode);
    _$hash = $jc(_$hash, answer.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jc(_$hash, knowledgeTags.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QuestionResponse')
          ..add('id', id)
          ..add('type', type)
          ..add('typeDesc', typeDesc)
          ..add('subject', subject)
          ..add('subjectDesc', subjectDesc)
          ..add('grade', grade)
          ..add('difficulty', difficulty)
          ..add('difficultyDesc', difficultyDesc)
          ..add('content', content)
          ..add('options', options)
          ..add('answer', answer)
          ..add('explanation', explanation)
          ..add('knowledgeTags', knowledgeTags)
          ..add('imageUrl', imageUrl)
          ..add('source_', source_)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class QuestionResponseBuilder
    implements Builder<QuestionResponse, QuestionResponseBuilder> {
  _$QuestionResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _typeDesc;
  String? get typeDesc => _$this._typeDesc;
  set typeDesc(String? typeDesc) => _$this._typeDesc = typeDesc;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _subjectDesc;
  String? get subjectDesc => _$this._subjectDesc;
  set subjectDesc(String? subjectDesc) => _$this._subjectDesc = subjectDesc;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  String? _difficultyDesc;
  String? get difficultyDesc => _$this._difficultyDesc;
  set difficultyDesc(String? difficultyDesc) =>
      _$this._difficultyDesc = difficultyDesc;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _options;
  String? get options => _$this._options;
  set options(String? options) => _$this._options = options;

  String? _answer;
  String? get answer => _$this._answer;
  set answer(String? answer) => _$this._answer = answer;

  String? _explanation;
  String? get explanation => _$this._explanation;
  set explanation(String? explanation) => _$this._explanation = explanation;

  ListBuilder<String>? _knowledgeTags;
  ListBuilder<String> get knowledgeTags =>
      _$this._knowledgeTags ??= ListBuilder<String>();
  set knowledgeTags(ListBuilder<String>? knowledgeTags) =>
      _$this._knowledgeTags = knowledgeTags;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  QuestionResponseBuilder() {
    QuestionResponse._defaults(this);
  }

  QuestionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _typeDesc = $v.typeDesc;
      _subject = $v.subject;
      _subjectDesc = $v.subjectDesc;
      _grade = $v.grade;
      _difficulty = $v.difficulty;
      _difficultyDesc = $v.difficultyDesc;
      _content = $v.content;
      _options = $v.options;
      _answer = $v.answer;
      _explanation = $v.explanation;
      _knowledgeTags = $v.knowledgeTags?.toBuilder();
      _imageUrl = $v.imageUrl;
      _source_ = $v.source_;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QuestionResponse other) {
    _$v = other as _$QuestionResponse;
  }

  @override
  void update(void Function(QuestionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QuestionResponse build() => _build();

  _$QuestionResponse _build() {
    _$QuestionResponse _$result;
    try {
      _$result =
          _$v ??
          _$QuestionResponse._(
            id: id,
            type: type,
            typeDesc: typeDesc,
            subject: subject,
            subjectDesc: subjectDesc,
            grade: grade,
            difficulty: difficulty,
            difficultyDesc: difficultyDesc,
            content: content,
            options: options,
            answer: answer,
            explanation: explanation,
            knowledgeTags: _knowledgeTags?.build(),
            imageUrl: imageUrl,
            source_: source_,
            creatorId: creatorId,
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'knowledgeTags';
        _knowledgeTags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'QuestionResponse',
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
