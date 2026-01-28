// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProgressResponse extends ProgressResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? courseId;
  @override
  final int? sectionId;
  @override
  final int? progress;
  @override
  final int? watchDuration;
  @override
  final int? lastPosition;
  @override
  final bool? isCompleted;
  @override
  final DateTime? completedTime;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ProgressResponse([
    void Function(ProgressResponseBuilder)? updates,
  ]) => (ProgressResponseBuilder()..update(updates))._build();

  _$ProgressResponse._({
    this.id,
    this.userId,
    this.courseId,
    this.sectionId,
    this.progress,
    this.watchDuration,
    this.lastPosition,
    this.isCompleted,
    this.completedTime,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ProgressResponse rebuild(void Function(ProgressResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProgressResponseBuilder toBuilder() =>
      ProgressResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProgressResponse &&
        id == other.id &&
        userId == other.userId &&
        courseId == other.courseId &&
        sectionId == other.sectionId &&
        progress == other.progress &&
        watchDuration == other.watchDuration &&
        lastPosition == other.lastPosition &&
        isCompleted == other.isCompleted &&
        completedTime == other.completedTime &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, sectionId.hashCode);
    _$hash = $jc(_$hash, progress.hashCode);
    _$hash = $jc(_$hash, watchDuration.hashCode);
    _$hash = $jc(_$hash, lastPosition.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jc(_$hash, completedTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProgressResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('courseId', courseId)
          ..add('sectionId', sectionId)
          ..add('progress', progress)
          ..add('watchDuration', watchDuration)
          ..add('lastPosition', lastPosition)
          ..add('isCompleted', isCompleted)
          ..add('completedTime', completedTime)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ProgressResponseBuilder
    implements Builder<ProgressResponse, ProgressResponseBuilder> {
  _$ProgressResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  int? _sectionId;
  int? get sectionId => _$this._sectionId;
  set sectionId(int? sectionId) => _$this._sectionId = sectionId;

  int? _progress;
  int? get progress => _$this._progress;
  set progress(int? progress) => _$this._progress = progress;

  int? _watchDuration;
  int? get watchDuration => _$this._watchDuration;
  set watchDuration(int? watchDuration) =>
      _$this._watchDuration = watchDuration;

  int? _lastPosition;
  int? get lastPosition => _$this._lastPosition;
  set lastPosition(int? lastPosition) => _$this._lastPosition = lastPosition;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  DateTime? _completedTime;
  DateTime? get completedTime => _$this._completedTime;
  set completedTime(DateTime? completedTime) =>
      _$this._completedTime = completedTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ProgressResponseBuilder() {
    ProgressResponse._defaults(this);
  }

  ProgressResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _courseId = $v.courseId;
      _sectionId = $v.sectionId;
      _progress = $v.progress;
      _watchDuration = $v.watchDuration;
      _lastPosition = $v.lastPosition;
      _isCompleted = $v.isCompleted;
      _completedTime = $v.completedTime;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProgressResponse other) {
    _$v = other as _$ProgressResponse;
  }

  @override
  void update(void Function(ProgressResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProgressResponse build() => _build();

  _$ProgressResponse _build() {
    final _$result =
        _$v ??
        _$ProgressResponse._(
          id: id,
          userId: userId,
          courseId: courseId,
          sectionId: sectionId,
          progress: progress,
          watchDuration: watchDuration,
          lastPosition: lastPosition,
          isCompleted: isCompleted,
          completedTime: completedTime,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
