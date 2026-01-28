// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateCommentRequest extends CreateCommentRequest {
  @override
  final String content;

  factory _$CreateCommentRequest([
    void Function(CreateCommentRequestBuilder)? updates,
  ]) => (CreateCommentRequestBuilder()..update(updates))._build();

  _$CreateCommentRequest._({required this.content}) : super._();
  @override
  CreateCommentRequest rebuild(
    void Function(CreateCommentRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateCommentRequestBuilder toBuilder() =>
      CreateCommentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCommentRequest && content == other.content;
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
      r'CreateCommentRequest',
    )..add('content', content)).toString();
  }
}

class CreateCommentRequestBuilder
    implements Builder<CreateCommentRequest, CreateCommentRequestBuilder> {
  _$CreateCommentRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  CreateCommentRequestBuilder() {
    CreateCommentRequest._defaults(this);
  }

  CreateCommentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateCommentRequest other) {
    _$v = other as _$CreateCommentRequest;
  }

  @override
  void update(void Function(CreateCommentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCommentRequest build() => _build();

  _$CreateCommentRequest _build() {
    final _$result =
        _$v ??
        _$CreateCommentRequest._(
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'CreateCommentRequest',
            'content',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
