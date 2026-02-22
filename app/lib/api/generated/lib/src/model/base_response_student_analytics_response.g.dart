// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_student_analytics_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseStudentAnalyticsResponse
    extends BaseResponseStudentAnalyticsResponse {
  @override
  final int? code;
  @override
  final StudentAnalyticsResponse? data;
  @override
  final String? message;

  factory _$BaseResponseStudentAnalyticsResponse([
    void Function(BaseResponseStudentAnalyticsResponseBuilder)? updates,
  ]) =>
      (BaseResponseStudentAnalyticsResponseBuilder()..update(updates))._build();

  _$BaseResponseStudentAnalyticsResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseStudentAnalyticsResponse rebuild(
    void Function(BaseResponseStudentAnalyticsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseStudentAnalyticsResponseBuilder toBuilder() =>
      BaseResponseStudentAnalyticsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseStudentAnalyticsResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseStudentAnalyticsResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseStudentAnalyticsResponseBuilder
    implements
        Builder<
          BaseResponseStudentAnalyticsResponse,
          BaseResponseStudentAnalyticsResponseBuilder
        > {
  _$BaseResponseStudentAnalyticsResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  StudentAnalyticsResponseBuilder? _data;
  StudentAnalyticsResponseBuilder get data =>
      _$this._data ??= StudentAnalyticsResponseBuilder();
  set data(StudentAnalyticsResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseStudentAnalyticsResponseBuilder() {
    BaseResponseStudentAnalyticsResponse._defaults(this);
  }

  BaseResponseStudentAnalyticsResponseBuilder get _$this {
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
  void replace(BaseResponseStudentAnalyticsResponse other) {
    _$v = other as _$BaseResponseStudentAnalyticsResponse;
  }

  @override
  void update(
    void Function(BaseResponseStudentAnalyticsResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseStudentAnalyticsResponse build() => _build();

  _$BaseResponseStudentAnalyticsResponse _build() {
    _$BaseResponseStudentAnalyticsResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseStudentAnalyticsResponse._(
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
          r'BaseResponseStudentAnalyticsResponse',
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
