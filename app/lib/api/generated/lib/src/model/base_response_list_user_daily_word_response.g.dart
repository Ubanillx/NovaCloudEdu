// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_user_daily_word_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListUserDailyWordResponse
    extends BaseResponseListUserDailyWordResponse {
  @override
  final int? code;
  @override
  final BuiltList<UserDailyWordResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListUserDailyWordResponse([
    void Function(BaseResponseListUserDailyWordResponseBuilder)? updates,
  ]) => (BaseResponseListUserDailyWordResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListUserDailyWordResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListUserDailyWordResponse rebuild(
    void Function(BaseResponseListUserDailyWordResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListUserDailyWordResponseBuilder toBuilder() =>
      BaseResponseListUserDailyWordResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListUserDailyWordResponse &&
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
            r'BaseResponseListUserDailyWordResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListUserDailyWordResponseBuilder
    implements
        Builder<
          BaseResponseListUserDailyWordResponse,
          BaseResponseListUserDailyWordResponseBuilder
        > {
  _$BaseResponseListUserDailyWordResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<UserDailyWordResponse>? _data;
  ListBuilder<UserDailyWordResponse> get data =>
      _$this._data ??= ListBuilder<UserDailyWordResponse>();
  set data(ListBuilder<UserDailyWordResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListUserDailyWordResponseBuilder() {
    BaseResponseListUserDailyWordResponse._defaults(this);
  }

  BaseResponseListUserDailyWordResponseBuilder get _$this {
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
  void replace(BaseResponseListUserDailyWordResponse other) {
    _$v = other as _$BaseResponseListUserDailyWordResponse;
  }

  @override
  void update(
    void Function(BaseResponseListUserDailyWordResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListUserDailyWordResponse build() => _build();

  _$BaseResponseListUserDailyWordResponse _build() {
    _$BaseResponseListUserDailyWordResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListUserDailyWordResponse._(
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
          r'BaseResponseListUserDailyWordResponse',
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
