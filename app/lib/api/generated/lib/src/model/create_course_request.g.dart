// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_course_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateCourseRequest extends CreateCourseRequest {
  @override
  final String title;
  @override
  final int courseType;
  @override
  final int difficulty;
  @override
  final int teacherId;
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

  factory _$CreateCourseRequest([
    void Function(CreateCourseRequestBuilder)? updates,
  ]) => (CreateCourseRequestBuilder()..update(updates))._build();

  _$CreateCourseRequest._({
    required this.title,
    required this.courseType,
    required this.difficulty,
    required this.teacherId,
    this.subtitle,
    this.description,
    this.coverImage,
    this.price,
    this.tags,
  }) : super._();
  @override
  CreateCourseRequest rebuild(
    void Function(CreateCourseRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateCourseRequestBuilder toBuilder() =>
      CreateCourseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCourseRequest &&
        title == other.title &&
        courseType == other.courseType &&
        difficulty == other.difficulty &&
        teacherId == other.teacherId &&
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
    _$hash = $jc(_$hash, teacherId.hashCode);
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
    return (newBuiltValueToStringHelper(r'CreateCourseRequest')
          ..add('title', title)
          ..add('courseType', courseType)
          ..add('difficulty', difficulty)
          ..add('teacherId', teacherId)
          ..add('subtitle', subtitle)
          ..add('description', description)
          ..add('coverImage', coverImage)
          ..add('price', price)
          ..add('tags', tags))
        .toString();
  }
}

class CreateCourseRequestBuilder
    implements Builder<CreateCourseRequest, CreateCourseRequestBuilder> {
  _$CreateCourseRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _courseType;
  int? get courseType => _$this._courseType;
  set courseType(int? courseType) => _$this._courseType = courseType;

  int? _difficulty;
  int? get difficulty => _$this._difficulty;
  set difficulty(int? difficulty) => _$this._difficulty = difficulty;

  int? _teacherId;
  int? get teacherId => _$this._teacherId;
  set teacherId(int? teacherId) => _$this._teacherId = teacherId;

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

  CreateCourseRequestBuilder() {
    CreateCourseRequest._defaults(this);
  }

  CreateCourseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _courseType = $v.courseType;
      _difficulty = $v.difficulty;
      _teacherId = $v.teacherId;
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
  void replace(CreateCourseRequest other) {
    _$v = other as _$CreateCourseRequest;
  }

  @override
  void update(void Function(CreateCourseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCourseRequest build() => _build();

  _$CreateCourseRequest _build() {
    _$CreateCourseRequest _$result;
    try {
      _$result =
          _$v ??
          _$CreateCourseRequest._(
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'CreateCourseRequest',
              'title',
            ),
            courseType: BuiltValueNullFieldError.checkNotNull(
              courseType,
              r'CreateCourseRequest',
              'courseType',
            ),
            difficulty: BuiltValueNullFieldError.checkNotNull(
              difficulty,
              r'CreateCourseRequest',
              'difficulty',
            ),
            teacherId: BuiltValueNullFieldError.checkNotNull(
              teacherId,
              r'CreateCourseRequest',
              'teacherId',
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
          r'CreateCourseRequest',
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
