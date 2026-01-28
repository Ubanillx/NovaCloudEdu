// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_user_announcement_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUserAnnouncementPageResponse
    extends BaseResponseUserAnnouncementPageResponse {
  @override
  final int? code;
  @override
  final UserAnnouncementPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseUserAnnouncementPageResponse([
    void Function(BaseResponseUserAnnouncementPageResponseBuilder)? updates,
  ]) => (BaseResponseUserAnnouncementPageResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseUserAnnouncementPageResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseUserAnnouncementPageResponse rebuild(
    void Function(BaseResponseUserAnnouncementPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseUserAnnouncementPageResponseBuilder toBuilder() =>
      BaseResponseUserAnnouncementPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUserAnnouncementPageResponse &&
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
            r'BaseResponseUserAnnouncementPageResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUserAnnouncementPageResponseBuilder
    implements
        Builder<
          BaseResponseUserAnnouncementPageResponse,
          BaseResponseUserAnnouncementPageResponseBuilder
        > {
  _$BaseResponseUserAnnouncementPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UserAnnouncementPageResponseBuilder? _data;
  UserAnnouncementPageResponseBuilder get data =>
      _$this._data ??= UserAnnouncementPageResponseBuilder();
  set data(UserAnnouncementPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUserAnnouncementPageResponseBuilder() {
    BaseResponseUserAnnouncementPageResponse._defaults(this);
  }

  BaseResponseUserAnnouncementPageResponseBuilder get _$this {
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
  void replace(BaseResponseUserAnnouncementPageResponse other) {
    _$v = other as _$BaseResponseUserAnnouncementPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseUserAnnouncementPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUserAnnouncementPageResponse build() => _build();

  _$BaseResponseUserAnnouncementPageResponse _build() {
    _$BaseResponseUserAnnouncementPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseUserAnnouncementPageResponse._(
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
          r'BaseResponseUserAnnouncementPageResponse',
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
