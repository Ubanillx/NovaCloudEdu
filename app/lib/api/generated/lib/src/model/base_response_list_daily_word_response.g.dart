// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_daily_word_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListDailyWordResponse
    extends BaseResponseListDailyWordResponse {
  @override
  final int? code;
  @override
  final BuiltList<DailyWordResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListDailyWordResponse([
    void Function(BaseResponseListDailyWordResponseBuilder)? updates,
  ]) => (BaseResponseListDailyWordResponseBuilder()..update(updates))._build();

  _$BaseResponseListDailyWordResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListDailyWordResponse rebuild(
    void Function(BaseResponseListDailyWordResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListDailyWordResponseBuilder toBuilder() =>
      BaseResponseListDailyWordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListDailyWordResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListDailyWordResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListDailyWordResponseBuilder
    implements
        Builder<
          BaseResponseListDailyWordResponse,
          BaseResponseListDailyWordResponseBuilder
        > {
  _$BaseResponseListDailyWordResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<DailyWordResponse>? _data;
  ListBuilder<DailyWordResponse> get data =>
      _$this._data ??= ListBuilder<DailyWordResponse>();
  set data(ListBuilder<DailyWordResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListDailyWordResponseBuilder() {
    BaseResponseListDailyWordResponse._defaults(this);
  }

  BaseResponseListDailyWordResponseBuilder get _$this {
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
  void replace(BaseResponseListDailyWordResponse other) {
    _$v = other as _$BaseResponseListDailyWordResponse;
  }

  @override
  void update(
    void Function(BaseResponseListDailyWordResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListDailyWordResponse build() => _build();

  _$BaseResponseListDailyWordResponse _build() {
    _$BaseResponseListDailyWordResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListDailyWordResponse._(
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
          r'BaseResponseListDailyWordResponse',
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
