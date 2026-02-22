// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_live_room_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateLiveRoomRequest extends CreateLiveRoomRequest {
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? coverUrl;
  @override
  final int? classId;
  @override
  final String? visibility;

  factory _$CreateLiveRoomRequest([
    void Function(CreateLiveRoomRequestBuilder)? updates,
  ]) => (CreateLiveRoomRequestBuilder()..update(updates))._build();

  _$CreateLiveRoomRequest._({
    this.title,
    this.description,
    this.coverUrl,
    this.classId,
    this.visibility,
  }) : super._();
  @override
  CreateLiveRoomRequest rebuild(
    void Function(CreateLiveRoomRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateLiveRoomRequestBuilder toBuilder() =>
      CreateLiveRoomRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateLiveRoomRequest &&
        title == other.title &&
        description == other.description &&
        coverUrl == other.coverUrl &&
        classId == other.classId &&
        visibility == other.visibility;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, coverUrl.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, visibility.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateLiveRoomRequest')
          ..add('title', title)
          ..add('description', description)
          ..add('coverUrl', coverUrl)
          ..add('classId', classId)
          ..add('visibility', visibility))
        .toString();
  }
}

class CreateLiveRoomRequestBuilder
    implements Builder<CreateLiveRoomRequest, CreateLiveRoomRequestBuilder> {
  _$CreateLiveRoomRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _coverUrl;
  String? get coverUrl => _$this._coverUrl;
  set coverUrl(String? coverUrl) => _$this._coverUrl = coverUrl;

  int? _classId;
  int? get classId => _$this._classId;
  set classId(int? classId) => _$this._classId = classId;

  String? _visibility;
  String? get visibility => _$this._visibility;
  set visibility(String? visibility) => _$this._visibility = visibility;

  CreateLiveRoomRequestBuilder() {
    CreateLiveRoomRequest._defaults(this);
  }

  CreateLiveRoomRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _coverUrl = $v.coverUrl;
      _classId = $v.classId;
      _visibility = $v.visibility;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateLiveRoomRequest other) {
    _$v = other as _$CreateLiveRoomRequest;
  }

  @override
  void update(void Function(CreateLiveRoomRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateLiveRoomRequest build() => _build();

  _$CreateLiveRoomRequest _build() {
    final _$result =
        _$v ??
        _$CreateLiveRoomRequest._(
          title: title,
          description: description,
          coverUrl: coverUrl,
          classId: classId,
          visibility: visibility,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
