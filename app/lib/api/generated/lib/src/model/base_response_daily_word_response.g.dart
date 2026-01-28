// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_daily_word_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDailyWordResponse extends BaseResponseDailyWordResponse {
  @override
  final int? code;
  @override
  final DailyWordResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDailyWordResponse([
    void Function(BaseResponseDailyWordResponseBuilder)? updates,
  ]) => (BaseResponseDailyWordResponseBuilder()..update(updates))._build();

  _$BaseResponseDailyWordResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDailyWordResponse rebuild(
    void Function(BaseResponseDailyWordResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDailyWordResponseBuilder toBuilder() =>
      BaseResponseDailyWordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDailyWordResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDailyWordResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDailyWordResponseBuilder
    implements
        Builder<
          BaseResponseDailyWordResponse,
          BaseResponseDailyWordResponseBuilder
        > {
  _$BaseResponseDailyWordResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DailyWordResponseBuilder? _data;
  DailyWordResponseBuilder get data =>
      _$this._data ??= DailyWordResponseBuilder();
  set data(DailyWordResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDailyWordResponseBuilder() {
    BaseResponseDailyWordResponse._defaults(this);
  }

  BaseResponseDailyWordResponseBuilder get _$this {
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
  void replace(BaseResponseDailyWordResponse other) {
    _$v = other as _$BaseResponseDailyWordResponse;
  }

  @override
  void update(void Function(BaseResponseDailyWordResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDailyWordResponse build() => _build();

  _$BaseResponseDailyWordResponse _build() {
    _$BaseResponseDailyWordResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDailyWordResponse._(
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
          r'BaseResponseDailyWordResponse',
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
