// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_class_member_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddClassMemberRequest extends AddClassMemberRequest {
  @override
  final int userId;
  @override
  final String role;

  factory _$AddClassMemberRequest([
    void Function(AddClassMemberRequestBuilder)? updates,
  ]) => (AddClassMemberRequestBuilder()..update(updates))._build();

  _$AddClassMemberRequest._({required this.userId, required this.role})
    : super._();
  @override
  AddClassMemberRequest rebuild(
    void Function(AddClassMemberRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddClassMemberRequestBuilder toBuilder() =>
      AddClassMemberRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddClassMemberRequest &&
        userId == other.userId &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddClassMemberRequest')
          ..add('userId', userId)
          ..add('role', role))
        .toString();
  }
}

class AddClassMemberRequestBuilder
    implements Builder<AddClassMemberRequest, AddClassMemberRequestBuilder> {
  _$AddClassMemberRequest? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  AddClassMemberRequestBuilder() {
    AddClassMemberRequest._defaults(this);
  }

  AddClassMemberRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddClassMemberRequest other) {
    _$v = other as _$AddClassMemberRequest;
  }

  @override
  void update(void Function(AddClassMemberRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddClassMemberRequest build() => _build();

  _$AddClassMemberRequest _build() {
    final _$result =
        _$v ??
        _$AddClassMemberRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'AddClassMemberRequest',
            'userId',
          ),
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'AddClassMemberRequest',
            'role',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
