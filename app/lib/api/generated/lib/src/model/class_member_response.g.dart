// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_member_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassMemberResponse extends ClassMemberResponse {
  @override
  final String? id;
  @override
  final String? classId;
  @override
  final String? userId;
  @override
  final String? role;
  @override
  final DateTime? joinTime;

  factory _$ClassMemberResponse([
    void Function(ClassMemberResponseBuilder)? updates,
  ]) => (ClassMemberResponseBuilder()..update(updates))._build();

  _$ClassMemberResponse._({
    this.id,
    this.classId,
    this.userId,
    this.role,
    this.joinTime,
  }) : super._();
  @override
  ClassMemberResponse rebuild(
    void Function(ClassMemberResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ClassMemberResponseBuilder toBuilder() =>
      ClassMemberResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassMemberResponse &&
        id == other.id &&
        classId == other.classId &&
        userId == other.userId &&
        role == other.role &&
        joinTime == other.joinTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, classId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, joinTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassMemberResponse')
          ..add('id', id)
          ..add('classId', classId)
          ..add('userId', userId)
          ..add('role', role)
          ..add('joinTime', joinTime))
        .toString();
  }
}

class ClassMemberResponseBuilder
    implements Builder<ClassMemberResponse, ClassMemberResponseBuilder> {
  _$ClassMemberResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _classId;
  String? get classId => _$this._classId;
  set classId(String? classId) => _$this._classId = classId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  DateTime? _joinTime;
  DateTime? get joinTime => _$this._joinTime;
  set joinTime(DateTime? joinTime) => _$this._joinTime = joinTime;

  ClassMemberResponseBuilder() {
    ClassMemberResponse._defaults(this);
  }

  ClassMemberResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _classId = $v.classId;
      _userId = $v.userId;
      _role = $v.role;
      _joinTime = $v.joinTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassMemberResponse other) {
    _$v = other as _$ClassMemberResponse;
  }

  @override
  void update(void Function(ClassMemberResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassMemberResponse build() => _build();

  _$ClassMemberResponse _build() {
    final _$result =
        _$v ??
        _$ClassMemberResponse._(
          id: id,
          classId: classId,
          userId: userId,
          role: role,
          joinTime: joinTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
