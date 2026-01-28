// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_webhook_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWebhookResponse extends BaseResponseWebhookResponse {
  @override
  final int? code;
  @override
  final WebhookResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWebhookResponse([
    void Function(BaseResponseWebhookResponseBuilder)? updates,
  ]) => (BaseResponseWebhookResponseBuilder()..update(updates))._build();

  _$BaseResponseWebhookResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWebhookResponse rebuild(
    void Function(BaseResponseWebhookResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWebhookResponseBuilder toBuilder() =>
      BaseResponseWebhookResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWebhookResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWebhookResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWebhookResponseBuilder
    implements
        Builder<
          BaseResponseWebhookResponse,
          BaseResponseWebhookResponseBuilder
        > {
  _$BaseResponseWebhookResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WebhookResponseBuilder? _data;
  WebhookResponseBuilder get data => _$this._data ??= WebhookResponseBuilder();
  set data(WebhookResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWebhookResponseBuilder() {
    BaseResponseWebhookResponse._defaults(this);
  }

  BaseResponseWebhookResponseBuilder get _$this {
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
  void replace(BaseResponseWebhookResponse other) {
    _$v = other as _$BaseResponseWebhookResponse;
  }

  @override
  void update(void Function(BaseResponseWebhookResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWebhookResponse build() => _build();

  _$BaseResponseWebhookResponse _build() {
    _$BaseResponseWebhookResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWebhookResponse._(
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
          r'BaseResponseWebhookResponse',
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
