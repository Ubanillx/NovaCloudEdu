// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ppt_generation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PptGenerationRequest extends PptGenerationRequest {
  @override
  final String action;
  @override
  final int? sessionId;
  @override
  final String? message;
  @override
  final String? topic;
  @override
  final String? requirements;
  @override
  final String? feedback;
  @override
  final int? templateId;
  @override
  final String? templateUrl;

  factory _$PptGenerationRequest([
    void Function(PptGenerationRequestBuilder)? updates,
  ]) => (PptGenerationRequestBuilder()..update(updates))._build();

  _$PptGenerationRequest._({
    required this.action,
    this.sessionId,
    this.message,
    this.topic,
    this.requirements,
    this.feedback,
    this.templateId,
    this.templateUrl,
  }) : super._();
  @override
  PptGenerationRequest rebuild(
    void Function(PptGenerationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PptGenerationRequestBuilder toBuilder() =>
      PptGenerationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PptGenerationRequest &&
        action == other.action &&
        sessionId == other.sessionId &&
        message == other.message &&
        topic == other.topic &&
        requirements == other.requirements &&
        feedback == other.feedback &&
        templateId == other.templateId &&
        templateUrl == other.templateUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, topic.hashCode);
    _$hash = $jc(_$hash, requirements.hashCode);
    _$hash = $jc(_$hash, feedback.hashCode);
    _$hash = $jc(_$hash, templateId.hashCode);
    _$hash = $jc(_$hash, templateUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PptGenerationRequest')
          ..add('action', action)
          ..add('sessionId', sessionId)
          ..add('message', message)
          ..add('topic', topic)
          ..add('requirements', requirements)
          ..add('feedback', feedback)
          ..add('templateId', templateId)
          ..add('templateUrl', templateUrl))
        .toString();
  }
}

class PptGenerationRequestBuilder
    implements Builder<PptGenerationRequest, PptGenerationRequestBuilder> {
  _$PptGenerationRequest? _$v;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  int? _sessionId;
  int? get sessionId => _$this._sessionId;
  set sessionId(int? sessionId) => _$this._sessionId = sessionId;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _topic;
  String? get topic => _$this._topic;
  set topic(String? topic) => _$this._topic = topic;

  String? _requirements;
  String? get requirements => _$this._requirements;
  set requirements(String? requirements) => _$this._requirements = requirements;

  String? _feedback;
  String? get feedback => _$this._feedback;
  set feedback(String? feedback) => _$this._feedback = feedback;

  int? _templateId;
  int? get templateId => _$this._templateId;
  set templateId(int? templateId) => _$this._templateId = templateId;

  String? _templateUrl;
  String? get templateUrl => _$this._templateUrl;
  set templateUrl(String? templateUrl) => _$this._templateUrl = templateUrl;

  PptGenerationRequestBuilder() {
    PptGenerationRequest._defaults(this);
  }

  PptGenerationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _sessionId = $v.sessionId;
      _message = $v.message;
      _topic = $v.topic;
      _requirements = $v.requirements;
      _feedback = $v.feedback;
      _templateId = $v.templateId;
      _templateUrl = $v.templateUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PptGenerationRequest other) {
    _$v = other as _$PptGenerationRequest;
  }

  @override
  void update(void Function(PptGenerationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PptGenerationRequest build() => _build();

  _$PptGenerationRequest _build() {
    final _$result =
        _$v ??
        _$PptGenerationRequest._(
          action: BuiltValueNullFieldError.checkNotNull(
            action,
            r'PptGenerationRequest',
            'action',
          ),
          sessionId: sessionId,
          message: message,
          topic: topic,
          requirements: requirements,
          feedback: feedback,
          templateId: templateId,
          templateUrl: templateUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
