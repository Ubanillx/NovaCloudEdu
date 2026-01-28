// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateCourseRequest extends UpdateCourseRequest {
  @override
  final String title;
  @override
  final int courseType;
  @override
  final int difficulty;
  @override
  final String? subtitle;
  @override
  final String? description;
  @override
  final String? coverImage;
  @override
  final num? price;
  @override
  final BuiltList<String>? tags;

  factory _$UpdateCourseRequest([
    void Function(UpdateCourseRequestBuilder)? updates,
  ]) => (UpdateCourseRequestBuilder()..update(updates))._build();

  _$UpdateCourseRequest._({
    required this.title,
    required this.courseType,
    required this.difficulty,
    this.subtitle,
    this.description,
    this.coverImage,
    this.price,
    this.tags,
  }) : super._();
  @override
  UpdateCourseRequest rebuild(
    void Function(UpdateCourseRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateCourseRequestBuilder toBuilder() =>
      UpdateCourseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateCourseRequest &&
        title == other.title &&
        courseType == other.courseType &&
        difficulty == other.difficulty &&
        subtitle == other.subtitle &&
        description == other.description &&
        coverImage == other.coverImage &&
        price == other.price &&
        tags == other.tags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, courseType.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, subtitle.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, coverImage.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateCourseRequest')
          ..add('title', title)
          ..add('courseType', courseType)
          ..add('difficulty', difficulty)
          ..add('subtitle', subtitle)
          ..add('description', description)
          ..add('coverImage', coverImage)
          ..add('price', price)
          ..add('tags', tags))
        .toString();
  }
}

class UpdateCourseRequestBuilder
    implements Builder<UpdateCourseRequest, UpdateCourseRequestBuilder> {
  _$UpdateCourseRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _courseType;
  int? get courseType => _$this._courseType;
  set courseType(int? courseType) => _$this._courseType = courseType;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  String? _subtitle;
  String? get subtitle => _$this._subtitle;
  set subtitle(String? subtitle) => _$this._subtitle = subtitle;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _coverImage;
  String? get coverImage => _$this._coverImage;
  set coverImage(String? coverImage) => _$this._coverImage = coverImage;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  UpdateCourseRequestBuilder() {
    UpdateCourseRequest._defaults(this);
  }

  UpdateCourseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _courseType = $v.courseType;
      _difficulty = $v.difficulty;
      _subtitle = $v.subtitle;
      _description = $v.description;
      _coverImage = $v.coverImage;
      _price = $v.price;
      _tags = $v.tags?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateCourseRequest other) {
    _$v = other as _$UpdateCourseRequest;
  }

  @override
  void update(void Function(UpdateCourseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateCourseRequest build() => _build();

  _$UpdateCourseRequest _build() {
    _$UpdateCourseRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateCourseRequest._(
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'UpdateCourseRequest',
              'title',
            ),
            courseType: BuiltValueNullFieldError.checkNotNull(
              courseType,
              r'UpdateCourseRequest',
              'courseType',
            ),
            difficulty: BuiltValueNullFieldError.checkNotNull(
              difficulty,
              r'UpdateCourseRequest',
              'difficulty',
            ),
            subtitle: subtitle,
            description: description,
            coverImage: coverImage,
            price: price,
            tags: _tags?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateCourseRequest',
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
