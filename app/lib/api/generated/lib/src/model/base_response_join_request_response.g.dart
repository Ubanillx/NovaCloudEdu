// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_join_request_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseJoinRequestResponse
    extends BaseResponseJoinRequestResponse {
  @override
  final int? code;
  @override
  final JoinRequestResponse? data;
  @override
  final String? message;

  factory _$BaseResponseJoinRequestResponse([
    void Function(BaseResponseJoinRequestResponseBuilder)? updates,
  ]) => (BaseResponseJoinRequestResponseBuilder()..update(updates))._build();

  _$BaseResponseJoinRequestResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseJoinRequestResponse rebuild(
    void Function(BaseResponseJoinRequestResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseJoinRequestResponseBuilder toBuilder() =>
      BaseResponseJoinRequestResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseJoinRequestResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseJoinRequestResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseJoinRequestResponseBuilder
    implements
        Builder<
          BaseResponseJoinRequestResponse,
          BaseResponseJoinRequestResponseBuilder
        > {
  _$BaseResponseJoinRequestResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  JoinRequestResponseBuilder? _data;
  JoinRequestResponseBuilder get data =>
      _$this._data ??= JoinRequestResponseBuilder();
  set data(JoinRequestResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseJoinRequestResponseBuilder() {
    BaseResponseJoinRequestResponse._defaults(this);
  }

  BaseResponseJoinRequestResponseBuilder get _$this {
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
  void replace(BaseResponseJoinRequestResponse other) {
    _$v = other as _$BaseResponseJoinRequestResponse;
  }

  @override
  void update(void Function(BaseResponseJoinRequestResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseJoinRequestResponse build() => _build();

  _$BaseResponseJoinRequestResponse _build() {
    _$BaseResponseJoinRequestResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseJoinRequestResponse._(
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
          r'BaseResponseJoinRequestResponse',
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
