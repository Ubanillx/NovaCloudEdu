// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_chat_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionChatRequest extends SessionChatRequest {
  @override
  final String message;
  @override
  final String? systemPrompt;
  @override
  final BuiltList<String>? imageUrls;
  @override
  final String? modelId;

  factory _$SessionChatRequest([
    void Function(SessionChatRequestBuilder)? updates,
  ]) => (SessionChatRequestBuilder()..update(updates))._build();

  _$SessionChatRequest._({
    required this.message,
    this.systemPrompt,
    this.imageUrls,
    this.modelId,
  }) : super._();
  @override
  SessionChatRequest rebuild(
    void Function(SessionChatRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SessionChatRequestBuilder toBuilder() =>
      SessionChatRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionChatRequest &&
        message == other.message &&
        systemPrompt == other.systemPrompt &&
        imageUrls == other.imageUrls &&
        modelId == other.modelId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, systemPrompt.hashCode);
    _$hash = $jc(_$hash, imageUrls.hashCode);
    _$hash = $jc(_$hash, modelId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionChatRequest')
          ..add('message', message)
          ..add('systemPrompt', systemPrompt)
          ..add('imageUrls', imageUrls)
          ..add('modelId', modelId))
        .toString();
  }
}

class SessionChatRequestBuilder
    implements Builder<SessionChatRequest, SessionChatRequestBuilder> {
  _$SessionChatRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _systemPrompt;
  String? get systemPrompt => _$this._systemPrompt;
  set systemPrompt(String? systemPrompt) => _$this._systemPrompt = systemPrompt;

  ListBuilder<String>? _imageUrls;
  ListBuilder<String> get imageUrls =>
      _$this._imageUrls ??= ListBuilder<String>();
  set imageUrls(ListBuilder<String>? imageUrls) =>
      _$this._imageUrls = imageUrls;

  String? _modelId;
  String? get modelId => _$this._modelId;
  set modelId(String? modelId) => _$this._modelId = modelId;

  SessionChatRequestBuilder() {
    SessionChatRequest._defaults(this);
  }

  SessionChatRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _systemPrompt = $v.systemPrompt;
      _imageUrls = $v.imageUrls?.toBuilder();
      _modelId = $v.modelId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionChatRequest other) {
    _$v = other as _$SessionChatRequest;
  }

  @override
  void update(void Function(SessionChatRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionChatRequest build() => _build();

  _$SessionChatRequest _build() {
    _$SessionChatRequest _$result;
    try {
      _$result =
          _$v ??
          _$SessionChatRequest._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'SessionChatRequest',
              'message',
            ),
            systemPrompt: systemPrompt,
            imageUrls: _imageUrls?.build(),
            modelId: modelId,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageUrls';
        _imageUrls?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SessionChatRequest',
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
