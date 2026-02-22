// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmissionStatusResponse extends SubmissionStatusResponse {
  @override
  final String? submissionId;
  @override
  final String? gradingMode;
  @override
  final String? title;
  @override
  final String? subject;
  @override
  final String? grade;
  @override
  final BuiltList<String>? imageUrls;
  @override
  final String? status;
  @override
  final String? examPaperId;
  @override
  final int? totalScore;
  @override
  final int? maxScore;
  @override
  final DateTime? createTime;

  factory _$SubmissionStatusResponse([
    void Function(SubmissionStatusResponseBuilder)? updates,
  ]) => (SubmissionStatusResponseBuilder()..update(updates))._build();

  _$SubmissionStatusResponse._({
    this.submissionId,
    this.gradingMode,
    this.title,
    this.subject,
    this.grade,
    this.imageUrls,
    this.status,
    this.examPaperId,
    this.totalScore,
    this.maxScore,
    this.createTime,
  }) : super._();
  @override
  SubmissionStatusResponse rebuild(
    void Function(SubmissionStatusResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubmissionStatusResponseBuilder toBuilder() =>
      SubmissionStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmissionStatusResponse &&
        submissionId == other.submissionId &&
        gradingMode == other.gradingMode &&
        title == other.title &&
        subject == other.subject &&
        grade == other.grade &&
        imageUrls == other.imageUrls &&
        status == other.status &&
        examPaperId == other.examPaperId &&
        totalScore == other.totalScore &&
        maxScore == other.maxScore &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, submissionId.hashCode);
    _$hash = $jc(_$hash, gradingMode.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, imageUrls.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, examPaperId.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, maxScore.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmissionStatusResponse')
          ..add('submissionId', submissionId)
          ..add('gradingMode', gradingMode)
          ..add('title', title)
          ..add('subject', subject)
          ..add('grade', grade)
          ..add('imageUrls', imageUrls)
          ..add('status', status)
          ..add('examPaperId', examPaperId)
          ..add('totalScore', totalScore)
          ..add('maxScore', maxScore)
          ..add('createTime', createTime))
        .toString();
  }
}

class SubmissionStatusResponseBuilder
    implements
        Builder<SubmissionStatusResponse, SubmissionStatusResponseBuilder> {
  _$SubmissionStatusResponse? _$v;

  String? _submissionId;
  String? get submissionId => _$this._submissionId;
  set submissionId(String? submissionId) => _$this._submissionId = submissionId;

  String? _gradingMode;
  String? get gradingMode => _$this._gradingMode;
  set gradingMode(String? gradingMode) => _$this._gradingMode = gradingMode;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  ListBuilder<String>? _imageUrls;
  ListBuilder<String> get imageUrls =>
      _$this._imageUrls ??= ListBuilder<String>();
  set imageUrls(ListBuilder<String>? imageUrls) =>
      _$this._imageUrls = imageUrls;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _examPaperId;
  String? get examPaperId => _$this._examPaperId;
  set examPaperId(String? examPaperId) => _$this._examPaperId = examPaperId;

  int? _totalScore;
  int? get totalScore => _$this._totalScore;
  set totalScore(int? totalScore) => _$this._totalScore = totalScore;

  int? _maxScore;
  int? get maxScore => _$this._maxScore;
  set maxScore(int? maxScore) => _$this._maxScore = maxScore;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  SubmissionStatusResponseBuilder() {
    SubmissionStatusResponse._defaults(this);
  }

  SubmissionStatusResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _submissionId = $v.submissionId;
      _gradingMode = $v.gradingMode;
      _title = $v.title;
      _subject = $v.subject;
      _grade = $v.grade;
      _imageUrls = $v.imageUrls?.toBuilder();
      _status = $v.status;
      _examPaperId = $v.examPaperId;
      _totalScore = $v.totalScore;
      _maxScore = $v.maxScore;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmissionStatusResponse other) {
    _$v = other as _$SubmissionStatusResponse;
  }

  @override
  void update(void Function(SubmissionStatusResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmissionStatusResponse build() => _build();

  _$SubmissionStatusResponse _build() {
    _$SubmissionStatusResponse _$result;
    try {
      _$result =
          _$v ??
          _$SubmissionStatusResponse._(
            submissionId: submissionId,
            gradingMode: gradingMode,
            title: title,
            subject: subject,
            grade: grade,
            imageUrls: _imageUrls?.build(),
            status: status,
            examPaperId: examPaperId,
            totalScore: totalScore,
            maxScore: maxScore,
            createTime: createTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageUrls';
        _imageUrls?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmissionStatusResponse',
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
