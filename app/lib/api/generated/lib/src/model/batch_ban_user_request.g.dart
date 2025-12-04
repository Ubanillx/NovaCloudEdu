// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_ban_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchBanUserRequest extends BatchBanUserRequest {
  @override
  final BuiltList<int> userIds;
  @override
  final bool banned;

  factory _$BatchBanUserRequest(
          [void Function(BatchBanUserRequestBuilder)? updates]) =>
      (BatchBanUserRequestBuilder()..update(updates))._build();

  _$BatchBanUserRequest._({required this.userIds, required this.banned})
      : super._();
  @override
  BatchBanUserRequest rebuild(
          void Function(BatchBanUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BatchBanUserRequestBuilder toBuilder() =>
      BatchBanUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchBanUserRequest &&
        userIds == other.userIds &&
        banned == other.banned;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userIds.hashCode);
    _$hash = $jc(_$hash, banned.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BatchBanUserRequest')
          ..add('userIds', userIds)
          ..add('banned', banned))
        .toString();
  }
}

class BatchBanUserRequestBuilder
    implements Builder<BatchBanUserRequest, BatchBanUserRequestBuilder> {
  _$BatchBanUserRequest? _$v;

  ListBuilder<int>? _userIds;
  ListBuilder<int> get userIds => _$this._userIds ??= ListBuilder<int>();
  set userIds(ListBuilder<int>? userIds) => _$this._userIds = userIds;

  bool? _banned;
  bool? get banned => _$this._banned;
  set banned(bool? banned) => _$this._banned = banned;

  BatchBanUserRequestBuilder() {
    BatchBanUserRequest._defaults(this);
  }

  BatchBanUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userIds = $v.userIds.toBuilder();
      _banned = $v.banned;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchBanUserRequest other) {
    _$v = other as _$BatchBanUserRequest;
  }

  @override
  void update(void Function(BatchBanUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchBanUserRequest build() => _build();

  _$BatchBanUserRequest _build() {
    _$BatchBanUserRequest _$result;
    try {
      _$result = _$v ??
          _$BatchBanUserRequest._(
            userIds: userIds.build(),
            banned: BuiltValueNullFieldError.checkNotNull(
                banned, r'BatchBanUserRequest', 'banned'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userIds';
        userIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'BatchBanUserRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
