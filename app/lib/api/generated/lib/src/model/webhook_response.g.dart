// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WebhookResponse extends WebhookResponse {
  @override
  final String? executionId;
  @override
  final int? workflowId;
  @override
  final String? status;
  @override
  final String? message;

  factory _$WebhookResponse([void Function(WebhookResponseBuilder)? updates]) =>
      (WebhookResponseBuilder()..update(updates))._build();

  _$WebhookResponse._({
    this.executionId,
    this.workflowId,
    this.status,
    this.message,
  }) : super._();
  @override
  WebhookResponse rebuild(void Function(WebhookResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookResponseBuilder toBuilder() => WebhookResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookResponse &&
        executionId == other.executionId &&
        workflowId == other.workflowId &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, executionId.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookResponse')
          ..add('executionId', executionId)
          ..add('workflowId', workflowId)
          ..add('status', status)
          ..add('message', message))
        .toString();
  }
}

class WebhookResponseBuilder
    implements Builder<WebhookResponse, WebhookResponseBuilder> {
  _$WebhookResponse? _$v;

  String? _executionId;
  String? get executionId => _$this._executionId;
  set executionId(String? executionId) => _$this._executionId = executionId;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  WebhookResponseBuilder() {
    WebhookResponse._defaults(this);
  }

  WebhookResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _executionId = $v.executionId;
      _workflowId = $v.workflowId;
      _status = $v.status;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookResponse other) {
    _$v = other as _$WebhookResponse;
  }

  @override
  void update(void Function(WebhookResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookResponse build() => _build();

  _$WebhookResponse _build() {
    final _$result =
        _$v ??
        _$WebhookResponse._(
          executionId: executionId,
          workflowId: workflowId,
          status: status,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
