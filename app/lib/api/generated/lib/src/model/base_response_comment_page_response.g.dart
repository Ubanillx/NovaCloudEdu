// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_comment_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseCommentPageResponse
    extends BaseResponseCommentPageResponse {
  @override
  final int? code;
  @override
  final CommentPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseCommentPageResponse([
    void Function(BaseResponseCommentPageResponseBuilder)? updates,
  ]) => (BaseResponseCommentPageResponseBuilder()..update(updates))._build();

  _$BaseResponseCommentPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseCommentPageResponse rebuild(
    void Function(BaseResponseCommentPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseCommentPageResponseBuilder toBuilder() =>
      BaseResponseCommentPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseCommentPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseCommentPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseCommentPageResponseBuilder
    implements
        Builder<
          BaseResponseCommentPageResponse,
          BaseResponseCommentPageResponseBuilder
        > {
  _$BaseResponseCommentPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  CommentPageResponseBuilder? _data;
  CommentPageResponseBuilder get data =>
      _$this._data ??= CommentPageResponseBuilder();
  set data(CommentPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseCommentPageResponseBuilder() {
    BaseResponseCommentPageResponse._defaults(this);
  }

  BaseResponseCommentPageResponseBuilder get _$this {
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
  void replace(BaseResponseCommentPageResponse other) {
    _$v = other as _$BaseResponseCommentPageResponse;
  }

  @override
  void update(void Function(BaseResponseCommentPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseCommentPageResponse build() => _build();

  _$BaseResponseCommentPageResponse _build() {
    _$BaseResponseCommentPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseCommentPageResponse._(
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
          r'BaseResponseCommentPageResponse',
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
