// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_chat_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssistantChatRequest extends AssistantChatRequest {
  @override
  final String message;
  @override
  final int? sessionId;
  @override
  final BuiltList<String>? imageUrls;
  @override
  final BuiltList<String>? documentUrls;

  factory _$AssistantChatRequest([
    void Function(AssistantChatRequestBuilder)? updates,
  ]) => (AssistantChatRequestBuilder()..update(updates))._build();

  _$AssistantChatRequest._({
    required this.message,
    this.sessionId,
    this.imageUrls,
    this.documentUrls,
  }) : super._();
  @override
  AssistantChatRequest rebuild(
    void Function(AssistantChatRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AssistantChatRequestBuilder toBuilder() =>
      AssistantChatRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssistantChatRequest &&
        message == other.message &&
        sessionId == other.sessionId &&
        imageUrls == other.imageUrls &&
        documentUrls == other.documentUrls;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, imageUrls.hashCode);
    _$hash = $jc(_$hash, documentUrls.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssistantChatRequest')
          ..add('message', message)
          ..add('sessionId', sessionId)
          ..add('imageUrls', imageUrls)
          ..add('documentUrls', documentUrls))
        .toString();
  }
}

class AssistantChatRequestBuilder
    implements Builder<AssistantChatRequest, AssistantChatRequestBuilder> {
  _$AssistantChatRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  int? _sessionId;
  int? get sessionId => _$this._sessionId;
  set sessionId(int? sessionId) => _$this._sessionId = sessionId;

  ListBuilder<String>? _imageUrls;
  ListBuilder<String> get imageUrls =>
      _$this._imageUrls ??= ListBuilder<String>();
  set imageUrls(ListBuilder<String>? imageUrls) =>
      _$this._imageUrls = imageUrls;

  ListBuilder<String>? _documentUrls;
  ListBuilder<String> get documentUrls =>
      _$this._documentUrls ??= ListBuilder<String>();
  set documentUrls(ListBuilder<String>? documentUrls) =>
      _$this._documentUrls = documentUrls;

  AssistantChatRequestBuilder() {
    AssistantChatRequest._defaults(this);
  }

  AssistantChatRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _sessionId = $v.sessionId;
      _imageUrls = $v.imageUrls?.toBuilder();
      _documentUrls = $v.documentUrls?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssistantChatRequest other) {
    _$v = other as _$AssistantChatRequest;
  }

  @override
  void update(void Function(AssistantChatRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssistantChatRequest build() => _build();

  _$AssistantChatRequest _build() {
    _$AssistantChatRequest _$result;
    try {
      _$result =
          _$v ??
          _$AssistantChatRequest._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'AssistantChatRequest',
              'message',
            ),
            sessionId: sessionId,
            imageUrls: _imageUrls?.build(),
            documentUrls: _documentUrls?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageUrls';
        _imageUrls?.build();
        _$failedField = 'documentUrls';
        _documentUrls?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AssistantChatRequest',
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
