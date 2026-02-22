// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_page_response_class_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePageResponseClassResponse
    extends BaseResponsePageResponseClassResponse {
  @override
  final int? code;
  @override
  final PageResponseClassResponse? data;
  @override
  final String? message;

  factory _$BaseResponsePageResponseClassResponse([
    void Function(BaseResponsePageResponseClassResponseBuilder)? updates,
  ]) => (BaseResponsePageResponseClassResponseBuilder()..update(updates))
      ._build();

  _$BaseResponsePageResponseClassResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponsePageResponseClassResponse rebuild(
    void Function(BaseResponsePageResponseClassResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePageResponseClassResponseBuilder toBuilder() =>
      BaseResponsePageResponseClassResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePageResponseClassResponse &&
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
            r'BaseResponsePageResponseClassResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePageResponseClassResponseBuilder
    implements
        Builder<
          BaseResponsePageResponseClassResponse,
          BaseResponsePageResponseClassResponseBuilder
        > {
  _$BaseResponsePageResponseClassResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PageResponseClassResponseBuilder? _data;
  PageResponseClassResponseBuilder get data =>
      _$this._data ??= PageResponseClassResponseBuilder();
  set data(PageResponseClassResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePageResponseClassResponseBuilder() {
    BaseResponsePageResponseClassResponse._defaults(this);
  }

  BaseResponsePageResponseClassResponseBuilder get _$this {
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
  void replace(BaseResponsePageResponseClassResponse other) {
    _$v = other as _$BaseResponsePageResponseClassResponse;
  }

  @override
  void update(
    void Function(BaseResponsePageResponseClassResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePageResponseClassResponse build() => _build();

  _$BaseResponsePageResponseClassResponse _build() {
    _$BaseResponsePageResponseClassResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePageResponseClassResponse._(
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
          r'BaseResponsePageResponseClassResponse',
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
