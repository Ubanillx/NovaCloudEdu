// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webhook_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WebhookInfo extends WebhookInfo {
  @override
  final int? triggerId;
  @override
  final String? triggerName;
  @override
  final int? workflowId;
  @override
  final String? webhookPath;
  @override
  final bool? enabled;
  @override
  final int? triggerCount;
  @override
  final DateTime? lastTriggeredAt;

  factory _$WebhookInfo([void Function(WebhookInfoBuilder)? updates]) =>
      (WebhookInfoBuilder()..update(updates))._build();

  _$WebhookInfo._({
    this.triggerId,
    this.triggerName,
    this.workflowId,
    this.webhookPath,
    this.enabled,
    this.triggerCount,
    this.lastTriggeredAt,
  }) : super._();
  @override
  WebhookInfo rebuild(void Function(WebhookInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WebhookInfoBuilder toBuilder() => WebhookInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WebhookInfo &&
        triggerId == other.triggerId &&
        triggerName == other.triggerName &&
        workflowId == other.workflowId &&
        webhookPath == other.webhookPath &&
        enabled == other.enabled &&
        triggerCount == other.triggerCount &&
        lastTriggeredAt == other.lastTriggeredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, triggerId.hashCode);
    _$hash = $jc(_$hash, triggerName.hashCode);
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, webhookPath.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, triggerCount.hashCode);
    _$hash = $jc(_$hash, lastTriggeredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WebhookInfo')
          ..add('triggerId', triggerId)
          ..add('triggerName', triggerName)
          ..add('workflowId', workflowId)
          ..add('webhookPath', webhookPath)
          ..add('enabled', enabled)
          ..add('triggerCount', triggerCount)
          ..add('lastTriggeredAt', lastTriggeredAt))
        .toString();
  }
}

class WebhookInfoBuilder implements Builder<WebhookInfo, WebhookInfoBuilder> {
  _$WebhookInfo? _$v;

  int? _triggerId;
  int? get triggerId => _$this._triggerId;
  set triggerId(int? triggerId) => _$this._triggerId = triggerId;

  String? _triggerName;
  String? get triggerName => _$this._triggerName;
  set triggerName(String? triggerName) => _$this._triggerName = triggerName;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  String? _webhookPath;
  String? get webhookPath => _$this._webhookPath;
  set webhookPath(String? webhookPath) => _$this._webhookPath = webhookPath;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  int? _triggerCount;
  int? get triggerCount => _$this._triggerCount;
  set triggerCount(int? triggerCount) => _$this._triggerCount = triggerCount;

  DateTime? _lastTriggeredAt;
  DateTime? get lastTriggeredAt => _$this._lastTriggeredAt;
  set lastTriggeredAt(DateTime? lastTriggeredAt) =>
      _$this._lastTriggeredAt = lastTriggeredAt;

  WebhookInfoBuilder() {
    WebhookInfo._defaults(this);
  }

  WebhookInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _triggerId = $v.triggerId;
      _triggerName = $v.triggerName;
      _workflowId = $v.workflowId;
      _webhookPath = $v.webhookPath;
      _enabled = $v.enabled;
      _triggerCount = $v.triggerCount;
      _lastTriggeredAt = $v.lastTriggeredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WebhookInfo other) {
    _$v = other as _$WebhookInfo;
  }

  @override
  void update(void Function(WebhookInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WebhookInfo build() => _build();

  _$WebhookInfo _build() {
    final _$result =
        _$v ??
        _$WebhookInfo._(
          triggerId: triggerId,
          triggerName: triggerName,
          workflowId: workflowId,
          webhookPath: webhookPath,
          enabled: enabled,
          triggerCount: triggerCount,
          lastTriggeredAt: lastTriggeredAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
