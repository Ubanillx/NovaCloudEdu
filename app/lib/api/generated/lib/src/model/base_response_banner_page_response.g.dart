// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_banner_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseBannerPageResponse extends BaseResponseBannerPageResponse {
  @override
  final int? code;
  @override
  final BannerPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseBannerPageResponse([
    void Function(BaseResponseBannerPageResponseBuilder)? updates,
  ]) => (BaseResponseBannerPageResponseBuilder()..update(updates))._build();

  _$BaseResponseBannerPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseBannerPageResponse rebuild(
    void Function(BaseResponseBannerPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseBannerPageResponseBuilder toBuilder() =>
      BaseResponseBannerPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseBannerPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseBannerPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseBannerPageResponseBuilder
    implements
        Builder<
          BaseResponseBannerPageResponse,
          BaseResponseBannerPageResponseBuilder
        > {
  _$BaseResponseBannerPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  BannerPageResponseBuilder? _data;
  BannerPageResponseBuilder get data =>
      _$this._data ??= BannerPageResponseBuilder();
  set data(BannerPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseBannerPageResponseBuilder() {
    BaseResponseBannerPageResponse._defaults(this);
  }

  BaseResponseBannerPageResponseBuilder get _$this {
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
  void replace(BaseResponseBannerPageResponse other) {
    _$v = other as _$BaseResponseBannerPageResponse;
  }

  @override
  void update(void Function(BaseResponseBannerPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseBannerPageResponse build() => _build();

  _$BaseResponseBannerPageResponse _build() {
    _$BaseResponseBannerPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseBannerPageResponse._(
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
          r'BaseResponseBannerPageResponse',
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
