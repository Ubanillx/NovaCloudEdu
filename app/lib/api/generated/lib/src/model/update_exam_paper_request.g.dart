// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_exam_paper_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateExamPaperRequest extends UpdateExamPaperRequest {
  @override
  final int id;
  @override
  final String title;
  @override
  final String subject;
  @override
  final String? subtitle;
  @override
  final String? grade;
  @override
  final int? durationMin;
  @override
  final String? layout;
  @override
  final int? templateId;

  factory _$UpdateExamPaperRequest([
    void Function(UpdateExamPaperRequestBuilder)? updates,
  ]) => (UpdateExamPaperRequestBuilder()..update(updates))._build();

  _$UpdateExamPaperRequest._({
    required this.id,
    required this.title,
    required this.subject,
    this.subtitle,
    this.grade,
    this.durationMin,
    this.layout,
    this.templateId,
  }) : super._();
  @override
  UpdateExamPaperRequest rebuild(
    void Function(UpdateExamPaperRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateExamPaperRequestBuilder toBuilder() =>
      UpdateExamPaperRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateExamPaperRequest &&
        id == other.id &&
        title == other.title &&
        subject == other.subject &&
        subtitle == other.subtitle &&
        grade == other.grade &&
        durationMin == other.durationMin &&
        layout == other.layout &&
        templateId == other.templateId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, durationMin.hashCode);
    _$hash = $jc(_$hash, layout.hashCode);
    _$hash = $jc(_$hash, templateId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateExamPaperRequest')
          ..add('id', id)
          ..add('title', title)
          ..add('subject', subject)
          ..add('subtitle', subtitle)
          ..add('grade', grade)
          ..add('durationMin', durationMin)
          ..add('layout', layout)
          ..add('templateId', templateId))
        .toString();
  }
}

class UpdateExamPaperRequestBuilder
    implements Builder<UpdateExamPaperRequest, UpdateExamPaperRequestBuilder> {
  _$UpdateExamPaperRequest? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  int? _durationMin;
  int? get durationMin => _$this._durationMin;
  set durationMin(int? durationMin) => _$this._durationMin = durationMin;

  String? _layout;
  String? get layout => _$this._layout;
  set layout(String? layout) => _$this._layout = layout;

  int? _templateId;
  int? get templateId => _$this._templateId;
  set templateId(int? templateId) => _$this._templateId = templateId;

  UpdateExamPaperRequestBuilder() {
    UpdateExamPaperRequest._defaults(this);
  }

  UpdateExamPaperRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _subject = $v.subject;
      _subtitle = $v.subtitle;
      _grade = $v.grade;
      _durationMin = $v.durationMin;
      _layout = $v.layout;
      _templateId = $v.templateId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateExamPaperRequest other) {
    _$v = other as _$UpdateExamPaperRequest;
  }

  @override
  void update(void Function(UpdateExamPaperRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateExamPaperRequest build() => _build();

  _$UpdateExamPaperRequest _build() {
    final _$result =
        _$v ??
        _$UpdateExamPaperRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'UpdateExamPaperRequest',
            'id',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'UpdateExamPaperRequest',
            'title',
          ),
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'UpdateExamPaperRequest',
            'subject',
          ),
          subtitle: subtitle,
          grade: grade,
          durationMin: durationMin,
          layout: layout,
          templateId: templateId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
