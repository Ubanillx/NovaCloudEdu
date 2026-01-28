// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_group_member_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListGroupMemberResponse
    extends BaseResponseListGroupMemberResponse {
  @override
  final int? code;
  @override
  final BuiltList<GroupMemberResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListGroupMemberResponse([
    void Function(BaseResponseListGroupMemberResponseBuilder)? updates,
  ]) =>
      (BaseResponseListGroupMemberResponseBuilder()..update(updates))._build();

  _$BaseResponseListGroupMemberResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListGroupMemberResponse rebuild(
    void Function(BaseResponseListGroupMemberResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListGroupMemberResponseBuilder toBuilder() =>
      BaseResponseListGroupMemberResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListGroupMemberResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListGroupMemberResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListGroupMemberResponseBuilder
    implements
        Builder<
          BaseResponseListGroupMemberResponse,
          BaseResponseListGroupMemberResponseBuilder
        > {
  _$BaseResponseListGroupMemberResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<GroupMemberResponse>? _data;
  ListBuilder<GroupMemberResponse> get data =>
      _$this._data ??= ListBuilder<GroupMemberResponse>();
  set data(ListBuilder<GroupMemberResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListGroupMemberResponseBuilder() {
    BaseResponseListGroupMemberResponse._defaults(this);
  }

  BaseResponseListGroupMemberResponseBuilder get _$this {
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
  void replace(BaseResponseListGroupMemberResponse other) {
    _$v = other as _$BaseResponseListGroupMemberResponse;
  }

  @override
  void update(
    void Function(BaseResponseListGroupMemberResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListGroupMemberResponse build() => _build();

  _$BaseResponseListGroupMemberResponse _build() {
    _$BaseResponseListGroupMemberResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListGroupMemberResponse._(
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
          r'BaseResponseListGroupMemberResponse',
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
