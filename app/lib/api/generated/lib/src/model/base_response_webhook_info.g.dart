// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_webhook_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWebhookInfo extends BaseResponseWebhookInfo {
  @override
  final int? code;
  @override
  final WebhookInfo? data;
  @override
  final String? message;

  factory _$BaseResponseWebhookInfo([
    void Function(BaseResponseWebhookInfoBuilder)? updates,
  ]) => (BaseResponseWebhookInfoBuilder()..update(updates))._build();

  _$BaseResponseWebhookInfo._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseWebhookInfo rebuild(
    void Function(BaseResponseWebhookInfoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWebhookInfoBuilder toBuilder() =>
      BaseResponseWebhookInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWebhookInfo &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWebhookInfo')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWebhookInfoBuilder
    implements
        Builder<BaseResponseWebhookInfo, BaseResponseWebhookInfoBuilder> {
  _$BaseResponseWebhookInfo? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WebhookInfoBuilder? _data;
  WebhookInfoBuilder get data => _$this._data ??= WebhookInfoBuilder();
  set data(WebhookInfoBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWebhookInfoBuilder() {
    BaseResponseWebhookInfo._defaults(this);
  }

  BaseResponseWebhookInfoBuilder get _$this {
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
  void replace(BaseResponseWebhookInfo other) {
    _$v = other as _$BaseResponseWebhookInfo;
  }

  @override
  void update(void Function(BaseResponseWebhookInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWebhookInfo build() => _build();

  _$BaseResponseWebhookInfo _build() {
    _$BaseResponseWebhookInfo _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWebhookInfo._(
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
          r'BaseResponseWebhookInfo',
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
