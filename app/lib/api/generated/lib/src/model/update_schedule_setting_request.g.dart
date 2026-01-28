// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_schedule_setting_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateScheduleSettingRequest extends UpdateScheduleSettingRequest {
  @override
  final String semester;
  @override
  final Date startDate;
  @override
  final int? totalWeeks;
  @override
  final int? daysPerWeek;
  @override
  final int? sectionsPerDay;
  @override
  final BuiltList<TimeConfigItem>? timeConfig;

  factory _$UpdateScheduleSettingRequest([
    void Function(UpdateScheduleSettingRequestBuilder)? updates,
  ]) => (UpdateScheduleSettingRequestBuilder()..update(updates))._build();

  _$UpdateScheduleSettingRequest._({
    required this.semester,
    required this.startDate,
    this.totalWeeks,
    this.daysPerWeek,
    this.sectionsPerDay,
    this.timeConfig,
  }) : super._();
  @override
  UpdateScheduleSettingRequest rebuild(
    void Function(UpdateScheduleSettingRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateScheduleSettingRequestBuilder toBuilder() =>
      UpdateScheduleSettingRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateScheduleSettingRequest &&
        semester == other.semester &&
        startDate == other.startDate &&
        totalWeeks == other.totalWeeks &&
        daysPerWeek == other.daysPerWeek &&
        sectionsPerDay == other.sectionsPerDay &&
        timeConfig == other.timeConfig;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, semester.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, totalWeeks.hashCode);
    _$hash = $jc(_$hash, daysPerWeek.hashCode);
    _$hash = $jc(_$hash, sectionsPerDay.hashCode);
    _$hash = $jc(_$hash, timeConfig.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateScheduleSettingRequest')
          ..add('semester', semester)
          ..add('startDate', startDate)
          ..add('totalWeeks', totalWeeks)
          ..add('daysPerWeek', daysPerWeek)
          ..add('sectionsPerDay', sectionsPerDay)
          ..add('timeConfig', timeConfig))
        .toString();
  }
}

class UpdateScheduleSettingRequestBuilder
    implements
        Builder<
          UpdateScheduleSettingRequest,
          UpdateScheduleSettingRequestBuilder
        > {
  _$UpdateScheduleSettingRequest? _$v;

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

  UpdateScheduleSettingRequestBuilder() {
    UpdateScheduleSettingRequest._defaults(this);
  }

  UpdateScheduleSettingRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _semester = $v.semester;
      _startDate = $v.startDate;
      _totalWeeks = $v.totalWeeks;
      _daysPerWeek = $v.daysPerWeek;
      _sectionsPerDay = $v.sectionsPerDay;
      _timeConfig = $v.timeConfig?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateScheduleSettingRequest other) {
    _$v = other as _$UpdateScheduleSettingRequest;
  }

  @override
  void update(void Function(UpdateScheduleSettingRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateScheduleSettingRequest build() => _build();

  _$UpdateScheduleSettingRequest _build() {
    _$UpdateScheduleSettingRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateScheduleSettingRequest._(
            semester: BuiltValueNullFieldError.checkNotNull(
              semester,
              r'UpdateScheduleSettingRequest',
              'semester',
            ),
            startDate: BuiltValueNullFieldError.checkNotNull(
              startDate,
              r'UpdateScheduleSettingRequest',
              'startDate',
            ),
            totalWeeks: totalWeeks,
            daysPerWeek: daysPerWeek,
            sectionsPerDay: sectionsPerDay,
            timeConfig: _timeConfig?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'timeConfig';
        _timeConfig?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateScheduleSettingRequest',
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
