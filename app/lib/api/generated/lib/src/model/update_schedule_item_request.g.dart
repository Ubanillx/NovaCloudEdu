// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_schedule_item_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateScheduleItemRequest extends UpdateScheduleItemRequest {
  @override
  final String? location;
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
  final String? color;
  @override
  final String? remark;
  @override
  final String? courseName;
  @override
  final String? teacherName;

  factory _$UpdateScheduleItemRequest([
    void Function(UpdateScheduleItemRequestBuilder)? updates,
  ]) => (UpdateScheduleItemRequestBuilder()..update(updates))._build();

  _$UpdateScheduleItemRequest._({
    this.location,
    this.dayOfWeek,
    this.startSection,
    this.endSection,
    this.startWeek,
    this.endWeek,
    this.weekType,
    this.color,
    this.remark,
    this.courseName,
    this.teacherName,
  }) : super._();
  @override
  UpdateScheduleItemRequest rebuild(
    void Function(UpdateScheduleItemRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateScheduleItemRequestBuilder toBuilder() =>
      UpdateScheduleItemRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateScheduleItemRequest &&
        location == other.location &&
        dayOfWeek == other.dayOfWeek &&
        startSection == other.startSection &&
        endSection == other.endSection &&
        startWeek == other.startWeek &&
        endWeek == other.endWeek &&
        weekType == other.weekType &&
        color == other.color &&
        remark == other.remark &&
        courseName == other.courseName &&
        teacherName == other.teacherName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, dayOfWeek.hashCode);
    _$hash = $jc(_$hash, startSection.hashCode);
    _$hash = $jc(_$hash, endSection.hashCode);
    _$hash = $jc(_$hash, startWeek.hashCode);
    _$hash = $jc(_$hash, endWeek.hashCode);
    _$hash = $jc(_$hash, weekType.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, remark.hashCode);
    _$hash = $jc(_$hash, courseName.hashCode);
    _$hash = $jc(_$hash, teacherName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateScheduleItemRequest')
          ..add('location', location)
          ..add('dayOfWeek', dayOfWeek)
          ..add('startSection', startSection)
          ..add('endSection', endSection)
          ..add('startWeek', startWeek)
          ..add('endWeek', endWeek)
          ..add('weekType', weekType)
          ..add('color', color)
          ..add('remark', remark)
          ..add('courseName', courseName)
          ..add('teacherName', teacherName))
        .toString();
  }
}

class UpdateScheduleItemRequestBuilder
    implements
        Builder<UpdateScheduleItemRequest, UpdateScheduleItemRequestBuilder> {
  _$UpdateScheduleItemRequest? _$v;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

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

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  String? _remark;
  String? get remark => _$this._remark;
  set remark(String? remark) => _$this._remark = remark;

  String? _courseName;
  String? get courseName => _$this._courseName;
  set courseName(String? courseName) => _$this._courseName = courseName;

  String? _teacherName;
  String? get teacherName => _$this._teacherName;
  set teacherName(String? teacherName) => _$this._teacherName = teacherName;

  UpdateScheduleItemRequestBuilder() {
    UpdateScheduleItemRequest._defaults(this);
  }

  UpdateScheduleItemRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _location = $v.location;
      _dayOfWeek = $v.dayOfWeek;
      _startSection = $v.startSection;
      _endSection = $v.endSection;
      _startWeek = $v.startWeek;
      _endWeek = $v.endWeek;
      _weekType = $v.weekType;
      _color = $v.color;
      _remark = $v.remark;
      _courseName = $v.courseName;
      _teacherName = $v.teacherName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateScheduleItemRequest other) {
    _$v = other as _$UpdateScheduleItemRequest;
  }

  @override
  void update(void Function(UpdateScheduleItemRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateScheduleItemRequest build() => _build();

  _$UpdateScheduleItemRequest _build() {
    final _$result =
        _$v ??
        _$UpdateScheduleItemRequest._(
          location: location,
          dayOfWeek: dayOfWeek,
          startSection: startSection,
          endSection: endSection,
          startWeek: startWeek,
          endWeek: endWeek,
          weekType: weekType,
          color: color,
          remark: remark,
          courseName: courseName,
          teacherName: teacherName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
