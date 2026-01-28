// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_group_message_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGroupMessagePageResponse
    extends BaseResponseGroupMessagePageResponse {
  @override
  final int? code;
  @override
  final GroupMessagePageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseGroupMessagePageResponse([
    void Function(BaseResponseGroupMessagePageResponseBuilder)? updates,
  ]) =>
      (BaseResponseGroupMessagePageResponseBuilder()..update(updates))._build();

  _$BaseResponseGroupMessagePageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseGroupMessagePageResponse rebuild(
    void Function(BaseResponseGroupMessagePageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGroupMessagePageResponseBuilder toBuilder() =>
      BaseResponseGroupMessagePageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGroupMessagePageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseGroupMessagePageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGroupMessagePageResponseBuilder
    implements
        Builder<
          BaseResponseGroupMessagePageResponse,
          BaseResponseGroupMessagePageResponseBuilder
        > {
  _$BaseResponseGroupMessagePageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GroupMessagePageResponseBuilder? _data;
  GroupMessagePageResponseBuilder get data =>
      _$this._data ??= GroupMessagePageResponseBuilder();
  set data(GroupMessagePageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGroupMessagePageResponseBuilder() {
    BaseResponseGroupMessagePageResponse._defaults(this);
  }

  BaseResponseGroupMessagePageResponseBuilder get _$this {
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
  void replace(BaseResponseGroupMessagePageResponse other) {
    _$v = other as _$BaseResponseGroupMessagePageResponse;
  }

  @override
  void update(
    void Function(BaseResponseGroupMessagePageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGroupMessagePageResponse build() => _build();

  _$BaseResponseGroupMessagePageResponse _build() {
    _$BaseResponseGroupMessagePageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGroupMessagePageResponse._(
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
          r'BaseResponseGroupMessagePageResponse',
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
