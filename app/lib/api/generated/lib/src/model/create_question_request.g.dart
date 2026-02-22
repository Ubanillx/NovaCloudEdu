// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_question_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateQuestionRequest extends CreateQuestionRequest {
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
  @override
  final String? source_;

  factory _$CreateQuestionRequest([
    void Function(CreateQuestionRequestBuilder)? updates,
  ]) => (CreateQuestionRequestBuilder()..update(updates))._build();

  _$CreateQuestionRequest._({
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
    this.source_,
  }) : super._();
  @override
  CreateQuestionRequest rebuild(
    void Function(CreateQuestionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateQuestionRequestBuilder toBuilder() =>
      CreateQuestionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateQuestionRequest &&
        type == other.type &&
        subject == other.subject &&
        difficulty == other.difficulty &&
        content == other.content &&
        answer == other.answer &&
        grade == other.grade &&
        options == other.options &&
        explanation == other.explanation &&
        knowledgeTags == other.knowledgeTags &&
        imageUrl == other.imageUrl &&
        source_ == other.source_;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateQuestionRequest')
          ..add('type', type)
          ..add('subject', subject)
          ..add('difficulty', difficulty)
          ..add('content', content)
          ..add('answer', answer)
          ..add('grade', grade)
          ..add('options', options)
          ..add('explanation', explanation)
          ..add('knowledgeTags', knowledgeTags)
          ..add('imageUrl', imageUrl)
          ..add('source_', source_))
        .toString();
  }
}

class CreateQuestionRequestBuilder
    implements Builder<CreateQuestionRequest, CreateQuestionRequestBuilder> {
  _$CreateQuestionRequest? _$v;

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

  String? _source_;
  String? get source_ => _$this._source_;
  set source_(String? source_) => _$this._source_ = source_;

  CreateQuestionRequestBuilder() {
    CreateQuestionRequest._defaults(this);
  }

  CreateQuestionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
      _source_ = $v.source_;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateQuestionRequest other) {
    _$v = other as _$CreateQuestionRequest;
  }

  @override
  void update(void Function(CreateQuestionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateQuestionRequest build() => _build();

  _$CreateQuestionRequest _build() {
    _$CreateQuestionRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateQuestionRequest._(
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'CreateQuestionRequest',
              'type',
            ),
            subject: BuiltValueNullFieldError.checkNotNull(
              subject,
              r'CreateQuestionRequest',
              'subject',
            ),
            difficulty: BuiltValueNullFieldError.checkNotNull(
              difficulty,
              r'CreateQuestionRequest',
              'difficulty',
            ),
            content: BuiltValueNullFieldError.checkNotNull(
              content,
              r'CreateQuestionRequest',
              'content',
            ),
            answer: BuiltValueNullFieldError.checkNotNull(
              answer,
              r'CreateQuestionRequest',
              'answer',
            ),
            grade: grade,
            options: options,
            explanation: explanation,
            knowledgeTags: _knowledgeTags?.build(),
            imageUrl: imageUrl,
            source_: source_,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'knowledgeTags';
        _knowledgeTags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateQuestionRequest',
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
