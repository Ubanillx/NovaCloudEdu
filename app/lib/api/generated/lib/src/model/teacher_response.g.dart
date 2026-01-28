// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherResponse extends TeacherResponse {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? introduction;
  @override
  final BuiltList<String>? expertise;
  @override
  final int? userId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$TeacherResponse([void Function(TeacherResponseBuilder)? updates]) =>
      (TeacherResponseBuilder()..update(updates))._build();

  _$TeacherResponse._({
    this.id,
    this.name,
    this.introduction,
    this.expertise,
    this.userId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  TeacherResponse rebuild(void Function(TeacherResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TeacherResponseBuilder toBuilder() => TeacherResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherResponse &&
        id == other.id &&
        name == other.name &&
        introduction == other.introduction &&
        expertise == other.expertise &&
        userId == other.userId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, introduction.hashCode);
    _$hash = $jc(_$hash, expertise.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('introduction', introduction)
          ..add('expertise', expertise)
          ..add('userId', userId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class TeacherResponseBuilder
    implements Builder<TeacherResponse, TeacherResponseBuilder> {
  _$TeacherResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

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

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  TeacherResponseBuilder() {
    TeacherResponse._defaults(this);
  }

  TeacherResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _introduction = $v.introduction;
      _expertise = $v.expertise?.toBuilder();
      _userId = $v.userId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherResponse other) {
    _$v = other as _$TeacherResponse;
  }

  @override
  void update(void Function(TeacherResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherResponse build() => _build();

  _$TeacherResponse _build() {
    _$TeacherResponse _$result;
    try {
      _$result =
          _$v ??
          _$TeacherResponse._(
            id: id,
            name: name,
            introduction: introduction,
            expertise: _expertise?.build(),
            userId: userId,
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
          r'TeacherResponse',
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
