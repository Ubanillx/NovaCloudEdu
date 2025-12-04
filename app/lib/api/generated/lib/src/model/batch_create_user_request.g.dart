// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_create_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchCreateUserRequest extends BatchCreateUserRequest {
  @override
  final BuiltList<CreateUserRequest> users;

  factory _$BatchCreateUserRequest(
          [void Function(BatchCreateUserRequestBuilder)? updates]) =>
      (BatchCreateUserRequestBuilder()..update(updates))._build();

  _$BatchCreateUserRequest._({required this.users}) : super._();
  @override
  BatchCreateUserRequest rebuild(
          void Function(BatchCreateUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BatchCreateUserRequestBuilder toBuilder() =>
      BatchCreateUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchCreateUserRequest && users == other.users;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BatchCreateUserRequest')
          ..add('users', users))
        .toString();
  }
}

class BatchCreateUserRequestBuilder
    implements Builder<BatchCreateUserRequest, BatchCreateUserRequestBuilder> {
  _$BatchCreateUserRequest? _$v;

  ListBuilder<CreateUserRequest>? _users;
  ListBuilder<CreateUserRequest> get users =>
      _$this._users ??= ListBuilder<CreateUserRequest>();
  set users(ListBuilder<CreateUserRequest>? users) => _$this._users = users;

  BatchCreateUserRequestBuilder() {
    BatchCreateUserRequest._defaults(this);
  }

  BatchCreateUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _users = $v.users.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchCreateUserRequest other) {
    _$v = other as _$BatchCreateUserRequest;
  }

  @override
  void update(void Function(BatchCreateUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchCreateUserRequest build() => _build();

  _$BatchCreateUserRequest _build() {
    _$BatchCreateUserRequest _$result;
    try {
      _$result = _$v ??
          _$BatchCreateUserRequest._(
            users: users.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        users.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BatchCreateUserRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
