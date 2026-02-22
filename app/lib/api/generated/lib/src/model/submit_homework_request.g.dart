// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_homework_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SubmitHomeworkRequest extends SubmitHomeworkRequest {
  @override
  final BuiltList<String> imageUrls;
  @override
  final String? gradingMode;
  @override
  final String? title;
  @override
  final String? subject;
  @override
  final String? grade;
  @override
  final int? classId;
  @override
  final int? examPaperId;

  factory _$SubmitHomeworkRequest([
    void Function(SubmitHomeworkRequestBuilder)? updates,
  ]) => (SubmitHomeworkRequestBuilder()..update(updates))._build();

  _$SubmitHomeworkRequest._({
    required this.imageUrls,
    this.gradingMode,
    this.title,
    this.subject,
    this.grade,
    this.classId,
    this.examPaperId,
  }) : super._();
  @override
  SubmitHomeworkRequest rebuild(
    void Function(SubmitHomeworkRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SubmitHomeworkRequestBuilder toBuilder() =>
      SubmitHomeworkRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubmitHomeworkRequest &&
        imageUrls == other.imageUrls &&
        gradingMode == other.gradingMode &&
        title == other.title &&
        subject == other.subject &&
        grade == other.grade &&
        classId == other.classId &&
        examPaperId == other.examPaperId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, imageUrls.hashCode);
    _$hash = $jc(_$hash, gradingMode.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, examPaperId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SubmitHomeworkRequest')
          ..add('imageUrls', imageUrls)
          ..add('gradingMode', gradingMode)
          ..add('title', title)
          ..add('subject', subject)
          ..add('grade', grade)
          ..add('classId', classId)
          ..add('examPaperId', examPaperId))
        .toString();
  }
}

class SubmitHomeworkRequestBuilder
    implements Builder<SubmitHomeworkRequest, SubmitHomeworkRequestBuilder> {
  _$SubmitHomeworkRequest? _$v;

  ListBuilder<String>? _imageUrls;
  ListBuilder<String> get imageUrls =>
      _$this._imageUrls ??= ListBuilder<String>();
  set imageUrls(ListBuilder<String>? imageUrls) =>
      _$this._imageUrls = imageUrls;

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

  int? _classId;
  int? get classId => _$this._classId;
  set classId(int? classId) => _$this._classId = classId;

  int? _examPaperId;
  int? get examPaperId => _$this._examPaperId;
  set examPaperId(int? examPaperId) => _$this._examPaperId = examPaperId;

  SubmitHomeworkRequestBuilder() {
    SubmitHomeworkRequest._defaults(this);
  }

  SubmitHomeworkRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageUrls = $v.imageUrls.toBuilder();
      _gradingMode = $v.gradingMode;
      _title = $v.title;
      _subject = $v.subject;
      _grade = $v.grade;
      _classId = $v.classId;
      _examPaperId = $v.examPaperId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubmitHomeworkRequest other) {
    _$v = other as _$SubmitHomeworkRequest;
  }

  @override
  void update(void Function(SubmitHomeworkRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SubmitHomeworkRequest build() => _build();

  _$SubmitHomeworkRequest _build() {
    _$SubmitHomeworkRequest _$result;
    try {
      _$result =
          _$v ??
          _$SubmitHomeworkRequest._(
            imageUrls: imageUrls.build(),
            gradingMode: gradingMode,
            title: title,
            subject: subject,
            grade: grade,
            classId: classId,
            examPaperId: examPaperId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageUrls';
        imageUrls.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SubmitHomeworkRequest',
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
