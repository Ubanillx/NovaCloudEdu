// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_call_record_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SaveCallRecordRequest extends SaveCallRecordRequest {
  @override
  final String? callId;
  @override
  final int? callerId;
  @override
  final int? calleeId;
  @override
  final String? mediaType;
  @override
  final String? status;
  @override
  final String? mode;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int? duration;

  factory _$SaveCallRecordRequest([
    void Function(SaveCallRecordRequestBuilder)? updates,
  ]) => (SaveCallRecordRequestBuilder()..update(updates))._build();

  _$SaveCallRecordRequest._({
    this.callId,
    this.callerId,
    this.calleeId,
    this.mediaType,
    this.status,
    this.mode,
    this.startedAt,
    this.endedAt,
    this.duration,
  }) : super._();
  @override
  SaveCallRecordRequest rebuild(
    void Function(SaveCallRecordRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SaveCallRecordRequestBuilder toBuilder() =>
      SaveCallRecordRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SaveCallRecordRequest &&
        callId == other.callId &&
        callerId == other.callerId &&
        calleeId == other.calleeId &&
        mediaType == other.mediaType &&
        status == other.status &&
        mode == other.mode &&
        startedAt == other.startedAt &&
        endedAt == other.endedAt &&
        duration == other.duration;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, callId.hashCode);
    _$hash = $jc(_$hash, callerId.hashCode);
    _$hash = $jc(_$hash, calleeId.hashCode);
    _$hash = $jc(_$hash, mediaType.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, endedAt.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SaveCallRecordRequest')
          ..add('callId', callId)
          ..add('callerId', callerId)
          ..add('calleeId', calleeId)
          ..add('mediaType', mediaType)
          ..add('status', status)
          ..add('mode', mode)
          ..add('startedAt', startedAt)
          ..add('endedAt', endedAt)
          ..add('duration', duration))
        .toString();
  }
}

class SaveCallRecordRequestBuilder
    implements Builder<SaveCallRecordRequest, SaveCallRecordRequestBuilder> {
  _$SaveCallRecordRequest? _$v;

  String? _callId;
  String? get callId => _$this._callId;
  set callId(String? callId) => _$this._callId = callId;

  int? _callerId;
  int? get callerId => _$this._callerId;
  set callerId(int? callerId) => _$this._callerId = callerId;

  int? _calleeId;
  int? get calleeId => _$this._calleeId;
  set calleeId(int? calleeId) => _$this._calleeId = calleeId;

  String? _mediaType;
  String? get mediaType => _$this._mediaType;
  set mediaType(String? mediaType) => _$this._mediaType = mediaType;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _mode;
  String? get mode => _$this._mode;
  set mode(String? mode) => _$this._mode = mode;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _endedAt;
  DateTime? get endedAt => _$this._endedAt;
  set endedAt(DateTime? endedAt) => _$this._endedAt = endedAt;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  SaveCallRecordRequestBuilder() {
    SaveCallRecordRequest._defaults(this);
  }

  SaveCallRecordRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _callId = $v.callId;
      _callerId = $v.callerId;
      _calleeId = $v.calleeId;
      _mediaType = $v.mediaType;
      _status = $v.status;
      _mode = $v.mode;
      _startedAt = $v.startedAt;
      _endedAt = $v.endedAt;
      _duration = $v.duration;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SaveCallRecordRequest other) {
    _$v = other as _$SaveCallRecordRequest;
  }

  @override
  void update(void Function(SaveCallRecordRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SaveCallRecordRequest build() => _build();

  _$SaveCallRecordRequest _build() {
    final _$result =
        _$v ??
        _$SaveCallRecordRequest._(
          callId: callId,
          callerId: callerId,
          calleeId: calleeId,
          mediaType: mediaType,
          status: status,
          mode: mode,
          startedAt: startedAt,
          endedAt: endedAt,
          duration: duration,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
