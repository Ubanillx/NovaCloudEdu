// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_join_request_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListJoinRequestResponse
    extends BaseResponseListJoinRequestResponse {
  @override
  final int? code;
  @override
  final BuiltList<JoinRequestResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListJoinRequestResponse([
    void Function(BaseResponseListJoinRequestResponseBuilder)? updates,
  ]) =>
      (BaseResponseListJoinRequestResponseBuilder()..update(updates))._build();

  _$BaseResponseListJoinRequestResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListJoinRequestResponse rebuild(
    void Function(BaseResponseListJoinRequestResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListJoinRequestResponseBuilder toBuilder() =>
      BaseResponseListJoinRequestResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListJoinRequestResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListJoinRequestResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListJoinRequestResponseBuilder
    implements
        Builder<
          BaseResponseListJoinRequestResponse,
          BaseResponseListJoinRequestResponseBuilder
        > {
  _$BaseResponseListJoinRequestResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<JoinRequestResponse>? _data;
  ListBuilder<JoinRequestResponse> get data =>
      _$this._data ??= ListBuilder<JoinRequestResponse>();
  set data(ListBuilder<JoinRequestResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListJoinRequestResponseBuilder() {
    BaseResponseListJoinRequestResponse._defaults(this);
  }

  BaseResponseListJoinRequestResponseBuilder get _$this {
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
  void replace(BaseResponseListJoinRequestResponse other) {
    _$v = other as _$BaseResponseListJoinRequestResponse;
  }

  @override
  void update(
    void Function(BaseResponseListJoinRequestResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListJoinRequestResponse build() => _build();

  _$BaseResponseListJoinRequestResponse _build() {
    _$BaseResponseListJoinRequestResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListJoinRequestResponse._(
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
          r'BaseResponseListJoinRequestResponse',
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
