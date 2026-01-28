// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_user_word_book_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListUserWordBookResponse
    extends BaseResponseListUserWordBookResponse {
  @override
  final int? code;
  @override
  final BuiltList<UserWordBookResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListUserWordBookResponse([
    void Function(BaseResponseListUserWordBookResponseBuilder)? updates,
  ]) =>
      (BaseResponseListUserWordBookResponseBuilder()..update(updates))._build();

  _$BaseResponseListUserWordBookResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListUserWordBookResponse rebuild(
    void Function(BaseResponseListUserWordBookResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListUserWordBookResponseBuilder toBuilder() =>
      BaseResponseListUserWordBookResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListUserWordBookResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListUserWordBookResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListUserWordBookResponseBuilder
    implements
        Builder<
          BaseResponseListUserWordBookResponse,
          BaseResponseListUserWordBookResponseBuilder
        > {
  _$BaseResponseListUserWordBookResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<UserWordBookResponse>? _data;
  ListBuilder<UserWordBookResponse> get data =>
      _$this._data ??= ListBuilder<UserWordBookResponse>();
  set data(ListBuilder<UserWordBookResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListUserWordBookResponseBuilder() {
    BaseResponseListUserWordBookResponse._defaults(this);
  }

  BaseResponseListUserWordBookResponseBuilder get _$this {
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
  void replace(BaseResponseListUserWordBookResponse other) {
    _$v = other as _$BaseResponseListUserWordBookResponse;
  }

  @override
  void update(
    void Function(BaseResponseListUserWordBookResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListUserWordBookResponse build() => _build();

  _$BaseResponseListUserWordBookResponse _build() {
    _$BaseResponseListUserWordBookResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListUserWordBookResponse._(
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
          r'BaseResponseListUserWordBookResponse',
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
