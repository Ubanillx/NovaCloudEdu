// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_banner_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListBannerListResponse
    extends BaseResponseListBannerListResponse {
  @override
  final int? code;
  @override
  final BuiltList<BannerListResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListBannerListResponse([
    void Function(BaseResponseListBannerListResponseBuilder)? updates,
  ]) => (BaseResponseListBannerListResponseBuilder()..update(updates))._build();

  _$BaseResponseListBannerListResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListBannerListResponse rebuild(
    void Function(BaseResponseListBannerListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListBannerListResponseBuilder toBuilder() =>
      BaseResponseListBannerListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListBannerListResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListBannerListResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListBannerListResponseBuilder
    implements
        Builder<
          BaseResponseListBannerListResponse,
          BaseResponseListBannerListResponseBuilder
        > {
  _$BaseResponseListBannerListResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<BannerListResponse>? _data;
  ListBuilder<BannerListResponse> get data =>
      _$this._data ??= ListBuilder<BannerListResponse>();
  set data(ListBuilder<BannerListResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListBannerListResponseBuilder() {
    BaseResponseListBannerListResponse._defaults(this);
  }

  BaseResponseListBannerListResponseBuilder get _$this {
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
  void replace(BaseResponseListBannerListResponse other) {
    _$v = other as _$BaseResponseListBannerListResponse;
  }

  @override
  void update(
    void Function(BaseResponseListBannerListResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListBannerListResponse build() => _build();

  _$BaseResponseListBannerListResponse _build() {
    _$BaseResponseListBannerListResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListBannerListResponse._(
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
          r'BaseResponseListBannerListResponse',
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
