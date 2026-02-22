// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_user_membership.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListUserMembership extends BaseResponseListUserMembership {
  @override
  final int? code;
  @override
  final BuiltList<UserMembership>? data;
  @override
  final String? message;

  factory _$BaseResponseListUserMembership([
    void Function(BaseResponseListUserMembershipBuilder)? updates,
  ]) => (BaseResponseListUserMembershipBuilder()..update(updates))._build();

  _$BaseResponseListUserMembership._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListUserMembership rebuild(
    void Function(BaseResponseListUserMembershipBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListUserMembershipBuilder toBuilder() =>
      BaseResponseListUserMembershipBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListUserMembership &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BaseResponseListUserMembership')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListUserMembershipBuilder
    implements
        Builder<
          BaseResponseListUserMembership,
          BaseResponseListUserMembershipBuilder
        > {
  _$BaseResponseListUserMembership? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<UserMembership>? _data;
  ListBuilder<UserMembership> get data =>
      _$this._data ??= ListBuilder<UserMembership>();
  set data(ListBuilder<UserMembership>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListUserMembershipBuilder() {
    BaseResponseListUserMembership._defaults(this);
  }

  BaseResponseListUserMembershipBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseListUserMembership other) {
    _$v = other as _$BaseResponseListUserMembership;
  }

  @override
  void update(void Function(BaseResponseListUserMembershipBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListUserMembership build() => _build();

  _$BaseResponseListUserMembership _build() {
    _$BaseResponseListUserMembership _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListUserMembership._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BaseResponseListUserMembership',
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
