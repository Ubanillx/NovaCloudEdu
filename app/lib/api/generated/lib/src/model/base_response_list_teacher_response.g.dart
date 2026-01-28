// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_teacher_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListTeacherResponse
    extends BaseResponseListTeacherResponse {
  @override
  final int? code;
  @override
  final BuiltList<TeacherResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListTeacherResponse([
    void Function(BaseResponseListTeacherResponseBuilder)? updates,
  ]) => (BaseResponseListTeacherResponseBuilder()..update(updates))._build();

  _$BaseResponseListTeacherResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListTeacherResponse rebuild(
    void Function(BaseResponseListTeacherResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListTeacherResponseBuilder toBuilder() =>
      BaseResponseListTeacherResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListTeacherResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListTeacherResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListTeacherResponseBuilder
    implements
        Builder<
          BaseResponseListTeacherResponse,
          BaseResponseListTeacherResponseBuilder
        > {
  _$BaseResponseListTeacherResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<TeacherResponse>? _data;
  ListBuilder<TeacherResponse> get data =>
      _$this._data ??= ListBuilder<TeacherResponse>();
  set data(ListBuilder<TeacherResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListTeacherResponseBuilder() {
    BaseResponseListTeacherResponse._defaults(this);
  }

  BaseResponseListTeacherResponseBuilder get _$this {
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
  void replace(BaseResponseListTeacherResponse other) {
    _$v = other as _$BaseResponseListTeacherResponse;
  }

  @override
  void update(void Function(BaseResponseListTeacherResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListTeacherResponse build() => _build();

  _$BaseResponseListTeacherResponse _build() {
    _$BaseResponseListTeacherResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListTeacherResponse._(
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
          r'BaseResponseListTeacherResponse',
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
