// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'srs_callback_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SrsCallbackRequest extends SrsCallbackRequest {
  @override
  final String? action;
  @override
  final String? clientId;
  @override
  final String? ip;
  @override
  final String? vhost;
  @override
  final String? app;
  @override
  final String? stream;
  @override
  final String? param;
  @override
  final String? tcUrl;
  @override
  final String? pageUrl;

  factory _$SrsCallbackRequest([
    void Function(SrsCallbackRequestBuilder)? updates,
  ]) => (SrsCallbackRequestBuilder()..update(updates))._build();

  _$SrsCallbackRequest._({
    this.action,
    this.clientId,
    this.ip,
    this.vhost,
    this.app,
    this.stream,
    this.param,
    this.tcUrl,
    this.pageUrl,
  }) : super._();
  @override
  SrsCallbackRequest rebuild(
    void Function(SrsCallbackRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SrsCallbackRequestBuilder toBuilder() =>
      SrsCallbackRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SrsCallbackRequest &&
        action == other.action &&
        clientId == other.clientId &&
        ip == other.ip &&
        vhost == other.vhost &&
        app == other.app &&
        stream == other.stream &&
        param == other.param &&
        tcUrl == other.tcUrl &&
        pageUrl == other.pageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, ip.hashCode);
    _$hash = $jc(_$hash, vhost.hashCode);
    _$hash = $jc(_$hash, app.hashCode);
    _$hash = $jc(_$hash, stream.hashCode);
    _$hash = $jc(_$hash, param.hashCode);
    _$hash = $jc(_$hash, tcUrl.hashCode);
    _$hash = $jc(_$hash, pageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SrsCallbackRequest')
          ..add('action', action)
          ..add('clientId', clientId)
          ..add('ip', ip)
          ..add('vhost', vhost)
          ..add('app', app)
          ..add('stream', stream)
          ..add('param', param)
          ..add('tcUrl', tcUrl)
          ..add('pageUrl', pageUrl))
        .toString();
  }
}

class SrsCallbackRequestBuilder
    implements Builder<SrsCallbackRequest, SrsCallbackRequestBuilder> {
  _$SrsCallbackRequest? _$v;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _ip;
  String? get ip => _$this._ip;
  set ip(String? ip) => _$this._ip = ip;

  String? _vhost;
  String? get vhost => _$this._vhost;
  set vhost(String? vhost) => _$this._vhost = vhost;

  String? _app;
  String? get app => _$this._app;
  set app(String? app) => _$this._app = app;

  String? _stream;
  String? get stream => _$this._stream;
  set stream(String? stream) => _$this._stream = stream;

  String? _param;
  String? get param => _$this._param;
  set param(String? param) => _$this._param = param;

  String? _tcUrl;
  String? get tcUrl => _$this._tcUrl;
  set tcUrl(String? tcUrl) => _$this._tcUrl = tcUrl;

  String? _pageUrl;
  String? get pageUrl => _$this._pageUrl;
  set pageUrl(String? pageUrl) => _$this._pageUrl = pageUrl;

  SrsCallbackRequestBuilder() {
    SrsCallbackRequest._defaults(this);
  }

  SrsCallbackRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _clientId = $v.clientId;
      _ip = $v.ip;
      _vhost = $v.vhost;
      _app = $v.app;
      _stream = $v.stream;
      _param = $v.param;
      _tcUrl = $v.tcUrl;
      _pageUrl = $v.pageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SrsCallbackRequest other) {
    _$v = other as _$SrsCallbackRequest;
  }

  @override
  void update(void Function(SrsCallbackRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SrsCallbackRequest build() => _build();

  _$SrsCallbackRequest _build() {
    final _$result =
        _$v ??
        _$SrsCallbackRequest._(
          action: action,
          clientId: clientId,
          ip: ip,
          vhost: vhost,
          app: app,
          stream: stream,
          param: param,
          tcUrl: tcUrl,
          pageUrl: pageUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
