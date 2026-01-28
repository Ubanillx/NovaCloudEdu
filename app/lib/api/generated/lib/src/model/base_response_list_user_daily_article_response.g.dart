// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_user_daily_article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListUserDailyArticleResponse
    extends BaseResponseListUserDailyArticleResponse {
  @override
  final int? code;
  @override
  final BuiltList<UserDailyArticleResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListUserDailyArticleResponse([
    void Function(BaseResponseListUserDailyArticleResponseBuilder)? updates,
  ]) => (BaseResponseListUserDailyArticleResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListUserDailyArticleResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListUserDailyArticleResponse rebuild(
    void Function(BaseResponseListUserDailyArticleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListUserDailyArticleResponseBuilder toBuilder() =>
      BaseResponseListUserDailyArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListUserDailyArticleResponse &&
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
            r'BaseResponseListUserDailyArticleResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListUserDailyArticleResponseBuilder
    implements
        Builder<
          BaseResponseListUserDailyArticleResponse,
          BaseResponseListUserDailyArticleResponseBuilder
        > {
  _$BaseResponseListUserDailyArticleResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<UserDailyArticleResponse>? _data;
  ListBuilder<UserDailyArticleResponse> get data =>
      _$this._data ??= ListBuilder<UserDailyArticleResponse>();
  set data(ListBuilder<UserDailyArticleResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListUserDailyArticleResponseBuilder() {
    BaseResponseListUserDailyArticleResponse._defaults(this);
  }

  BaseResponseListUserDailyArticleResponseBuilder get _$this {
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
  void replace(BaseResponseListUserDailyArticleResponse other) {
    _$v = other as _$BaseResponseListUserDailyArticleResponse;
  }

  @override
  void update(
    void Function(BaseResponseListUserDailyArticleResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListUserDailyArticleResponse build() => _build();

  _$BaseResponseListUserDailyArticleResponse _build() {
    _$BaseResponseListUserDailyArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListUserDailyArticleResponse._(
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
          r'BaseResponseListUserDailyArticleResponse',
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
