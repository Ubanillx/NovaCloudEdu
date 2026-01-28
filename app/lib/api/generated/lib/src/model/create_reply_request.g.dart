// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_reply_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateReplyRequest extends CreateReplyRequest {
  @override
  final String content;

  factory _$CreateReplyRequest([
    void Function(CreateReplyRequestBuilder)? updates,
  ]) => (CreateReplyRequestBuilder()..update(updates))._build();

  _$CreateReplyRequest._({required this.content}) : super._();
  @override
  CreateReplyRequest rebuild(
    void Function(CreateReplyRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReplyRequestBuilder toBuilder() =>
      CreateReplyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReplyRequest && content == other.content;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'CreateReplyRequest',
    )..add('content', content)).toString();
  }
}

class CreateReplyRequestBuilder
    implements Builder<CreateReplyRequest, CreateReplyRequestBuilder> {
  _$CreateReplyRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  CreateReplyRequestBuilder() {
    CreateReplyRequest._defaults(this);
  }

  CreateReplyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateReplyRequest other) {
    _$v = other as _$CreateReplyRequest;
  }

  @override
  void update(void Function(CreateReplyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReplyRequest build() => _build();

  _$CreateReplyRequest _build() {
    final _$result =
        _$v ??
        _$CreateReplyRequest._(
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'CreateReplyRequest',
            'content',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
