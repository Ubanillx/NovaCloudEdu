// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_schedule_item_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassScheduleItemResponse extends ClassScheduleItemResponse {
  @override
  final String? id;
  @override
  final String? settingId;
  @override
  final String? classId;
  @override
  final String? userId;
  @override
  final int? courseType;
  @override
  final String? courseTypeDesc;
  @override
  final String? courseName;
  @override
  final String? teacherName;
  @override
  final String? location;
  @override
  final String? courseId;
  @override
  final String? teacherId;
  @override
  final int? dayOfWeek;
  @override
  final int? startSection;
  @override
  final int? endSection;
  @override
  final int? startWeek;
  @override
  final int? endWeek;
  @override
  final int? weekType;
  @override
  final String? weekTypeDesc;
  @override
  final String? color;
  @override
  final String? remark;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ClassScheduleItemResponse([
    void Function(ClassScheduleItemResponseBuilder)? updates,
  ]) => (ClassScheduleItemResponseBuilder()..update(updates))._build();

  _$ClassScheduleItemResponse._({
    this.id,
    this.settingId,
    this.classId,
    this.userId,
    this.courseType,
    this.courseTypeDesc,
    this.courseName,
    this.teacherName,
    this.location,
    this.courseId,
    this.teacherId,
    this.dayOfWeek,
    this.startSection,
    this.endSection,
    this.startWeek,
    this.endWeek,
    this.weekType,
    this.weekTypeDesc,
    this.color,
    this.remark,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ClassScheduleItemResponse rebuild(
    void Function(ClassScheduleItemResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ClassScheduleItemResponseBuilder toBuilder() =>
      ClassScheduleItemResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassScheduleItemResponse &&
        id == other.id &&
        settingId == other.settingId &&
        classId == other.classId &&
        userId == other.userId &&
        courseType == other.courseType &&
        courseTypeDesc == other.courseTypeDesc &&
        courseName == other.courseName &&
        teacherName == other.teacherName &&
        location == other.location &&
        courseId == other.courseId &&
        teacherId == other.teacherId &&
        dayOfWeek == other.dayOfWeek &&
        startSection == other.startSection &&
        endSection == other.endSection &&
        startWeek == other.startWeek &&
        endWeek == other.endWeek &&
        weekType == other.weekType &&
        weekTypeDesc == other.weekTypeDesc &&
        color == other.color &&
        remark == other.remark &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, settingId.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, courseType.hashCode);
    _$hash = $jc(_$hash, courseTypeDesc.hashCode);
    _$hash = $jc(_$hash, courseName.hashCode);
    _$hash = $jc(_$hash, teacherName.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, teacherId.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startSection.hashCode);
    _$hash = $jc(_$hash, endSection.hashCode);
    _$hash = $jc(_$hash, startWeek.hashCode);
    _$hash = $jc(_$hash, endWeek.hashCode);
    _$hash = $jc(_$hash, weekType.hashCode);
    _$hash = $jc(_$hash, weekTypeDesc.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, remark.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassScheduleItemResponse')
          ..add('id', id)
          ..add('settingId', settingId)
          ..add('classId', classId)
          ..add('userId', userId)
          ..add('courseType', courseType)
          ..add('courseTypeDesc', courseTypeDesc)
          ..add('courseName', courseName)
          ..add('teacherName', teacherName)
          ..add('location', location)
          ..add('courseId', courseId)
          ..add('teacherId', teacherId)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startSection', startSection)
          ..add('endSection', endSection)
          ..add('startWeek', startWeek)
          ..add('endWeek', endWeek)
          ..add('weekType', weekType)
          ..add('weekTypeDesc', weekTypeDesc)
          ..add('color', color)
          ..add('remark', remark)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ClassScheduleItemResponseBuilder
    implements
        Builder<ClassScheduleItemResponse, ClassScheduleItemResponseBuilder> {
  _$ClassScheduleItemResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _settingId;
  String? get settingId => _$this._settingId;
  set settingId(String? settingId) => _$this._settingId = settingId;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  int? _courseType;
  int? get courseType => _$this._courseType;
  set courseType(int? courseType) => _$this._courseType = courseType;

  String? _courseTypeDesc;
  String? get courseTypeDesc => _$this._courseTypeDesc;
  set courseTypeDesc(String? courseTypeDesc) =>
      _$this._courseTypeDesc = courseTypeDesc;

  String? _courseName;
  String? get courseName => _$this._courseName;
  set courseName(String? courseName) => _$this._courseName = courseName;

  String? _teacherName;
  String? get teacherName => _$this._teacherName;
  set teacherName(String? teacherName) => _$this._teacherName = teacherName;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _courseId;
  String? get courseId => _$this._courseId;
  set courseId(String? courseId) => _$this._courseId = courseId;

  String? _teacherId;
  String? get teacherId => _$this._teacherId;
  set teacherId(String? teacherId) => _$this._teacherId = teacherId;

  int? _dayOfWeek;
  int? get dayOfWeek => _$this._dayOfWeek;
  set dayOfWeek(int? dayOfWeek) => _$this._dayOfWeek = dayOfWeek;

  int? _startSection;
  int? get startSection => _$this._startSection;
  set startSection(int? startSection) => _$this._startSection = startSection;

  int? _endSection;
  int? get endSection => _$this._endSection;
  set endSection(int? endSection) => _$this._endSection = endSection;

  int? _startWeek;
  int? get startWeek => _$this._startWeek;
  set startWeek(int? startWeek) => _$this._startWeek = startWeek;

  int? _endWeek;
  int? get endWeek => _$this._endWeek;
  set endWeek(int? endWeek) => _$this._endWeek = endWeek;

  int? _weekType;
  int? get weekType => _$this._weekType;
  set weekType(int? weekType) => _$this._weekType = weekType;

  String? _weekTypeDesc;
  String? get weekTypeDesc => _$this._weekTypeDesc;
  set weekTypeDesc(String? weekTypeDesc) => _$this._weekTypeDesc = weekTypeDesc;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _remark;
  String? get remark => _$this._remark;
  set remark(String? remark) => _$this._remark = remark;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ClassScheduleItemResponseBuilder() {
    ClassScheduleItemResponse._defaults(this);
  }

  ClassScheduleItemResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _settingId = $v.settingId;
      _classId = $v.classId;
      _userId = $v.userId;
      _courseType = $v.courseType;
      _courseTypeDesc = $v.courseTypeDesc;
      _courseName = $v.courseName;
      _teacherName = $v.teacherName;
      _location = $v.location;
      _courseId = $v.courseId;
      _teacherId = $v.teacherId;
      _dayOfWeek = $v.dayOfWeek;
      _startSection = $v.startSection;
      _endSection = $v.endSection;
      _startWeek = $v.startWeek;
      _endWeek = $v.endWeek;
      _weekType = $v.weekType;
      _weekTypeDesc = $v.weekTypeDesc;
      _color = $v.color;
      _remark = $v.remark;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassScheduleItemResponse other) {
    _$v = other as _$ClassScheduleItemResponse;
  }

  @override
  void update(void Function(ClassScheduleItemResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassScheduleItemResponse build() => _build();

  _$ClassScheduleItemResponse _build() {
    final _$result =
        _$v ??
        _$ClassScheduleItemResponse._(
          id: id,
          settingId: settingId,
          classId: classId,
          userId: userId,
          courseType: courseType,
          courseTypeDesc: courseTypeDesc,
          courseName: courseName,
          teacherName: teacherName,
          location: location,
          courseId: courseId,
          teacherId: teacherId,
          dayOfWeek: dayOfWeek,
          startSection: startSection,
          endSection: endSection,
          startWeek: startWeek,
          endWeek: endWeek,
          weekType: weekType,
          weekTypeDesc: weekTypeDesc,
          color: color,
          remark: remark,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
