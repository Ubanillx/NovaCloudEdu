// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_course_progress_summary_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseCourseProgressSummaryResponse
    extends BaseResponseCourseProgressSummaryResponse {
  @override
  final int? code;
  @override
  final CourseProgressSummaryResponse? data;
  @override
  final String? message;

  factory _$BaseResponseCourseProgressSummaryResponse([
    void Function(BaseResponseCourseProgressSummaryResponseBuilder)? updates,
  ]) => (BaseResponseCourseProgressSummaryResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseCourseProgressSummaryResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseCourseProgressSummaryResponse rebuild(
    void Function(BaseResponseCourseProgressSummaryResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseCourseProgressSummaryResponseBuilder toBuilder() =>
      BaseResponseCourseProgressSummaryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseCourseProgressSummaryResponse &&
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
    return (newBuiltValueToStringHelper(
            r'BaseResponseCourseProgressSummaryResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseCourseProgressSummaryResponseBuilder
    implements
        Builder<
          BaseResponseCourseProgressSummaryResponse,
          BaseResponseCourseProgressSummaryResponseBuilder
        > {
  _$BaseResponseCourseProgressSummaryResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  CourseProgressSummaryResponseBuilder? _data;
  CourseProgressSummaryResponseBuilder get data =>
      _$this._data ??= CourseProgressSummaryResponseBuilder();
  set data(CourseProgressSummaryResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseCourseProgressSummaryResponseBuilder() {
    BaseResponseCourseProgressSummaryResponse._defaults(this);
  }

  BaseResponseCourseProgressSummaryResponseBuilder get _$this {
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
  void replace(BaseResponseCourseProgressSummaryResponse other) {
    _$v = other as _$BaseResponseCourseProgressSummaryResponse;
  }

  @override
  void update(
    void Function(BaseResponseCourseProgressSummaryResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseCourseProgressSummaryResponse build() => _build();

  _$BaseResponseCourseProgressSummaryResponse _build() {
    _$BaseResponseCourseProgressSummaryResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseCourseProgressSummaryResponse._(
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
          r'BaseResponseCourseProgressSummaryResponse',
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
