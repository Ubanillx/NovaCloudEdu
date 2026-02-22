// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_ppt_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GeneratePptRequest extends GeneratePptRequest {
  @override
  final int? templateId;
  @override
  final String? title;
  @override
  final String? author;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? slides;

  factory _$GeneratePptRequest([
    void Function(GeneratePptRequestBuilder)? updates,
  ]) => (GeneratePptRequestBuilder()..update(updates))._build();

  _$GeneratePptRequest._({
    this.templateId,
    this.title,
    this.author,
    this.slides,
  }) : super._();
  @override
  GeneratePptRequest rebuild(
    void Function(GeneratePptRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GeneratePptRequestBuilder toBuilder() =>
      GeneratePptRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeneratePptRequest &&
        templateId == other.templateId &&
        title == other.title &&
        author == other.author &&
        slides == other.slides;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, templateId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, slides.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeneratePptRequest')
          ..add('templateId', templateId)
          ..add('title', title)
          ..add('author', author)
          ..add('slides', slides))
        .toString();
  }
}

class GeneratePptRequestBuilder
    implements Builder<GeneratePptRequest, GeneratePptRequestBuilder> {
  _$GeneratePptRequest? _$v;

  int? _templateId;
  int? get templateId => _$this._templateId;
  set templateId(int? templateId) => _$this._templateId = templateId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  ListBuilder<BuiltMap<String, JsonObject>>? _slides;
  ListBuilder<BuiltMap<String, JsonObject>> get slides =>
      _$this._slides ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set slides(ListBuilder<BuiltMap<String, JsonObject>>? slides) =>
      _$this._slides = slides;

  GeneratePptRequestBuilder() {
    GeneratePptRequest._defaults(this);
  }

  GeneratePptRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _templateId = $v.templateId;
      _title = $v.title;
      _author = $v.author;
      _slides = $v.slides?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeneratePptRequest other) {
    _$v = other as _$GeneratePptRequest;
  }

  @override
  void update(void Function(GeneratePptRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeneratePptRequest build() => _build();

  _$GeneratePptRequest _build() {
    _$GeneratePptRequest _$result;
    try {
      _$result =
          _$v ??
          _$GeneratePptRequest._(
            templateId: templateId,
            title: title,
            author: author,
            slides: _slides?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'slides';
        _slides?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GeneratePptRequest',
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
