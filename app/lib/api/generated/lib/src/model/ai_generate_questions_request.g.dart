// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_generate_questions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AiGenerateQuestionsRequest extends AiGenerateQuestionsRequest {
  @override
  final String subject;
  @override
  final String type;
  @override
  final int difficulty;
  @override
  final int count;
  @override
  final String? grade;
  @override
  final String? topic;
  @override
  final bool? withDiagram;
  @override
  final bool? withImage;
  @override
  final bool? enableWebSearch;
  @override
  final String? modelId;
  @override
  final String? userInput;

  factory _$AiGenerateQuestionsRequest([
    void Function(AiGenerateQuestionsRequestBuilder)? updates,
  ]) => (AiGenerateQuestionsRequestBuilder()..update(updates))._build();

  _$AiGenerateQuestionsRequest._({
    required this.subject,
    required this.type,
    required this.difficulty,
    required this.count,
    this.grade,
    this.topic,
    this.withDiagram,
    this.withImage,
    this.enableWebSearch,
    this.modelId,
    this.userInput,
  }) : super._();
  @override
  AiGenerateQuestionsRequest rebuild(
    void Function(AiGenerateQuestionsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AiGenerateQuestionsRequestBuilder toBuilder() =>
      AiGenerateQuestionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AiGenerateQuestionsRequest &&
        subject == other.subject &&
        type == other.type &&
        difficulty == other.difficulty &&
        count == other.count &&
        grade == other.grade &&
        topic == other.topic &&
        withDiagram == other.withDiagram &&
        withImage == other.withImage &&
        enableWebSearch == other.enableWebSearch &&
        modelId == other.modelId &&
        userInput == other.userInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, topic.hashCode);
    _$hash = $jc(_$hash, withDiagram.hashCode);
    _$hash = $jc(_$hash, withImage.hashCode);
    _$hash = $jc(_$hash, enableWebSearch.hashCode);
    _$hash = $jc(_$hash, modelId.hashCode);
    _$hash = $jc(_$hash, userInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AiGenerateQuestionsRequest')
          ..add('subject', subject)
          ..add('type', type)
          ..add('difficulty', difficulty)
          ..add('count', count)
          ..add('grade', grade)
          ..add('topic', topic)
          ..add('withDiagram', withDiagram)
          ..add('withImage', withImage)
          ..add('enableWebSearch', enableWebSearch)
          ..add('modelId', modelId)
          ..add('userInput', userInput))
        .toString();
  }
}

class AiGenerateQuestionsRequestBuilder
    implements
        Builder<AiGenerateQuestionsRequest, AiGenerateQuestionsRequestBuilder> {
  _$AiGenerateQuestionsRequest? _$v;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  String? _topic;
  String? get topic => _$this._topic;
  set topic(String? topic) => _$this._topic = topic;

  bool? _withDiagram;
  bool? get withDiagram => _$this._withDiagram;
  set withDiagram(bool? withDiagram) => _$this._withDiagram = withDiagram;

  bool? _withImage;
  bool? get withImage => _$this._withImage;
  set withImage(bool? withImage) => _$this._withImage = withImage;

  bool? _enableWebSearch;
  bool? get enableWebSearch => _$this._enableWebSearch;
  set enableWebSearch(bool? enableWebSearch) =>
      _$this._enableWebSearch = enableWebSearch;

  String? _modelId;
  String? get modelId => _$this._modelId;
  set modelId(String? modelId) => _$this._modelId = modelId;

  String? _userInput;
  String? get userInput => _$this._userInput;
  set userInput(String? userInput) => _$this._userInput = userInput;

  AiGenerateQuestionsRequestBuilder() {
    AiGenerateQuestionsRequest._defaults(this);
  }

  AiGenerateQuestionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _subject = $v.subject;
      _type = $v.type;
      _difficulty = $v.difficulty;
      _count = $v.count;
      _grade = $v.grade;
      _topic = $v.topic;
      _withDiagram = $v.withDiagram;
      _withImage = $v.withImage;
      _enableWebSearch = $v.enableWebSearch;
      _modelId = $v.modelId;
      _userInput = $v.userInput;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AiGenerateQuestionsRequest other) {
    _$v = other as _$AiGenerateQuestionsRequest;
  }

  @override
  void update(void Function(AiGenerateQuestionsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AiGenerateQuestionsRequest build() => _build();

  _$AiGenerateQuestionsRequest _build() {
    final _$result =
        _$v ??
        _$AiGenerateQuestionsRequest._(
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'AiGenerateQuestionsRequest',
            'subject',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'AiGenerateQuestionsRequest',
            'type',
          ),
          difficulty: BuiltValueNullFieldError.checkNotNull(
            difficulty,
            r'AiGenerateQuestionsRequest',
            'difficulty',
          ),
          count: BuiltValueNullFieldError.checkNotNull(
            count,
            r'AiGenerateQuestionsRequest',
            'count',
          ),
          grade: grade,
          topic: topic,
          withDiagram: withDiagram,
          withImage: withImage,
          enableWebSearch: enableWebSearch,
          modelId: modelId,
          userInput: userInput,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
