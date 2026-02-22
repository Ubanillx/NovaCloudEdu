// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_generate_avatar_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGenerateAvatarResponse
    extends BaseResponseGenerateAvatarResponse {
  @override
  final int? code;
  @override
  final GenerateAvatarResponse? data;
  @override
  final String? message;

  factory _$BaseResponseGenerateAvatarResponse([
    void Function(BaseResponseGenerateAvatarResponseBuilder)? updates,
  ]) => (BaseResponseGenerateAvatarResponseBuilder()..update(updates))._build();

  _$BaseResponseGenerateAvatarResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseGenerateAvatarResponse rebuild(
    void Function(BaseResponseGenerateAvatarResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGenerateAvatarResponseBuilder toBuilder() =>
      BaseResponseGenerateAvatarResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGenerateAvatarResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseGenerateAvatarResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGenerateAvatarResponseBuilder
    implements
        Builder<
          BaseResponseGenerateAvatarResponse,
          BaseResponseGenerateAvatarResponseBuilder
        > {
  _$BaseResponseGenerateAvatarResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GenerateAvatarResponseBuilder? _data;
  GenerateAvatarResponseBuilder get data =>
      _$this._data ??= GenerateAvatarResponseBuilder();
  set data(GenerateAvatarResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGenerateAvatarResponseBuilder() {
    BaseResponseGenerateAvatarResponse._defaults(this);
  }

  BaseResponseGenerateAvatarResponseBuilder get _$this {
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
  void replace(BaseResponseGenerateAvatarResponse other) {
    _$v = other as _$BaseResponseGenerateAvatarResponse;
  }

  @override
  void update(
    void Function(BaseResponseGenerateAvatarResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGenerateAvatarResponse build() => _build();

  _$BaseResponseGenerateAvatarResponse _build() {
    _$BaseResponseGenerateAvatarResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGenerateAvatarResponse._(
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
          r'BaseResponseGenerateAvatarResponse',
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
