// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePostRequest extends UpdatePostRequest {
  @override
  final String? title;
  @override
  final String? content;
  @override
  final BuiltList<String>? tags;
  @override
  final String? postType;

  factory _$UpdatePostRequest([
    void Function(UpdatePostRequestBuilder)? updates,
  ]) => (UpdatePostRequestBuilder()..update(updates))._build();

  _$UpdatePostRequest._({this.title, this.content, this.tags, this.postType})
    : super._();
  @override
  UpdatePostRequest rebuild(void Function(UpdatePostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePostRequestBuilder toBuilder() =>
      UpdatePostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePostRequest &&
        title == other.title &&
        content == other.content &&
        tags == other.tags &&
        postType == other.postType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, postType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePostRequest')
          ..add('title', title)
          ..add('content', content)
          ..add('tags', tags)
          ..add('postType', postType))
        .toString();
  }
}

class UpdatePostRequestBuilder
    implements Builder<UpdatePostRequest, UpdatePostRequestBuilder> {
  _$UpdatePostRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _postType;
  String? get postType => _$this._postType;
  set postType(String? postType) => _$this._postType = postType;

  UpdatePostRequestBuilder() {
    UpdatePostRequest._defaults(this);
  }

  UpdatePostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _content = $v.content;
      _tags = $v.tags?.toBuilder();
      _postType = $v.postType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePostRequest other) {
    _$v = other as _$UpdatePostRequest;
  }

  @override
  void update(void Function(UpdatePostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePostRequest build() => _build();

  _$UpdatePostRequest _build() {
    _$UpdatePostRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdatePostRequest._(
            title: title,
            content: content,
            tags: _tags?.build(),
            postType: postType,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdatePostRequest',
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
