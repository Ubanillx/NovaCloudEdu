// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_post_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePostDetailResponse extends BaseResponsePostDetailResponse {
  @override
  final int? code;
  @override
  final PostDetailResponse? data;
  @override
  final String? message;

  factory _$BaseResponsePostDetailResponse([
    void Function(BaseResponsePostDetailResponseBuilder)? updates,
  ]) => (BaseResponsePostDetailResponseBuilder()..update(updates))._build();

  _$BaseResponsePostDetailResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponsePostDetailResponse rebuild(
    void Function(BaseResponsePostDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePostDetailResponseBuilder toBuilder() =>
      BaseResponsePostDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePostDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponsePostDetailResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePostDetailResponseBuilder
    implements
        Builder<
          BaseResponsePostDetailResponse,
          BaseResponsePostDetailResponseBuilder
        > {
  _$BaseResponsePostDetailResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PostDetailResponseBuilder? _data;
  PostDetailResponseBuilder get data =>
      _$this._data ??= PostDetailResponseBuilder();
  set data(PostDetailResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePostDetailResponseBuilder() {
    BaseResponsePostDetailResponse._defaults(this);
  }

  BaseResponsePostDetailResponseBuilder get _$this {
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
  void replace(BaseResponsePostDetailResponse other) {
    _$v = other as _$BaseResponsePostDetailResponse;
  }

  @override
  void update(void Function(BaseResponsePostDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePostDetailResponse build() => _build();

  _$BaseResponsePostDetailResponse _build() {
    _$BaseResponsePostDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePostDetailResponse._(
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
          r'BaseResponsePostDetailResponse',
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
