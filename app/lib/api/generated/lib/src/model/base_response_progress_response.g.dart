// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_progress_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseProgressResponse extends BaseResponseProgressResponse {
  @override
  final int? code;
  @override
  final ProgressResponse? data;
  @override
  final String? message;

  factory _$BaseResponseProgressResponse([
    void Function(BaseResponseProgressResponseBuilder)? updates,
  ]) => (BaseResponseProgressResponseBuilder()..update(updates))._build();

  _$BaseResponseProgressResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseProgressResponse rebuild(
    void Function(BaseResponseProgressResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseProgressResponseBuilder toBuilder() =>
      BaseResponseProgressResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseProgressResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseProgressResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseProgressResponseBuilder
    implements
        Builder<
          BaseResponseProgressResponse,
          BaseResponseProgressResponseBuilder
        > {
  _$BaseResponseProgressResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ProgressResponseBuilder? _data;
  ProgressResponseBuilder get data =>
      _$this._data ??= ProgressResponseBuilder();
  set data(ProgressResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseProgressResponseBuilder() {
    BaseResponseProgressResponse._defaults(this);
  }

  BaseResponseProgressResponseBuilder get _$this {
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
  void replace(BaseResponseProgressResponse other) {
    _$v = other as _$BaseResponseProgressResponse;
  }

  @override
  void update(void Function(BaseResponseProgressResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseProgressResponse build() => _build();

  _$BaseResponseProgressResponse _build() {
    _$BaseResponseProgressResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseProgressResponse._(
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
          r'BaseResponseProgressResponse',
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
