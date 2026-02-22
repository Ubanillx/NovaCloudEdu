// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_room_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LiveRoomResponse extends LiveRoomResponse {
  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? coverUrl;
  @override
  final int? hostUserId;
  @override
  final int? classId;
  @override
  final String? status;
  @override
  final String? visibility;
  @override
  final int? viewerCount;
  @override
  final int? peakViewers;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int? duration;
  @override
  final String? playbackUrl;
  @override
  final DateTime? createTime;
  @override
  final String? streamKey;
  @override
  final String? rtmpUrl;
  @override
  final String? flvPlayUrl;
  @override
  final String? hlsPlayUrl;
  @override
  final bool? recording;

  factory _$LiveRoomResponse([
    void Function(LiveRoomResponseBuilder)? updates,
  ]) => (LiveRoomResponseBuilder()..update(updates))._build();

  _$LiveRoomResponse._({
    this.id,
    this.title,
    this.description,
    this.coverUrl,
    this.hostUserId,
    this.classId,
    this.status,
    this.visibility,
    this.viewerCount,
    this.peakViewers,
    this.startedAt,
    this.endedAt,
    this.duration,
    this.playbackUrl,
    this.createTime,
    this.streamKey,
    this.rtmpUrl,
    this.flvPlayUrl,
    this.hlsPlayUrl,
    this.recording,
  }) : super._();
  @override
  LiveRoomResponse rebuild(void Function(LiveRoomResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LiveRoomResponseBuilder toBuilder() =>
      LiveRoomResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LiveRoomResponse &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        coverUrl == other.coverUrl &&
        hostUserId == other.hostUserId &&
        classId == other.classId &&
        status == other.status &&
        visibility == other.visibility &&
        viewerCount == other.viewerCount &&
        peakViewers == other.peakViewers &&
        startedAt == other.startedAt &&
        endedAt == other.endedAt &&
        duration == other.duration &&
        playbackUrl == other.playbackUrl &&
        createTime == other.createTime &&
        streamKey == other.streamKey &&
        rtmpUrl == other.rtmpUrl &&
        flvPlayUrl == other.flvPlayUrl &&
        hlsPlayUrl == other.hlsPlayUrl &&
        recording == other.recording;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, coverUrl.hashCode);
    _$hash = $jc(_$hash, hostUserId.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jc(_$hash, viewerCount.hashCode);
    _$hash = $jc(_$hash, peakViewers.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, endedAt.hashCode);
    _$hash = $jc(_$hash, duration.hashCode);
    _$hash = $jc(_$hash, playbackUrl.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, streamKey.hashCode);
    _$hash = $jc(_$hash, rtmpUrl.hashCode);
    _$hash = $jc(_$hash, flvPlayUrl.hashCode);
    _$hash = $jc(_$hash, hlsPlayUrl.hashCode);
    _$hash = $jc(_$hash, recording.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LiveRoomResponse')
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('coverUrl', coverUrl)
          ..add('hostUserId', hostUserId)
          ..add('classId', classId)
          ..add('status', status)
          ..add('visibility', visibility)
          ..add('viewerCount', viewerCount)
          ..add('peakViewers', peakViewers)
          ..add('startedAt', startedAt)
          ..add('endedAt', endedAt)
          ..add('duration', duration)
          ..add('playbackUrl', playbackUrl)
          ..add('createTime', createTime)
          ..add('streamKey', streamKey)
          ..add('rtmpUrl', rtmpUrl)
          ..add('flvPlayUrl', flvPlayUrl)
          ..add('hlsPlayUrl', hlsPlayUrl)
          ..add('recording', recording))
        .toString();
  }
}

