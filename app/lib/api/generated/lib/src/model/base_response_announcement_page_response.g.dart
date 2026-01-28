// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_announcement_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseAnnouncementPageResponse
    extends BaseResponseAnnouncementPageResponse {
  @override
  final int? code;
  @override
  final AnnouncementPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseAnnouncementPageResponse([
    void Function(BaseResponseAnnouncementPageResponseBuilder)? updates,
  ]) =>
      (BaseResponseAnnouncementPageResponseBuilder()..update(updates))._build();

  _$BaseResponseAnnouncementPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseAnnouncementPageResponse rebuild(
    void Function(BaseResponseAnnouncementPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseAnnouncementPageResponseBuilder toBuilder() =>
      BaseResponseAnnouncementPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseAnnouncementPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseAnnouncementPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseAnnouncementPageResponseBuilder
    implements
        Builder<
          BaseResponseAnnouncementPageResponse,
          BaseResponseAnnouncementPageResponseBuilder
        > {
  _$BaseResponseAnnouncementPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  AnnouncementPageResponseBuilder? _data;
  AnnouncementPageResponseBuilder get data =>
      _$this._data ??= AnnouncementPageResponseBuilder();
  set data(AnnouncementPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseAnnouncementPageResponseBuilder() {
    BaseResponseAnnouncementPageResponse._defaults(this);
  }

  BaseResponseAnnouncementPageResponseBuilder get _$this {
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
  void replace(BaseResponseAnnouncementPageResponse other) {
    _$v = other as _$BaseResponseAnnouncementPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseAnnouncementPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseAnnouncementPageResponse build() => _build();

  _$BaseResponseAnnouncementPageResponse _build() {
    _$BaseResponseAnnouncementPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseAnnouncementPageResponse._(
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
          r'BaseResponseAnnouncementPageResponse',
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
