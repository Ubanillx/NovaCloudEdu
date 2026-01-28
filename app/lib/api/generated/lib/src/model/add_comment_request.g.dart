// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddCommentRequest extends AddCommentRequest {
  @override
  final String content;

  factory _$AddCommentRequest([
    void Function(AddCommentRequestBuilder)? updates,
  ]) => (AddCommentRequestBuilder()..update(updates))._build();

  _$AddCommentRequest._({required this.content}) : super._();
  @override
  AddCommentRequest rebuild(void Function(AddCommentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddCommentRequestBuilder toBuilder() =>
      AddCommentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddCommentRequest && content == other.content;
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
      r'AddCommentRequest',
    )..add('content', content)).toString();
  }
}

class AddCommentRequestBuilder
    implements Builder<AddCommentRequest, AddCommentRequestBuilder> {
  _$AddCommentRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  AddCommentRequestBuilder() {
    AddCommentRequest._defaults(this);
  }

  AddCommentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddCommentRequest other) {
    _$v = other as _$AddCommentRequest;
  }

  @override
  void update(void Function(AddCommentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddCommentRequest build() => _build();

  _$AddCommentRequest _build() {
    final _$result =
        _$v ??
        _$AddCommentRequest._(
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'AddCommentRequest',
            'content',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
