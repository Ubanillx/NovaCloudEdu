// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_daily_article_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListDailyArticleResponse
    extends BaseResponseListDailyArticleResponse {
  @override
  final int? code;
  @override
  final BuiltList<DailyArticleResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListDailyArticleResponse([
    void Function(BaseResponseListDailyArticleResponseBuilder)? updates,
  ]) =>
      (BaseResponseListDailyArticleResponseBuilder()..update(updates))._build();

  _$BaseResponseListDailyArticleResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListDailyArticleResponse rebuild(
    void Function(BaseResponseListDailyArticleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListDailyArticleResponseBuilder toBuilder() =>
      BaseResponseListDailyArticleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListDailyArticleResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListDailyArticleResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListDailyArticleResponseBuilder
    implements
        Builder<
          BaseResponseListDailyArticleResponse,
          BaseResponseListDailyArticleResponseBuilder
        > {
  _$BaseResponseListDailyArticleResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<DailyArticleResponse>? _data;
  ListBuilder<DailyArticleResponse> get data =>
      _$this._data ??= ListBuilder<DailyArticleResponse>();
  set data(ListBuilder<DailyArticleResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListDailyArticleResponseBuilder() {
    BaseResponseListDailyArticleResponse._defaults(this);
  }

  BaseResponseListDailyArticleResponseBuilder get _$this {
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
  void replace(BaseResponseListDailyArticleResponse other) {
    _$v = other as _$BaseResponseListDailyArticleResponse;
  }

  @override
  void update(
    void Function(BaseResponseListDailyArticleResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListDailyArticleResponse build() => _build();

  _$BaseResponseListDailyArticleResponse _build() {
    _$BaseResponseListDailyArticleResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListDailyArticleResponse._(
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
          r'BaseResponseListDailyArticleResponse',
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
