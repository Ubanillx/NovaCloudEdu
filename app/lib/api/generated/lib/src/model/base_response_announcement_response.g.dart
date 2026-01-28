// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_announcement_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseAnnouncementResponse
    extends BaseResponseAnnouncementResponse {
  @override
  final int? code;
  @override
  final AnnouncementResponse? data;
  @override
  final String? message;

  factory _$BaseResponseAnnouncementResponse([
    void Function(BaseResponseAnnouncementResponseBuilder)? updates,
  ]) => (BaseResponseAnnouncementResponseBuilder()..update(updates))._build();

  _$BaseResponseAnnouncementResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseAnnouncementResponse rebuild(
    void Function(BaseResponseAnnouncementResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseAnnouncementResponseBuilder toBuilder() =>
      BaseResponseAnnouncementResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseAnnouncementResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseAnnouncementResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseAnnouncementResponseBuilder
    implements
        Builder<
          BaseResponseAnnouncementResponse,
          BaseResponseAnnouncementResponseBuilder
        > {
  _$BaseResponseAnnouncementResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  AnnouncementResponseBuilder? _data;
  AnnouncementResponseBuilder get data =>
      _$this._data ??= AnnouncementResponseBuilder();
  set data(AnnouncementResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseAnnouncementResponseBuilder() {
    BaseResponseAnnouncementResponse._defaults(this);
  }

  BaseResponseAnnouncementResponseBuilder get _$this {
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
  void replace(BaseResponseAnnouncementResponse other) {
    _$v = other as _$BaseResponseAnnouncementResponse;
  }

  @override
  void update(void Function(BaseResponseAnnouncementResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseAnnouncementResponse build() => _build();

  _$BaseResponseAnnouncementResponse _build() {
    _$BaseResponseAnnouncementResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseAnnouncementResponse._(
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
          r'BaseResponseAnnouncementResponse',
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
