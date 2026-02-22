// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_exam_template_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseExamTemplateResponse
    extends BaseResponseExamTemplateResponse {
  @override
  final int? code;
  @override
  final ExamTemplateResponse? data;
  @override
  final String? message;

  factory _$BaseResponseExamTemplateResponse([
    void Function(BaseResponseExamTemplateResponseBuilder)? updates,
  ]) => (BaseResponseExamTemplateResponseBuilder()..update(updates))._build();

  _$BaseResponseExamTemplateResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseExamTemplateResponse rebuild(
    void Function(BaseResponseExamTemplateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseExamTemplateResponseBuilder toBuilder() =>
      BaseResponseExamTemplateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseExamTemplateResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseExamTemplateResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseExamTemplateResponseBuilder
    implements
        Builder<
          BaseResponseExamTemplateResponse,
          BaseResponseExamTemplateResponseBuilder
        > {
  _$BaseResponseExamTemplateResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ExamTemplateResponseBuilder? _data;
  ExamTemplateResponseBuilder get data =>
      _$this._data ??= ExamTemplateResponseBuilder();
  set data(ExamTemplateResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseExamTemplateResponseBuilder() {
    BaseResponseExamTemplateResponse._defaults(this);
  }

  BaseResponseExamTemplateResponseBuilder get _$this {
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
  void replace(BaseResponseExamTemplateResponse other) {
    _$v = other as _$BaseResponseExamTemplateResponse;
  }

  @override
  void update(void Function(BaseResponseExamTemplateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseExamTemplateResponse build() => _build();

  _$BaseResponseExamTemplateResponse _build() {
    _$BaseResponseExamTemplateResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseExamTemplateResponse._(
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
          r'BaseResponseExamTemplateResponse',
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
