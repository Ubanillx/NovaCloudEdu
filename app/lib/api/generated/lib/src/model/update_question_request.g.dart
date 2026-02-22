// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_question_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateQuestionRequest extends UpdateQuestionRequest {
  @override
  final int id;
  @override
  final String type;
  @override
  final String subject;
  @override
  final int difficulty;
  @override
  final String content;
  @override
  final String answer;
  @override
  final String? grade;
  @override
  final String? options;
  @override
  final String? explanation;
  @override
  final BuiltList<String>? knowledgeTags;
  @override
  final String? imageUrl;

  factory _$UpdateQuestionRequest([
    void Function(UpdateQuestionRequestBuilder)? updates,
  ]) => (UpdateQuestionRequestBuilder()..update(updates))._build();

  _$UpdateQuestionRequest._({
    required this.id,
    required this.type,
    required this.subject,
    required this.difficulty,
    required this.content,
    required this.answer,
    this.grade,
    this.options,
    this.explanation,
    this.knowledgeTags,
    this.imageUrl,
  }) : super._();
  @override
  UpdateQuestionRequest rebuild(
    void Function(UpdateQuestionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateQuestionRequestBuilder toBuilder() =>
      UpdateQuestionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateQuestionRequest &&
        id == other.id &&
        type == other.type &&
        subject == other.subject &&
        difficulty == other.difficulty &&
        content == other.content &&
        answer == other.answer &&
        grade == other.grade &&
        options == other.options &&
        explanation == other.explanation &&
        knowledgeTags == other.knowledgeTags &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, answer.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, options.hashCode);
    _$hash = $jc(_$hash, explanation.hashCode);
    _$hash = $jc(_$hash, knowledgeTags.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateQuestionRequest')
          ..add('id', id)
          ..add('type', type)
          ..add('subject', subject)
          ..add('difficulty', difficulty)
          ..add('content', content)
          ..add('answer', answer)
          ..add('grade', grade)
          ..add('options', options)
          ..add('explanation', explanation)
          ..add('knowledgeTags', knowledgeTags)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class UpdateQuestionRequestBuilder
    implements Builder<UpdateQuestionRequest, UpdateQuestionRequestBuilder> {
  _$UpdateQuestionRequest? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _answer;
  String? get answer => _$this._answer;
  set answer(String? answer) => _$this._answer = answer;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  String? _options;
  String? get options => _$this._options;
  set options(String? options) => _$this._options = options;

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

  UpdateQuestionRequestBuilder() {
    UpdateQuestionRequest._defaults(this);
  }

  UpdateQuestionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _subject = $v.subject;
      _difficulty = $v.difficulty;
      _content = $v.content;
      _answer = $v.answer;
      _grade = $v.grade;
      _options = $v.options;
      _explanation = $v.explanation;
      _knowledgeTags = $v.knowledgeTags?.toBuilder();
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateQuestionRequest other) {
    _$v = other as _$UpdateQuestionRequest;
  }

  @override
  void update(void Function(UpdateQuestionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateQuestionRequest build() => _build();

  _$UpdateQuestionRequest _build() {
    _$UpdateQuestionRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateQuestionRequest._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'UpdateQuestionRequest',
              'id',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'UpdateQuestionRequest',
              'type',
            ),
            subject: BuiltValueNullFieldError.checkNotNull(
              subject,
              r'UpdateQuestionRequest',
              'subject',
            ),
            difficulty: BuiltValueNullFieldError.checkNotNull(
              difficulty,
              r'UpdateQuestionRequest',
              'difficulty',
            ),
            content: BuiltValueNullFieldError.checkNotNull(
              content,
              r'UpdateQuestionRequest',
              'content',
            ),
            answer: BuiltValueNullFieldError.checkNotNull(
              answer,
              r'UpdateQuestionRequest',
              'answer',
            ),
            grade: grade,
            options: options,
            explanation: explanation,
            knowledgeTags: _knowledgeTags?.build(),
            imageUrl: imageUrl,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'knowledgeTags';
        _knowledgeTags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateQuestionRequest',
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
