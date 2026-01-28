// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_course_review_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListCourseReviewResponse
    extends BaseResponseListCourseReviewResponse {
  @override
  final int? code;
  @override
  final BuiltList<CourseReviewResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListCourseReviewResponse([
    void Function(BaseResponseListCourseReviewResponseBuilder)? updates,
  ]) =>
      (BaseResponseListCourseReviewResponseBuilder()..update(updates))._build();

  _$BaseResponseListCourseReviewResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListCourseReviewResponse rebuild(
    void Function(BaseResponseListCourseReviewResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListCourseReviewResponseBuilder toBuilder() =>
      BaseResponseListCourseReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListCourseReviewResponse &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BaseResponseListCourseReviewResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListCourseReviewResponseBuilder
    implements
        Builder<
          BaseResponseListCourseReviewResponse,
          BaseResponseListCourseReviewResponseBuilder
        > {
  _$BaseResponseListCourseReviewResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<CourseReviewResponse>? _data;
  ListBuilder<CourseReviewResponse> get data =>
      _$this._data ??= ListBuilder<CourseReviewResponse>();
  set data(ListBuilder<CourseReviewResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListCourseReviewResponseBuilder() {
    BaseResponseListCourseReviewResponse._defaults(this);
  }

  BaseResponseListCourseReviewResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseListCourseReviewResponse other) {
    _$v = other as _$BaseResponseListCourseReviewResponse;
  }

  @override
  void update(
    void Function(BaseResponseListCourseReviewResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListCourseReviewResponse build() => _build();

  _$BaseResponseListCourseReviewResponse _build() {
    _$BaseResponseListCourseReviewResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListCourseReviewResponse._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BaseResponseListCourseReviewResponse',
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
