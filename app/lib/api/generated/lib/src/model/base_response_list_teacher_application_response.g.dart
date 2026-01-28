// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_teacher_application_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListTeacherApplicationResponse
    extends BaseResponseListTeacherApplicationResponse {
  @override
  final int? code;
  @override
  final BuiltList<TeacherApplicationResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListTeacherApplicationResponse([
    void Function(BaseResponseListTeacherApplicationResponseBuilder)? updates,
  ]) => (BaseResponseListTeacherApplicationResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListTeacherApplicationResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListTeacherApplicationResponse rebuild(
    void Function(BaseResponseListTeacherApplicationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListTeacherApplicationResponseBuilder toBuilder() =>
      BaseResponseListTeacherApplicationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListTeacherApplicationResponse &&
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
            r'BaseResponseListTeacherApplicationResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListTeacherApplicationResponseBuilder
    implements
        Builder<
          BaseResponseListTeacherApplicationResponse,
          BaseResponseListTeacherApplicationResponseBuilder
        > {
  _$BaseResponseListTeacherApplicationResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<TeacherApplicationResponse>? _data;
  ListBuilder<TeacherApplicationResponse> get data =>
      _$this._data ??= ListBuilder<TeacherApplicationResponse>();
  set data(ListBuilder<TeacherApplicationResponse>? data) =>
      _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListTeacherApplicationResponseBuilder() {
    BaseResponseListTeacherApplicationResponse._defaults(this);
  }

  BaseResponseListTeacherApplicationResponseBuilder get _$this {
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
  void replace(BaseResponseListTeacherApplicationResponse other) {
    _$v = other as _$BaseResponseListTeacherApplicationResponse;
  }

  @override
  void update(
    void Function(BaseResponseListTeacherApplicationResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListTeacherApplicationResponse build() => _build();

  _$BaseResponseListTeacherApplicationResponse _build() {
    _$BaseResponseListTeacherApplicationResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListTeacherApplicationResponse._(
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
          r'BaseResponseListTeacherApplicationResponse',
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
