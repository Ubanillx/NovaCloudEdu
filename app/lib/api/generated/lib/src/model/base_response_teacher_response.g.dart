// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_teacher_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseTeacherResponse extends BaseResponseTeacherResponse {
  @override
  final int? code;
  @override
  final TeacherResponse? data;
  @override
  final String? message;

  factory _$BaseResponseTeacherResponse([
    void Function(BaseResponseTeacherResponseBuilder)? updates,
  ]) => (BaseResponseTeacherResponseBuilder()..update(updates))._build();

  _$BaseResponseTeacherResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseTeacherResponse rebuild(
    void Function(BaseResponseTeacherResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseTeacherResponseBuilder toBuilder() =>
      BaseResponseTeacherResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseTeacherResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseTeacherResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseTeacherResponseBuilder
    implements
        Builder<
          BaseResponseTeacherResponse,
          BaseResponseTeacherResponseBuilder
        > {
  _$BaseResponseTeacherResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  TeacherResponseBuilder? _data;
  TeacherResponseBuilder get data => _$this._data ??= TeacherResponseBuilder();
  set data(TeacherResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseTeacherResponseBuilder() {
    BaseResponseTeacherResponse._defaults(this);
  }

  BaseResponseTeacherResponseBuilder get _$this {
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
  void replace(BaseResponseTeacherResponse other) {
    _$v = other as _$BaseResponseTeacherResponse;
  }

  @override
  void update(void Function(BaseResponseTeacherResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseTeacherResponse build() => _build();

  _$BaseResponseTeacherResponse _build() {
    _$BaseResponseTeacherResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseTeacherResponse._(
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
          r'BaseResponseTeacherResponse',
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
