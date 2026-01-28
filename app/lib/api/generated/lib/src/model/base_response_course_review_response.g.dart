// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_course_review_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseCourseReviewResponse
    extends BaseResponseCourseReviewResponse {
  @override
  final int? code;
  @override
  final CourseReviewResponse? data;
  @override
  final String? message;

  factory _$BaseResponseCourseReviewResponse([
    void Function(BaseResponseCourseReviewResponseBuilder)? updates,
  ]) => (BaseResponseCourseReviewResponseBuilder()..update(updates))._build();

  _$BaseResponseCourseReviewResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseCourseReviewResponse rebuild(
    void Function(BaseResponseCourseReviewResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseCourseReviewResponseBuilder toBuilder() =>
      BaseResponseCourseReviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseCourseReviewResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseCourseReviewResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseCourseReviewResponseBuilder
    implements
        Builder<
          BaseResponseCourseReviewResponse,
          BaseResponseCourseReviewResponseBuilder
        > {
  _$BaseResponseCourseReviewResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  CourseReviewResponseBuilder? _data;
  CourseReviewResponseBuilder get data =>
      _$this._data ??= CourseReviewResponseBuilder();
  set data(CourseReviewResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseCourseReviewResponseBuilder() {
    BaseResponseCourseReviewResponse._defaults(this);
  }

  BaseResponseCourseReviewResponseBuilder get _$this {
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
  void replace(BaseResponseCourseReviewResponse other) {
    _$v = other as _$BaseResponseCourseReviewResponse;
  }

  @override
  void update(void Function(BaseResponseCourseReviewResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseCourseReviewResponse build() => _build();

  _$BaseResponseCourseReviewResponse _build() {
    _$BaseResponseCourseReviewResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseCourseReviewResponse._(
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
          r'BaseResponseCourseReviewResponse',
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
