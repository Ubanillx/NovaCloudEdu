// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_post_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListPostResponse extends BaseResponseListPostResponse {
  @override
  final int? code;
  @override
  final BuiltList<PostResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListPostResponse([
    void Function(BaseResponseListPostResponseBuilder)? updates,
  ]) => (BaseResponseListPostResponseBuilder()..update(updates))._build();

  _$BaseResponseListPostResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListPostResponse rebuild(
    void Function(BaseResponseListPostResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListPostResponseBuilder toBuilder() =>
      BaseResponseListPostResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListPostResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListPostResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListPostResponseBuilder
    implements
        Builder<
          BaseResponseListPostResponse,
          BaseResponseListPostResponseBuilder
        > {
  _$BaseResponseListPostResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<PostResponse>? _data;
  ListBuilder<PostResponse> get data =>
      _$this._data ??= ListBuilder<PostResponse>();
  set data(ListBuilder<PostResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListPostResponseBuilder() {
    BaseResponseListPostResponse._defaults(this);
  }

  BaseResponseListPostResponseBuilder get _$this {
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
  void replace(BaseResponseListPostResponse other) {
    _$v = other as _$BaseResponseListPostResponse;
  }

  @override
  void update(void Function(BaseResponseListPostResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListPostResponse build() => _build();

  _$BaseResponseListPostResponse _build() {
    _$BaseResponseListPostResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListPostResponse._(
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
          r'BaseResponseListPostResponse',
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
