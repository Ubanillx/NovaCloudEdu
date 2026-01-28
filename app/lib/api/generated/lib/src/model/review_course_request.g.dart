// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_course_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReviewCourseRequest extends ReviewCourseRequest {
  @override
  final int rating;

  factory _$ReviewCourseRequest([
    void Function(ReviewCourseRequestBuilder)? updates,
  ]) => (ReviewCourseRequestBuilder()..update(updates))._build();

  _$ReviewCourseRequest._({required this.rating}) : super._();
  @override
  ReviewCourseRequest rebuild(
    void Function(ReviewCourseRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReviewCourseRequestBuilder toBuilder() =>
      ReviewCourseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewCourseRequest && rating == other.rating;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ReviewCourseRequest',
    )..add('rating', rating)).toString();
  }
}

class ReviewCourseRequestBuilder
    implements Builder<ReviewCourseRequest, ReviewCourseRequestBuilder> {
  _$ReviewCourseRequest? _$v;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  ReviewCourseRequestBuilder() {
    ReviewCourseRequest._defaults(this);
  }

  ReviewCourseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rating = $v.rating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewCourseRequest other) {
    _$v = other as _$ReviewCourseRequest;
  }

  @override
  void update(void Function(ReviewCourseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewCourseRequest build() => _build();

  _$ReviewCourseRequest _build() {
    final _$result =
        _$v ??
        _$ReviewCourseRequest._(
          rating: BuiltValueNullFieldError.checkNotNull(
            rating,
            r'ReviewCourseRequest',
            'rating',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
