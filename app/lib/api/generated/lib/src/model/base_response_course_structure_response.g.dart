// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_course_structure_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseCourseStructureResponse
    extends BaseResponseCourseStructureResponse {
  @override
  final int? code;
  @override
  final CourseStructureResponse? data;
  @override
  final String? message;

  factory _$BaseResponseCourseStructureResponse([
    void Function(BaseResponseCourseStructureResponseBuilder)? updates,
  ]) =>
      (BaseResponseCourseStructureResponseBuilder()..update(updates))._build();

  _$BaseResponseCourseStructureResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseCourseStructureResponse rebuild(
    void Function(BaseResponseCourseStructureResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseCourseStructureResponseBuilder toBuilder() =>
      BaseResponseCourseStructureResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseCourseStructureResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseCourseStructureResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseCourseStructureResponseBuilder
    implements
        Builder<
          BaseResponseCourseStructureResponse,
          BaseResponseCourseStructureResponseBuilder
        > {
  _$BaseResponseCourseStructureResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  CourseStructureResponseBuilder? _data;
  CourseStructureResponseBuilder get data =>
      _$this._data ??= CourseStructureResponseBuilder();
  set data(CourseStructureResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseCourseStructureResponseBuilder() {
    BaseResponseCourseStructureResponse._defaults(this);
  }

  BaseResponseCourseStructureResponseBuilder get _$this {
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
  void replace(BaseResponseCourseStructureResponse other) {
    _$v = other as _$BaseResponseCourseStructureResponse;
  }

  @override
  void update(
    void Function(BaseResponseCourseStructureResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseCourseStructureResponse build() => _build();

  _$BaseResponseCourseStructureResponse _build() {
    _$BaseResponseCourseStructureResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseCourseStructureResponse._(
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
          r'BaseResponseCourseStructureResponse',
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
