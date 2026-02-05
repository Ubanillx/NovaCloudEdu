// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_banner_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseBannerResponse extends BaseResponseBannerResponse {
  @override
  final int? code;
  @override
  final BannerResponse? data;
  @override
  final String? message;

  factory _$BaseResponseBannerResponse([
    void Function(BaseResponseBannerResponseBuilder)? updates,
  ]) => (BaseResponseBannerResponseBuilder()..update(updates))._build();

  _$BaseResponseBannerResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseBannerResponse rebuild(
    void Function(BaseResponseBannerResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseBannerResponseBuilder toBuilder() =>
      BaseResponseBannerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseBannerResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseBannerResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseBannerResponseBuilder
    implements
        Builder<BaseResponseBannerResponse, BaseResponseBannerResponseBuilder> {
  _$BaseResponseBannerResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  BannerResponseBuilder? _data;
  BannerResponseBuilder get data => _$this._data ??= BannerResponseBuilder();
  set data(BannerResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseBannerResponseBuilder() {
    BaseResponseBannerResponse._defaults(this);
  }

  BaseResponseBannerResponseBuilder get _$this {
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
  void replace(BaseResponseBannerResponse other) {
    _$v = other as _$BaseResponseBannerResponse;
  }

  @override
  void update(void Function(BaseResponseBannerResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseBannerResponse build() => _build();

  _$BaseResponseBannerResponse _build() {
    _$BaseResponseBannerResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseBannerResponse._(
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
          r'BaseResponseBannerResponse',
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
