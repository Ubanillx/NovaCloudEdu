// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_paper_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExamPaperResponse extends ExamPaperResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? subject;
  @override
  final String? subjectDesc;
  @override
  final String? grade;
  @override
  final int? totalScore;
  @override
  final int? durationMin;
  @override
  final String? layout;
  @override
  final String? status;
  @override
  final String? statusDesc;
  @override
  final int? templateId;
  @override
  final int? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ExamPaperResponse([
    void Function(ExamPaperResponseBuilder)? updates,
  ]) => (ExamPaperResponseBuilder()..update(updates))._build();

  _$ExamPaperResponse._({
    this.id,
    this.title,
    this.subtitle,
    this.subject,
    this.subjectDesc,
    this.grade,
    this.totalScore,
    this.durationMin,
    this.layout,
    this.status,
    this.statusDesc,
    this.templateId,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ExamPaperResponse rebuild(void Function(ExamPaperResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExamPaperResponseBuilder toBuilder() =>
      ExamPaperResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExamPaperResponse &&
        id == other.id &&
        title == other.title &&
        subtitle == other.subtitle &&
        subject == other.subject &&
        subjectDesc == other.subjectDesc &&
        grade == other.grade &&
        totalScore == other.totalScore &&
        durationMin == other.durationMin &&
        layout == other.layout &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        templateId == other.templateId &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, subjectDesc.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, durationMin.hashCode);
    _$hash = $jc(_$hash, layout.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, templateId.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExamPaperResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('subtitle', subtitle)
          ..add('subject', subject)
          ..add('subjectDesc', subjectDesc)
          ..add('grade', grade)
          ..add('totalScore', totalScore)
          ..add('durationMin', durationMin)
          ..add('layout', layout)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('templateId', templateId)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ExamPaperResponseBuilder
    implements Builder<ExamPaperResponse, ExamPaperResponseBuilder> {
  _$ExamPaperResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _subjectDesc;
  String? get subjectDesc => _$this._subjectDesc;
  set subjectDesc(String? subjectDesc) => _$this._subjectDesc = subjectDesc;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  int? _totalScore;
  int? get totalScore => _$this._totalScore;
  set totalScore(int? totalScore) => _$this._totalScore = totalScore;

  int? _durationMin;
  int? get durationMin => _$this._durationMin;
  set durationMin(int? durationMin) => _$this._durationMin = durationMin;

  String? _layout;
  String? get layout => _$this._layout;
  set layout(String? layout) => _$this._layout = layout;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _statusDesc;
  String? get statusDesc => _$this._statusDesc;
  set statusDesc(String? statusDesc) => _$this._statusDesc = statusDesc;

  int? _templateId;
  int? get templateId => _$this._templateId;
  set templateId(int? templateId) => _$this._templateId = templateId;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ExamPaperResponseBuilder() {
    ExamPaperResponse._defaults(this);
  }

  ExamPaperResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _subtitle = $v.subtitle;
      _subject = $v.subject;
      _subjectDesc = $v.subjectDesc;
      _grade = $v.grade;
      _totalScore = $v.totalScore;
      _durationMin = $v.durationMin;
      _layout = $v.layout;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _templateId = $v.templateId;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExamPaperResponse other) {
    _$v = other as _$ExamPaperResponse;
  }

  @override
  void update(void Function(ExamPaperResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExamPaperResponse build() => _build();

  _$ExamPaperResponse _build() {
    final _$result =
        _$v ??
        _$ExamPaperResponse._(
          id: id,
          title: title,
          subtitle: subtitle,
          subject: subject,
          subjectDesc: subjectDesc,
          grade: grade,
          totalScore: totalScore,
          durationMin: durationMin,
          layout: layout,
          status: status,
          statusDesc: statusDesc,
          templateId: templateId,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
