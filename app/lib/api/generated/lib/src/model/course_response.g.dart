// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CourseResponse extends CourseResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? description;
  @override
  final String? coverImage;
  @override
  final num? price;
  @override
  final int? courseType;
  @override
  final String? courseTypeDesc;
  @override
  final int? difficulty;
  @override
  final String? difficultyDesc;
  @override
  final int? status;
  @override
  final String? statusDesc;
  @override
  final int? teacherId;
  @override
  final int? totalDuration;
  @override
  final int? totalChapters;
  @override
  final int? totalSections;
  @override
  final int? studentCount;
  @override
  final num? ratingScore;
  @override
  final BuiltList<String>? tags;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$CourseResponse([void Function(CourseResponseBuilder)? updates]) =>
      (CourseResponseBuilder()..update(updates))._build();

  _$CourseResponse._({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.coverImage,
    this.price,
    this.courseType,
    this.courseTypeDesc,
    this.difficulty,
    this.difficultyDesc,
    this.status,
    this.statusDesc,
    this.teacherId,
    this.totalDuration,
    this.totalChapters,
    this.totalSections,
    this.studentCount,
    this.ratingScore,
    this.tags,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  CourseResponse rebuild(void Function(CourseResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CourseResponseBuilder toBuilder() => CourseResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CourseResponse &&
        id == other.id &&
        title == other.title &&
        subtitle == other.subtitle &&
        description == other.description &&
        coverImage == other.coverImage &&
        price == other.price &&
        courseType == other.courseType &&
        courseTypeDesc == other.courseTypeDesc &&
        difficulty == other.difficulty &&
        difficultyDesc == other.difficultyDesc &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        teacherId == other.teacherId &&
        totalDuration == other.totalDuration &&
        totalChapters == other.totalChapters &&
        totalSections == other.totalSections &&
        studentCount == other.studentCount &&
        ratingScore == other.ratingScore &&
        tags == other.tags &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, courseType.hashCode);
    _$hash = $jc(_$hash, courseTypeDesc.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, difficultyDesc.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, teacherId.hashCode);
    _$hash = $jc(_$hash, totalDuration.hashCode);
    _$hash = $jc(_$hash, totalChapters.hashCode);
    _$hash = $jc(_$hash, totalSections.hashCode);
    _$hash = $jc(_$hash, studentCount.hashCode);
    _$hash = $jc(_$hash, ratingScore.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CourseResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('subtitle', subtitle)
          ..add('description', description)
          ..add('coverImage', coverImage)
          ..add('price', price)
          ..add('courseType', courseType)
          ..add('courseTypeDesc', courseTypeDesc)
          ..add('difficulty', difficulty)
          ..add('difficultyDesc', difficultyDesc)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('teacherId', teacherId)
          ..add('totalDuration', totalDuration)
          ..add('totalChapters', totalChapters)
          ..add('totalSections', totalSections)
          ..add('studentCount', studentCount)
          ..add('ratingScore', ratingScore)
          ..add('tags', tags)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class CourseResponseBuilder
    implements Builder<CourseResponse, CourseResponseBuilder> {
  _$CourseResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  int? _courseType;
  int? get courseType => _$this._courseType;
  set courseType(int? courseType) => _$this._courseType = courseType;

  String? _courseTypeDesc;
  String? get courseTypeDesc => _$this._courseTypeDesc;
  set courseTypeDesc(String? courseTypeDesc) =>
      _$this._courseTypeDesc = courseTypeDesc;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  String? _difficultyDesc;
  String? get difficultyDesc => _$this._difficultyDesc;
  set difficultyDesc(String? difficultyDesc) =>
      _$this._difficultyDesc = difficultyDesc;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _statusDesc;
  String? get statusDesc => _$this._statusDesc;
  set statusDesc(String? statusDesc) => _$this._statusDesc = statusDesc;

  int? _teacherId;
  int? get teacherId => _$this._teacherId;
  set teacherId(int? teacherId) => _$this._teacherId = teacherId;

  int? _totalDuration;
  int? get totalDuration => _$this._totalDuration;
  set totalDuration(int? totalDuration) =>
      _$this._totalDuration = totalDuration;

  int? _totalChapters;
  int? get totalChapters => _$this._totalChapters;
  set totalChapters(int? totalChapters) =>
      _$this._totalChapters = totalChapters;

  int? _totalSections;
  int? get totalSections => _$this._totalSections;
  set totalSections(int? totalSections) =>
      _$this._totalSections = totalSections;

  int? _studentCount;
  int? get studentCount => _$this._studentCount;
  set studentCount(int? studentCount) => _$this._studentCount = studentCount;

  num? _ratingScore;
  num? get ratingScore => _$this._ratingScore;
  set ratingScore(num? ratingScore) => _$this._ratingScore = ratingScore;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  CourseResponseBuilder() {
    CourseResponse._defaults(this);
  }

  CourseResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _subtitle = $v.subtitle;
      _description = $v.description;
      _coverImage = $v.coverImage;
      _price = $v.price;
      _courseType = $v.courseType;
      _courseTypeDesc = $v.courseTypeDesc;
      _difficulty = $v.difficulty;
      _difficultyDesc = $v.difficultyDesc;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _teacherId = $v.teacherId;
      _totalDuration = $v.totalDuration;
      _totalChapters = $v.totalChapters;
      _totalSections = $v.totalSections;
      _studentCount = $v.studentCount;
      _ratingScore = $v.ratingScore;
      _tags = $v.tags?.toBuilder();
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CourseResponse other) {
    _$v = other as _$CourseResponse;
  }

  @override
  void update(void Function(CourseResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CourseResponse build() => _build();

  _$CourseResponse _build() {
    _$CourseResponse _$result;
    try {
      _$result =
          _$v ??
          _$CourseResponse._(
            id: id,
            title: title,
            subtitle: subtitle,
            description: description,
            coverImage: coverImage,
            price: price,
            courseType: courseType,
            courseTypeDesc: courseTypeDesc,
            difficulty: difficulty,
            difficultyDesc: difficultyDesc,
            status: status,
            statusDesc: statusDesc,
            teacherId: teacherId,
            totalDuration: totalDuration,
            totalChapters: totalChapters,
            totalSections: totalSections,
            studentCount: studentCount,
            ratingScore: ratingScore,
            tags: _tags?.build(),
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CourseResponse',
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
