// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_structure_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CourseStructureResponse extends CourseStructureResponse {
  @override
  final CourseResponse? course;
  @override
  final BuiltList<ChapterResponse>? chapters;
  @override
  final bool? hasAccess;
  @override
  final bool? purchased;

  factory _$CourseStructureResponse([
    void Function(CourseStructureResponseBuilder)? updates,
  ]) => (CourseStructureResponseBuilder()..update(updates))._build();

  _$CourseStructureResponse._({
    this.course,
    this.chapters,
    this.hasAccess,
    this.purchased,
  }) : super._();
  @override
  CourseStructureResponse rebuild(
    void Function(CourseStructureResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CourseStructureResponseBuilder toBuilder() =>
      CourseStructureResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseStructureResponse &&
        course == other.course &&
        chapters == other.chapters &&
        hasAccess == other.hasAccess &&
        purchased == other.purchased;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, course.hashCode);
    _$hash = $jc(_$hash, chapters.hashCode);
    _$hash = $jc(_$hash, hasAccess.hashCode);
    _$hash = $jc(_$hash, purchased.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseStructureResponse')
          ..add('course', course)
          ..add('chapters', chapters)
          ..add('hasAccess', hasAccess)
          ..add('purchased', purchased))
        .toString();
  }
}

class CourseStructureResponseBuilder
    implements
        Builder<CourseStructureResponse, CourseStructureResponseBuilder> {
  _$CourseStructureResponse? _$v;

  CourseResponseBuilder? _course;
  CourseResponseBuilder get course =>
      _$this._course ??= CourseResponseBuilder();
  set course(CourseResponseBuilder? course) => _$this._course = course;

  ListBuilder<ChapterResponse>? _chapters;
  ListBuilder<ChapterResponse> get chapters =>
      _$this._chapters ??= ListBuilder<ChapterResponse>();
  set chapters(ListBuilder<ChapterResponse>? chapters) =>
      _$this._chapters = chapters;

  bool? _hasAccess;
  bool? get hasAccess => _$this._hasAccess;
  set hasAccess(bool? hasAccess) => _$this._hasAccess = hasAccess;

  bool? _purchased;
  bool? get purchased => _$this._purchased;
  set purchased(bool? purchased) => _$this._purchased = purchased;

  CourseStructureResponseBuilder() {
    CourseStructureResponse._defaults(this);
  }

  CourseStructureResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _course = $v.course?.toBuilder();
      _chapters = $v.chapters?.toBuilder();
      _hasAccess = $v.hasAccess;
      _purchased = $v.purchased;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseStructureResponse other) {
    _$v = other as _$CourseStructureResponse;
  }

  @override
  void update(void Function(CourseStructureResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseStructureResponse build() => _build();

  _$CourseStructureResponse _build() {
    _$CourseStructureResponse _$result;
    try {
      _$result =
          _$v ??
          _$CourseStructureResponse._(
            course: _course?.build(),
            chapters: _chapters?.build(),
            hasAccess: hasAccess,
            purchased: purchased,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'course';
        _course?.build();
        _$failedField = 'chapters';
        _chapters?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CourseStructureResponse',
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
