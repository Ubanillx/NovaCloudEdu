// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_teacher_application_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseTeacherApplicationResponse
    extends BaseResponseTeacherApplicationResponse {
  @override
  final int? code;
  @override
  final TeacherApplicationResponse? data;
  @override
  final String? message;

  factory _$BaseResponseTeacherApplicationResponse([
    void Function(BaseResponseTeacherApplicationResponseBuilder)? updates,
  ]) => (BaseResponseTeacherApplicationResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseTeacherApplicationResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseTeacherApplicationResponse rebuild(
    void Function(BaseResponseTeacherApplicationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseTeacherApplicationResponseBuilder toBuilder() =>
      BaseResponseTeacherApplicationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseTeacherApplicationResponse &&
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
            r'BaseResponseTeacherApplicationResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseTeacherApplicationResponseBuilder
    implements
        Builder<
          BaseResponseTeacherApplicationResponse,
          BaseResponseTeacherApplicationResponseBuilder
        > {
  _$BaseResponseTeacherApplicationResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  TeacherApplicationResponseBuilder? _data;
  TeacherApplicationResponseBuilder get data =>
      _$this._data ??= TeacherApplicationResponseBuilder();
  set data(TeacherApplicationResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseTeacherApplicationResponseBuilder() {
    BaseResponseTeacherApplicationResponse._defaults(this);
  }

  BaseResponseTeacherApplicationResponseBuilder get _$this {
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
  void replace(BaseResponseTeacherApplicationResponse other) {
    _$v = other as _$BaseResponseTeacherApplicationResponse;
  }

  @override
  void update(
    void Function(BaseResponseTeacherApplicationResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseTeacherApplicationResponse build() => _build();

  _$BaseResponseTeacherApplicationResponse _build() {
    _$BaseResponseTeacherApplicationResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseTeacherApplicationResponse._(
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
          r'BaseResponseTeacherApplicationResponse',
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
