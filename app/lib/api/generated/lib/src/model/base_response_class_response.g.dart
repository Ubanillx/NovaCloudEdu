// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_class_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseClassResponse extends BaseResponseClassResponse {
  @override
  final int? code;
  @override
  final ClassResponse? data;
  @override
  final String? message;

  factory _$BaseResponseClassResponse([
    void Function(BaseResponseClassResponseBuilder)? updates,
  ]) => (BaseResponseClassResponseBuilder()..update(updates))._build();

  _$BaseResponseClassResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseClassResponse rebuild(
    void Function(BaseResponseClassResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseClassResponseBuilder toBuilder() =>
      BaseResponseClassResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseClassResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseClassResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseClassResponseBuilder
    implements
        Builder<BaseResponseClassResponse, BaseResponseClassResponseBuilder> {
  _$BaseResponseClassResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ClassResponseBuilder? _data;
  ClassResponseBuilder get data => _$this._data ??= ClassResponseBuilder();
  set data(ClassResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseClassResponseBuilder() {
    BaseResponseClassResponse._defaults(this);
  }

  BaseResponseClassResponseBuilder get _$this {
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
  void replace(BaseResponseClassResponse other) {
    _$v = other as _$BaseResponseClassResponse;
  }

  @override
  void update(void Function(BaseResponseClassResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseClassResponse build() => _build();

  _$BaseResponseClassResponse _build() {
    _$BaseResponseClassResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseClassResponse._(
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
          r'BaseResponseClassResponse',
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
