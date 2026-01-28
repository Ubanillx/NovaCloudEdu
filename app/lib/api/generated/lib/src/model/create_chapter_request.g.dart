// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chapter_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateChapterRequest extends CreateChapterRequest {
  @override
  final String title;
  @override
  final int sort;
  @override
  final String? description;

  factory _$CreateChapterRequest([
    void Function(CreateChapterRequestBuilder)? updates,
  ]) => (CreateChapterRequestBuilder()..update(updates))._build();

  _$CreateChapterRequest._({
    required this.title,
    required this.sort,
    this.description,
  }) : super._();
  @override
  CreateChapterRequest rebuild(
    void Function(CreateChapterRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateChapterRequestBuilder toBuilder() =>
      CreateChapterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateChapterRequest &&
        title == other.title &&
        sort == other.sort &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateChapterRequest')
          ..add('title', title)
          ..add('sort', sort)
          ..add('description', description))
        .toString();
  }
}

class CreateChapterRequestBuilder
    implements Builder<CreateChapterRequest, CreateChapterRequestBuilder> {
  _$CreateChapterRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CreateChapterRequestBuilder() {
    CreateChapterRequest._defaults(this);
  }

  CreateChapterRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _sort = $v.sort;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateChapterRequest other) {
    _$v = other as _$CreateChapterRequest;
  }

  @override
  void update(void Function(CreateChapterRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateChapterRequest build() => _build();

  _$CreateChapterRequest _build() {
    final _$result =
        _$v ??
        _$CreateChapterRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'CreateChapterRequest',
            'title',
          ),
          sort: BuiltValueNullFieldError.checkNotNull(
            sort,
            r'CreateChapterRequest',
            'sort',
          ),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
