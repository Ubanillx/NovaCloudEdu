// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_class_course_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddClassCourseRequest extends AddClassCourseRequest {
  @override
  final int courseId;

  factory _$AddClassCourseRequest([
    void Function(AddClassCourseRequestBuilder)? updates,
  ]) => (AddClassCourseRequestBuilder()..update(updates))._build();

  _$AddClassCourseRequest._({required this.courseId}) : super._();
  @override
  AddClassCourseRequest rebuild(
    void Function(AddClassCourseRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddClassCourseRequestBuilder toBuilder() =>
      AddClassCourseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddClassCourseRequest && courseId == other.courseId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'AddClassCourseRequest',
    )..add('courseId', courseId)).toString();
  }
}

class AddClassCourseRequestBuilder
    implements Builder<AddClassCourseRequest, AddClassCourseRequestBuilder> {
  _$AddClassCourseRequest? _$v;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  AddClassCourseRequestBuilder() {
    AddClassCourseRequest._defaults(this);
  }

  AddClassCourseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _courseId = $v.courseId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddClassCourseRequest other) {
    _$v = other as _$AddClassCourseRequest;
  }

  @override
  void update(void Function(AddClassCourseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddClassCourseRequest build() => _build();

  _$AddClassCourseRequest _build() {
    final _$result =
        _$v ??
        _$AddClassCourseRequest._(
          courseId: BuiltValueNullFieldError.checkNotNull(
            courseId,
            r'AddClassCourseRequest',
            'courseId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
