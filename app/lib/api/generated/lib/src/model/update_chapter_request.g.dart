// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_chapter_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateChapterRequest extends UpdateChapterRequest {
  @override
  final String title;
  @override
  final int sort;
  @override
  final String? description;

  factory _$UpdateChapterRequest([
    void Function(UpdateChapterRequestBuilder)? updates,
  ]) => (UpdateChapterRequestBuilder()..update(updates))._build();

  _$UpdateChapterRequest._({
    required this.title,
    required this.sort,
    this.description,
  }) : super._();
  @override
  UpdateChapterRequest rebuild(
    void Function(UpdateChapterRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateChapterRequestBuilder toBuilder() =>
      UpdateChapterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateChapterRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateChapterRequest')
          ..add('title', title)
          ..add('sort', sort)
          ..add('description', description))
        .toString();
  }
}

class UpdateChapterRequestBuilder
    implements Builder<UpdateChapterRequest, UpdateChapterRequestBuilder> {
  _$UpdateChapterRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UpdateChapterRequestBuilder() {
    UpdateChapterRequest._defaults(this);
  }

  UpdateChapterRequestBuilder get _$this {
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
  void replace(UpdateChapterRequest other) {
    _$v = other as _$UpdateChapterRequest;
  }

  @override
  void update(void Function(UpdateChapterRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateChapterRequest build() => _build();

  _$UpdateChapterRequest _build() {
    final _$result =
        _$v ??
        _$UpdateChapterRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'UpdateChapterRequest',
            'title',
          ),
          sort: BuiltValueNullFieldError.checkNotNull(
            sort,
            r'UpdateChapterRequest',
            'sort',
          ),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
