// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_user_membership_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUserMembershipDetailResponse
    extends BaseResponseUserMembershipDetailResponse {
  @override
  final int? code;
  @override
  final UserMembershipDetailResponse? data;
  @override
  final String? message;

  factory _$BaseResponseUserMembershipDetailResponse([
    void Function(BaseResponseUserMembershipDetailResponseBuilder)? updates,
  ]) => (BaseResponseUserMembershipDetailResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseUserMembershipDetailResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseUserMembershipDetailResponse rebuild(
    void Function(BaseResponseUserMembershipDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseUserMembershipDetailResponseBuilder toBuilder() =>
      BaseResponseUserMembershipDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUserMembershipDetailResponse &&
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
    return (newBuiltValueToStringHelper(
            r'BaseResponseUserMembershipDetailResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUserMembershipDetailResponseBuilder
    implements
        Builder<
          BaseResponseUserMembershipDetailResponse,
          BaseResponseUserMembershipDetailResponseBuilder
        > {
  _$BaseResponseUserMembershipDetailResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UserMembershipDetailResponseBuilder? _data;
  UserMembershipDetailResponseBuilder get data =>
      _$this._data ??= UserMembershipDetailResponseBuilder();
  set data(UserMembershipDetailResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUserMembershipDetailResponseBuilder() {
    BaseResponseUserMembershipDetailResponse._defaults(this);
  }

  BaseResponseUserMembershipDetailResponseBuilder get _$this {
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
  void replace(BaseResponseUserMembershipDetailResponse other) {
    _$v = other as _$BaseResponseUserMembershipDetailResponse;
  }

  @override
  void update(
    void Function(BaseResponseUserMembershipDetailResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUserMembershipDetailResponse build() => _build();

  _$BaseResponseUserMembershipDetailResponse _build() {
    _$BaseResponseUserMembershipDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseUserMembershipDetailResponse._(
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
          r'BaseResponseUserMembershipDetailResponse',
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
