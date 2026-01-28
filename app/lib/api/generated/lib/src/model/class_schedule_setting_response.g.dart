// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_schedule_setting_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassScheduleSettingResponse extends ClassScheduleSettingResponse {
  @override
  final String? id;
  @override
  final String? classId;
  @override
  final String? semester;
  @override
  final Date? startDate;
  @override
  final int? totalWeeks;
  @override
  final int? daysPerWeek;
  @override
  final int? sectionsPerDay;
  @override
  final BuiltList<TimeConfigItem>? timeConfig;
  @override
  final bool? isActive;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ClassScheduleSettingResponse([
    void Function(ClassScheduleSettingResponseBuilder)? updates,
  ]) => (ClassScheduleSettingResponseBuilder()..update(updates))._build();

  _$ClassScheduleSettingResponse._({
    this.id,
    this.classId,
    this.semester,
    this.startDate,
    this.totalWeeks,
    this.daysPerWeek,
    this.sectionsPerDay,
    this.timeConfig,
    this.isActive,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ClassScheduleSettingResponse rebuild(
    void Function(ClassScheduleSettingResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ClassScheduleSettingResponseBuilder toBuilder() =>
      ClassScheduleSettingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassScheduleSettingResponse &&
        id == other.id &&
        classId == other.classId &&
        semester == other.semester &&
        startDate == other.startDate &&
        totalWeeks == other.totalWeeks &&
        daysPerWeek == other.daysPerWeek &&
        sectionsPerDay == other.sectionsPerDay &&
        timeConfig == other.timeConfig &&
        isActive == other.isActive &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, semester.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, totalWeeks.hashCode);
    _$hash = $jc(_$hash, daysPerWeek.hashCode);
    _$hash = $jc(_$hash, sectionsPerDay.hashCode);
    _$hash = $jc(_$hash, timeConfig.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassScheduleSettingResponse')
          ..add('id', id)
          ..add('classId', classId)
          ..add('semester', semester)
          ..add('startDate', startDate)
          ..add('totalWeeks', totalWeeks)
          ..add('daysPerWeek', daysPerWeek)
          ..add('sectionsPerDay', sectionsPerDay)
          ..add('timeConfig', timeConfig)
          ..add('isActive', isActive)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ClassScheduleSettingResponseBuilder
    implements
        Builder<
          ClassScheduleSettingResponse,
          ClassScheduleSettingResponseBuilder
        > {
  _$ClassScheduleSettingResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  String? _semester;
  String? get semester => _$this._semester;
  set semester(String? semester) => _$this._semester = semester;

  Date? _startDate;
  Date? get startDate => _$this._startDate;
  set startDate(Date? startDate) => _$this._startDate = startDate;

  int? _totalWeeks;
  int? get totalWeeks => _$this._totalWeeks;
  set totalWeeks(int? totalWeeks) => _$this._totalWeeks = totalWeeks;

  int? _daysPerWeek;
  int? get daysPerWeek => _$this._daysPerWeek;
  set daysPerWeek(int? daysPerWeek) => _$this._daysPerWeek = daysPerWeek;

  int? _sectionsPerDay;
  int? get sectionsPerDay => _$this._sectionsPerDay;
  set sectionsPerDay(int? sectionsPerDay) =>
      _$this._sectionsPerDay = sectionsPerDay;

  ListBuilder<TimeConfigItem>? _timeConfig;
  ListBuilder<TimeConfigItem> get timeConfig =>
      _$this._timeConfig ??= ListBuilder<TimeConfigItem>();
  set timeConfig(ListBuilder<TimeConfigItem>? timeConfig) =>
      _$this._timeConfig = timeConfig;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ClassScheduleSettingResponseBuilder() {
    ClassScheduleSettingResponse._defaults(this);
  }

  ClassScheduleSettingResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _classId = $v.classId;
      _semester = $v.semester;
      _startDate = $v.startDate;
      _totalWeeks = $v.totalWeeks;
      _daysPerWeek = $v.daysPerWeek;
      _sectionsPerDay = $v.sectionsPerDay;
      _timeConfig = $v.timeConfig?.toBuilder();
      _isActive = $v.isActive;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassScheduleSettingResponse other) {
    _$v = other as _$ClassScheduleSettingResponse;
  }

  @override
  void update(void Function(ClassScheduleSettingResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassScheduleSettingResponse build() => _build();

  _$ClassScheduleSettingResponse _build() {
    _$ClassScheduleSettingResponse _$result;
    try {
      _$result =
          _$v ??
          _$ClassScheduleSettingResponse._(
            id: id,
            classId: classId,
            semester: semester,
            startDate: startDate,
            totalWeeks: totalWeeks,
            daysPerWeek: daysPerWeek,
            sectionsPerDay: sectionsPerDay,
            timeConfig: _timeConfig?.build(),
            isActive: isActive,
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'timeConfig';
        _timeConfig?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ClassScheduleSettingResponse',
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
