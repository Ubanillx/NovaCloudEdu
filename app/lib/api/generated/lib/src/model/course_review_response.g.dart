// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_review_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CourseReviewResponse extends CourseReviewResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? courseId;
  @override
  final int? rating;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$CourseReviewResponse([
    void Function(CourseReviewResponseBuilder)? updates,
  ]) => (CourseReviewResponseBuilder()..update(updates))._build();

  _$CourseReviewResponse._({
    this.id,
    this.userId,
    this.courseId,
    this.rating,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  CourseReviewResponse rebuild(
    void Function(CourseReviewResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CourseReviewResponseBuilder toBuilder() =>
      CourseReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseReviewResponse &&
        id == other.id &&
        userId == other.userId &&
        courseId == other.courseId &&
        rating == other.rating &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseReviewResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('courseId', courseId)
          ..add('rating', rating)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class CourseReviewResponseBuilder
    implements Builder<CourseReviewResponse, CourseReviewResponseBuilder> {
  _$CourseReviewResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  CourseReviewResponseBuilder() {
    CourseReviewResponse._defaults(this);
  }

  CourseReviewResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _courseId = $v.courseId;
      _rating = $v.rating;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseReviewResponse other) {
    _$v = other as _$CourseReviewResponse;
  }

  @override
  void update(void Function(CourseReviewResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseReviewResponse build() => _build();

  _$CourseReviewResponse _build() {
    final _$result =
        _$v ??
        _$CourseReviewResponse._(
          id: id,
          userId: userId,
          courseId: courseId,
          rating: rating,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
