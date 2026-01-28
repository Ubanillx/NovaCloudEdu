// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePostRequest extends CreatePostRequest {
  @override
  final String title;
  @override
  final String content;
  @override
  final String postType;
  @override
  final BuiltList<String>? tags;

  factory _$CreatePostRequest([
    void Function(CreatePostRequestBuilder)? updates,
  ]) => (CreatePostRequestBuilder()..update(updates))._build();

  _$CreatePostRequest._({
    required this.title,
    required this.content,
    required this.postType,
    this.tags,
  }) : super._();
  @override
  CreatePostRequest rebuild(void Function(CreatePostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePostRequestBuilder toBuilder() =>
      CreatePostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePostRequest &&
        title == other.title &&
        content == other.content &&
        postType == other.postType &&
        tags == other.tags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, postType.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePostRequest')
          ..add('title', title)
          ..add('content', content)
          ..add('postType', postType)
          ..add('tags', tags))
        .toString();
  }
}

class CreatePostRequestBuilder
    implements Builder<CreatePostRequest, CreatePostRequestBuilder> {
  _$CreatePostRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _postType;
  String? get postType => _$this._postType;
  set postType(String? postType) => _$this._postType = postType;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  CreatePostRequestBuilder() {
    CreatePostRequest._defaults(this);
  }

  CreatePostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _postType = $v.postType;
      _tags = $v.tags?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePostRequest other) {
    _$v = other as _$CreatePostRequest;
  }

  @override
  void update(void Function(CreatePostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePostRequest build() => _build();

  _$CreatePostRequest _build() {
    _$CreatePostRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreatePostRequest._(
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'CreatePostRequest',
              'title',
            ),
            content: BuiltValueNullFieldError.checkNotNull(
              content,
              r'CreatePostRequest',
              'content',
            ),
            postType: BuiltValueNullFieldError.checkNotNull(
              postType,
              r'CreatePostRequest',
              'postType',
            ),
            tags: _tags?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreatePostRequest',
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
