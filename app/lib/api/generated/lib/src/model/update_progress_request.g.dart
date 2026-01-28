// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_progress_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateProgressRequest extends UpdateProgressRequest {
  @override
  final int courseId;
  @override
  final int sectionId;
  @override
  final int lastPosition;
  @override
  final int watchDuration;
  @override
  final int progress;

  factory _$UpdateProgressRequest([
    void Function(UpdateProgressRequestBuilder)? updates,
  ]) => (UpdateProgressRequestBuilder()..update(updates))._build();

  _$UpdateProgressRequest._({
    required this.courseId,
    required this.sectionId,
    required this.lastPosition,
    required this.watchDuration,
    required this.progress,
  }) : super._();
  @override
  UpdateProgressRequest rebuild(
    void Function(UpdateProgressRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateProgressRequestBuilder toBuilder() =>
      UpdateProgressRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateProgressRequest &&
        courseId == other.courseId &&
        sectionId == other.sectionId &&
        lastPosition == other.lastPosition &&
        watchDuration == other.watchDuration &&
        progress == other.progress;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, sectionId.hashCode);
    _$hash = $jc(_$hash, lastPosition.hashCode);
    _$hash = $jc(_$hash, watchDuration.hashCode);
    _$hash = $jc(_$hash, progress.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateProgressRequest')
          ..add('courseId', courseId)
          ..add('sectionId', sectionId)
          ..add('lastPosition', lastPosition)
          ..add('watchDuration', watchDuration)
          ..add('progress', progress))
        .toString();
  }
}

class UpdateProgressRequestBuilder
    implements Builder<UpdateProgressRequest, UpdateProgressRequestBuilder> {
  _$UpdateProgressRequest? _$v;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  int? _sectionId;
  int? get sectionId => _$this._sectionId;
  set sectionId(int? sectionId) => _$this._sectionId = sectionId;

  int? _lastPosition;
  int? get lastPosition => _$this._lastPosition;
  set lastPosition(int? lastPosition) => _$this._lastPosition = lastPosition;

  int? _watchDuration;
  int? get watchDuration => _$this._watchDuration;
  set watchDuration(int? watchDuration) =>
      _$this._watchDuration = watchDuration;

  int? _progress;
  int? get progress => _$this._progress;
  set progress(int? progress) => _$this._progress = progress;

  UpdateProgressRequestBuilder() {
    UpdateProgressRequest._defaults(this);
  }

  UpdateProgressRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _courseId = $v.courseId;
      _sectionId = $v.sectionId;
      _lastPosition = $v.lastPosition;
      _watchDuration = $v.watchDuration;
      _progress = $v.progress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateProgressRequest other) {
    _$v = other as _$UpdateProgressRequest;
  }

  @override
  void update(void Function(UpdateProgressRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateProgressRequest build() => _build();

  _$UpdateProgressRequest _build() {
    final _$result =
        _$v ??
        _$UpdateProgressRequest._(
          courseId: BuiltValueNullFieldError.checkNotNull(
            courseId,
            r'UpdateProgressRequest',
            'courseId',
          ),
          sectionId: BuiltValueNullFieldError.checkNotNull(
            sectionId,
            r'UpdateProgressRequest',
            'sectionId',
          ),
          lastPosition: BuiltValueNullFieldError.checkNotNull(
            lastPosition,
            r'UpdateProgressRequest',
            'lastPosition',
          ),
          watchDuration: BuiltValueNullFieldError.checkNotNull(
            watchDuration,
            r'UpdateProgressRequest',
            'watchDuration',
          ),
          progress: BuiltValueNullFieldError.checkNotNull(
            progress,
            r'UpdateProgressRequest',
            'progress',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
