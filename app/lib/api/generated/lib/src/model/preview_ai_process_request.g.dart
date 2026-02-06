// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_ai_process_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PreviewAiProcessRequest extends PreviewAiProcessRequest {
  @override
  final String content;
  @override
  final String? title;

  factory _$PreviewAiProcessRequest([
    void Function(PreviewAiProcessRequestBuilder)? updates,
  ]) => (PreviewAiProcessRequestBuilder()..update(updates))._build();

  _$PreviewAiProcessRequest._({required this.content, this.title}) : super._();
  @override
  PreviewAiProcessRequest rebuild(
    void Function(PreviewAiProcessRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PreviewAiProcessRequestBuilder toBuilder() =>
      PreviewAiProcessRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreviewAiProcessRequest &&
        content == other.content &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PreviewAiProcessRequest')
          ..add('content', content)
          ..add('title', title))
        .toString();
  }
}

class PreviewAiProcessRequestBuilder
    implements
        Builder<PreviewAiProcessRequest, PreviewAiProcessRequestBuilder> {
  _$PreviewAiProcessRequest? _$v;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  PreviewAiProcessRequestBuilder() {
    PreviewAiProcessRequest._defaults(this);
  }

  PreviewAiProcessRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _content = $v.content;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreviewAiProcessRequest other) {
    _$v = other as _$PreviewAiProcessRequest;
  }

  @override
  void update(void Function(PreviewAiProcessRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PreviewAiProcessRequest build() => _build();

  _$PreviewAiProcessRequest _build() {
    final _$result =
        _$v ??
        _$PreviewAiProcessRequest._(
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'PreviewAiProcessRequest',
            'content',
          ),
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
