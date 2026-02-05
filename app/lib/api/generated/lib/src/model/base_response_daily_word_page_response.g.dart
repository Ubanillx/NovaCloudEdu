// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_daily_word_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDailyWordPageResponse
    extends BaseResponseDailyWordPageResponse {
  @override
  final int? code;
  @override
  final DailyWordPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDailyWordPageResponse([
    void Function(BaseResponseDailyWordPageResponseBuilder)? updates,
  ]) => (BaseResponseDailyWordPageResponseBuilder()..update(updates))._build();

  _$BaseResponseDailyWordPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDailyWordPageResponse rebuild(
    void Function(BaseResponseDailyWordPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDailyWordPageResponseBuilder toBuilder() =>
      BaseResponseDailyWordPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDailyWordPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDailyWordPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDailyWordPageResponseBuilder
    implements
        Builder<
          BaseResponseDailyWordPageResponse,
          BaseResponseDailyWordPageResponseBuilder
        > {
  _$BaseResponseDailyWordPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DailyWordPageResponseBuilder? _data;
  DailyWordPageResponseBuilder get data =>
      _$this._data ??= DailyWordPageResponseBuilder();
  set data(DailyWordPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDailyWordPageResponseBuilder() {
    BaseResponseDailyWordPageResponse._defaults(this);
  }

  BaseResponseDailyWordPageResponseBuilder get _$this {
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
  void replace(BaseResponseDailyWordPageResponse other) {
    _$v = other as _$BaseResponseDailyWordPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseDailyWordPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDailyWordPageResponse build() => _build();

  _$BaseResponseDailyWordPageResponse _build() {
    _$BaseResponseDailyWordPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDailyWordPageResponse._(
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
          r'BaseResponseDailyWordPageResponse',
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