class LiveRoomResponseBuilder
    implements Builder<LiveRoomResponse, LiveRoomResponseBuilder> {
  _$LiveRoomResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _coverUrl;
  String? get coverUrl => _$this._coverUrl;
  set coverUrl(String? coverUrl) => _$this._coverUrl = coverUrl;

  int? _hostUserId;
  int? get hostUserId => _$this._hostUserId;
  set hostUserId(int? hostUserId) => _$this._hostUserId = hostUserId;

  int? _classId;
  int? get classId => _$this._classId;
  set classId(int? classId) => _$this._classId = classId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _visibility;
  String? get visibility => _$this._visibility;
  set visibility(String? visibility) => _$this._visibility = visibility;

  int? _viewerCount;
  int? get viewerCount => _$this._viewerCount;
  set viewerCount(int? viewerCount) => _$this._viewerCount = viewerCount;

  int? _peakViewers;
  int? get peakViewers => _$this._peakViewers;
  set peakViewers(int? peakViewers) => _$this._peakViewers = peakViewers;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _endedAt;
  DateTime? get endedAt => _$this._endedAt;
  set endedAt(DateTime? endedAt) => _$this._endedAt = endedAt;

  int? _duration;
  int? get duration => _$this._duration;
  set duration(int? duration) => _$this._duration = duration;

  String? _playbackUrl;
  String? get playbackUrl => _$this._playbackUrl;
  set playbackUrl(String? playbackUrl) => _$this._playbackUrl = playbackUrl;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  String? _streamKey;
  String? get streamKey => _$this._streamKey;
  set streamKey(String? streamKey) => _$this._streamKey = streamKey;

  String? _rtmpUrl;
  String? get rtmpUrl => _$this._rtmpUrl;
  set rtmpUrl(String? rtmpUrl) => _$this._rtmpUrl = rtmpUrl;

  String? _flvPlayUrl;
  String? get flvPlayUrl => _$this._flvPlayUrl;
  set flvPlayUrl(String? flvPlayUrl) => _$this._flvPlayUrl = flvPlayUrl;

  String? _hlsPlayUrl;
  String? get hlsPlayUrl => _$this._hlsPlayUrl;
  set hlsPlayUrl(String? hlsPlayUrl) => _$this._hlsPlayUrl = hlsPlayUrl;

  bool? _recording;
  bool? get recording => _$this._recording;
  set recording(bool? recording) => _$this._recording = recording;

  LiveRoomResponseBuilder() {
    LiveRoomResponse._defaults(this);
  }

  LiveRoomResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _coverUrl = $v.coverUrl;
      _hostUserId = $v.hostUserId;
      _classId = $v.classId;
      _status = $v.status;
      _visibility = $v.visibility;
      _viewerCount = $v.viewerCount;
      _peakViewers = $v.peakViewers;
      _startedAt = $v.startedAt;
      _endedAt = $v.endedAt;
      _duration = $v.duration;
      _playbackUrl = $v.playbackUrl;
      _createTime = $v.createTime;
      _streamKey = $v.streamKey;
      _rtmpUrl = $v.rtmpUrl;
      _flvPlayUrl = $v.flvPlayUrl;
      _hlsPlayUrl = $v.hlsPlayUrl;
      _recording = $v.recording;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LiveRoomResponse other) {
    _$v = other as _$LiveRoomResponse;
  }

  @override
  void update(void Function(LiveRoomResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LiveRoomResponse build() => _build();

  _$LiveRoomResponse _build() {
    final _$result =
        _$v ??
        _$LiveRoomResponse._(
          id: id,
          title: title,
          description: description,
          coverUrl: coverUrl,
          hostUserId: hostUserId,
          classId: classId,
          status: status,
          visibility: visibility,
          viewerCount: viewerCount,
          peakViewers: peakViewers,
          startedAt: startedAt,
          endedAt: endedAt,
          duration: duration,
          playbackUrl: playbackUrl,
          createTime: createTime,
          streamKey: streamKey,
          rtmpUrl: rtmpUrl,
          flvPlayUrl: flvPlayUrl,
          hlsPlayUrl: hlsPlayUrl,
          recording: recording,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
