// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_schedule_item_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddScheduleItemRequest extends AddScheduleItemRequest {
  @override
  final int settingId;
  @override
  final int courseType;
  @override
  final int dayOfWeek;
  @override
  final int startSection;
  @override
  final int endSection;
  @override
  final String? courseName;
  @override
  final String? teacherName;
  @override
  final int? courseId;
  @override
  final int? teacherId;
  @override
  final String? location;
  @override
  final int? startWeek;
  @override
  final int? endWeek;
  @override
  final int? weekType;
  @override
  final String? color;
  @override
  final String? remark;

  factory _$AddScheduleItemRequest([
    void Function(AddScheduleItemRequestBuilder)? updates,
  ]) => (AddScheduleItemRequestBuilder()..update(updates))._build();

  _$AddScheduleItemRequest._({
    required this.settingId,
    required this.courseType,
    required this.dayOfWeek,
    required this.startSection,
    required this.endSection,
    this.courseName,
    this.teacherName,
    this.courseId,
    this.teacherId,
    this.location,
    this.startWeek,
    this.endWeek,
    this.weekType,
    this.color,
    this.remark,
  }) : super._();
  @override
  AddScheduleItemRequest rebuild(
    void Function(AddScheduleItemRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddScheduleItemRequestBuilder toBuilder() =>
      AddScheduleItemRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddScheduleItemRequest &&
        settingId == other.settingId &&
        courseType == other.courseType &&
        dayOfWeek == other.dayOfWeek &&
        startSection == other.startSection &&
        endSection == other.endSection &&
        courseName == other.courseName &&
        teacherName == other.teacherName &&
        courseId == other.courseId &&
        teacherId == other.teacherId &&
        location == other.location &&
        startWeek == other.startWeek &&
        endWeek == other.endWeek &&
        weekType == other.weekType &&
        color == other.color &&
        remark == other.remark;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, settingId.hashCode);
    _$hash = $jc(_$hash, courseType.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startSection.hashCode);
    _$hash = $jc(_$hash, endSection.hashCode);
    _$hash = $jc(_$hash, courseName.hashCode);
    _$hash = $jc(_$hash, teacherName.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, teacherId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, startWeek.hashCode);
    _$hash = $jc(_$hash, endWeek.hashCode);
    _$hash = $jc(_$hash, weekType.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, remark.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddScheduleItemRequest')
          ..add('settingId', settingId)
          ..add('courseType', courseType)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startSection', startSection)
          ..add('endSection', endSection)
          ..add('courseName', courseName)
          ..add('teacherName', teacherName)
          ..add('courseId', courseId)
          ..add('teacherId', teacherId)
          ..add('location', location)
          ..add('startWeek', startWeek)
          ..add('endWeek', endWeek)
          ..add('weekType', weekType)
          ..add('color', color)
          ..add('remark', remark))
        .toString();
  }
}

class AddScheduleItemRequestBuilder
    implements Builder<AddScheduleItemRequest, AddScheduleItemRequestBuilder> {
  _$AddScheduleItemRequest? _$v;

  int? _settingId;
  int? get settingId => _$this._settingId;
  set settingId(int? settingId) => _$this._settingId = settingId;

  int? _courseType;
  int? get courseType => _$this._courseType;
  set courseType(int? courseType) => _$this._courseType = courseType;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

  int? _startSection;
  int? get startSection => _$this._startSection;
  set startSection(int? startSection) => _$this._startSection = startSection;

  int? _endSection;
  int? get endSection => _$this._endSection;
  set endSection(int? endSection) => _$this._endSection = endSection;

  String? _courseName;
  String? get courseName => _$this._courseName;
  set courseName(String? courseName) => _$this._courseName = courseName;

  String? _teacherName;
  String? get teacherName => _$this._teacherName;
  set teacherName(String? teacherName) => _$this._teacherName = teacherName;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  int? _teacherId;
  int? get teacherId => _$this._teacherId;
  set teacherId(int? teacherId) => _$this._teacherId = teacherId;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  int? _startWeek;
  int? get startWeek => _$this._startWeek;
  set startWeek(int? startWeek) => _$this._startWeek = startWeek;

  int? _endWeek;
  int? get endWeek => _$this._endWeek;
  set endWeek(int? endWeek) => _$this._endWeek = endWeek;

  int? _weekType;
  int? get weekType => _$this._weekType;
  set weekType(int? weekType) => _$this._weekType = weekType;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _remark;
  String? get remark => _$this._remark;
  set remark(String? remark) => _$this._remark = remark;

  AddScheduleItemRequestBuilder() {
    AddScheduleItemRequest._defaults(this);
  }

  AddScheduleItemRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _settingId = $v.settingId;
      _courseType = $v.courseType;
      _dayOfWeek = $v.dayOfWeek;
      _startSection = $v.startSection;
      _endSection = $v.endSection;
      _courseName = $v.courseName;
      _teacherName = $v.teacherName;
      _courseId = $v.courseId;
      _teacherId = $v.teacherId;
      _location = $v.location;
      _startWeek = $v.startWeek;
      _endWeek = $v.endWeek;
      _weekType = $v.weekType;
      _color = $v.color;
      _remark = $v.remark;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddScheduleItemRequest other) {
    _$v = other as _$AddScheduleItemRequest;
  }

  @override
  void update(void Function(AddScheduleItemRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddScheduleItemRequest build() => _build();

  _$AddScheduleItemRequest _build() {
    final _$result =
        _$v ??
        _$AddScheduleItemRequest._(
          settingId: BuiltValueNullFieldError.checkNotNull(
            settingId,
            r'AddScheduleItemRequest',
            'settingId',
          ),
          courseType: BuiltValueNullFieldError.checkNotNull(
            courseType,
            r'AddScheduleItemRequest',
            'courseType',
          ),
          dayOfWeek: BuiltValueNullFieldError.checkNotNull(
            dayOfWeek,
            r'AddScheduleItemRequest',
            'dayOfWeek',
          ),
          startSection: BuiltValueNullFieldError.checkNotNull(
            startSection,
            r'AddScheduleItemRequest',
            'startSection',
          ),
          endSection: BuiltValueNullFieldError.checkNotNull(
            endSection,
            r'AddScheduleItemRequest',
            'endSection',
          ),
          courseName: courseName,
          teacherName: teacherName,
          courseId: courseId,
          teacherId: teacherId,
          location: location,
          startWeek: startWeek,
          endWeek: endWeek,
          weekType: weekType,
          color: color,
          remark: remark,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
