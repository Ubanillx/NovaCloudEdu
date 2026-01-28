// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_application_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherApplicationResponse extends TeacherApplicationResponse {
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final String? name;
  @override
  final String? introduction;
  @override
  final BuiltList<String>? expertise;
  @override
  final String? certificateUrl;
  @override
  final int? status;
  @override
  final String? statusDesc;
  @override
  final String? rejectReason;
  @override
  final int? reviewerId;
  @override
  final DateTime? reviewTime;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$TeacherApplicationResponse([
    void Function(TeacherApplicationResponseBuilder)? updates,
  ]) => (TeacherApplicationResponseBuilder()..update(updates))._build();

  _$TeacherApplicationResponse._({
    this.id,
    this.userId,
    this.name,
    this.introduction,
    this.expertise,
    this.certificateUrl,
    this.status,
    this.statusDesc,
    this.rejectReason,
    this.reviewerId,
    this.reviewTime,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  TeacherApplicationResponse rebuild(
    void Function(TeacherApplicationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherApplicationResponseBuilder toBuilder() =>
      TeacherApplicationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherApplicationResponse &&
        id == other.id &&
        userId == other.userId &&
        name == other.name &&
        introduction == other.introduction &&
        expertise == other.expertise &&
        certificateUrl == other.certificateUrl &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        rejectReason == other.rejectReason &&
        reviewerId == other.reviewerId &&
        reviewTime == other.reviewTime &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, introduction.hashCode);
    _$hash = $jc(_$hash, expertise.hashCode);
    _$hash = $jc(_$hash, certificateUrl.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, rejectReason.hashCode);
    _$hash = $jc(_$hash, reviewerId.hashCode);
    _$hash = $jc(_$hash, reviewTime.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherApplicationResponse')
          ..add('id', id)
          ..add('userId', userId)
          ..add('name', name)
          ..add('introduction', introduction)
          ..add('expertise', expertise)
          ..add('certificateUrl', certificateUrl)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('rejectReason', rejectReason)
          ..add('reviewerId', reviewerId)
          ..add('reviewTime', reviewTime)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class TeacherApplicationResponseBuilder
    implements
        Builder<TeacherApplicationResponse, TeacherApplicationResponseBuilder> {
  _$TeacherApplicationResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _introduction;
  String? get introduction => _$this._introduction;
  set introduction(String? introduction) => _$this._introduction = introduction;

  ListBuilder<String>? _expertise;
  ListBuilder<String> get expertise =>
      _$this._expertise ??= ListBuilder<String>();
  set expertise(ListBuilder<String>? expertise) =>
      _$this._expertise = expertise;

  String? _certificateUrl;
  String? get certificateUrl => _$this._certificateUrl;
  set certificateUrl(String? certificateUrl) =>
      _$this._certificateUrl = certificateUrl;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _statusDesc;
  String? get statusDesc => _$this._statusDesc;
  set statusDesc(String? statusDesc) => _$this._statusDesc = statusDesc;

  String? _rejectReason;
  String? get rejectReason => _$this._rejectReason;
  set rejectReason(String? rejectReason) => _$this._rejectReason = rejectReason;

  int? _reviewerId;
  int? get reviewerId => _$this._reviewerId;
  set reviewerId(int? reviewerId) => _$this._reviewerId = reviewerId;

  DateTime? _reviewTime;
  DateTime? get reviewTime => _$this._reviewTime;
  set reviewTime(DateTime? reviewTime) => _$this._reviewTime = reviewTime;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  TeacherApplicationResponseBuilder() {
    TeacherApplicationResponse._defaults(this);
  }

  TeacherApplicationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _name = $v.name;
      _introduction = $v.introduction;
      _expertise = $v.expertise?.toBuilder();
      _certificateUrl = $v.certificateUrl;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _rejectReason = $v.rejectReason;
      _reviewerId = $v.reviewerId;
      _reviewTime = $v.reviewTime;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherApplicationResponse other) {
    _$v = other as _$TeacherApplicationResponse;
  }

  @override
  void update(void Function(TeacherApplicationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherApplicationResponse build() => _build();

  _$TeacherApplicationResponse _build() {
    _$TeacherApplicationResponse _$result;
    try {
      _$result =
          _$v ??
          _$TeacherApplicationResponse._(
            id: id,
            userId: userId,
            name: name,
            introduction: introduction,
            expertise: _expertise?.build(),
            certificateUrl: certificateUrl,
            status: status,
            statusDesc: statusDesc,
            rejectReason: rejectReason,
            reviewerId: reviewerId,
            reviewTime: reviewTime,
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'expertise';
        _expertise?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherApplicationResponse',
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
