// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_daily_article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDailyArticleResponse
    extends BaseResponseDailyArticleResponse {
  @override
  final int? code;
  @override
  final DailyArticleResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDailyArticleResponse([
    void Function(BaseResponseDailyArticleResponseBuilder)? updates,
  ]) => (BaseResponseDailyArticleResponseBuilder()..update(updates))._build();

  _$BaseResponseDailyArticleResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDailyArticleResponse rebuild(
    void Function(BaseResponseDailyArticleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDailyArticleResponseBuilder toBuilder() =>
      BaseResponseDailyArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDailyArticleResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDailyArticleResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDailyArticleResponseBuilder
    implements
        Builder<
          BaseResponseDailyArticleResponse,
          BaseResponseDailyArticleResponseBuilder
        > {
  _$BaseResponseDailyArticleResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DailyArticleResponseBuilder? _data;
  DailyArticleResponseBuilder get data =>
      _$this._data ??= DailyArticleResponseBuilder();
  set data(DailyArticleResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDailyArticleResponseBuilder() {
    BaseResponseDailyArticleResponse._defaults(this);
  }

  BaseResponseDailyArticleResponseBuilder get _$this {
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
  void replace(BaseResponseDailyArticleResponse other) {
    _$v = other as _$BaseResponseDailyArticleResponse;
  }

  @override
  void update(void Function(BaseResponseDailyArticleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDailyArticleResponse build() => _build();

  _$BaseResponseDailyArticleResponse _build() {
    _$BaseResponseDailyArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDailyArticleResponse._(
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
          r'BaseResponseDailyArticleResponse',
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
