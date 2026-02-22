// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_exam_template_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListExamTemplateResponse
    extends BaseResponseListExamTemplateResponse {
  @override
  final int? code;
  @override
  final BuiltList<ExamTemplateResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListExamTemplateResponse([
    void Function(BaseResponseListExamTemplateResponseBuilder)? updates,
  ]) =>
      (BaseResponseListExamTemplateResponseBuilder()..update(updates))._build();

  _$BaseResponseListExamTemplateResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListExamTemplateResponse rebuild(
    void Function(BaseResponseListExamTemplateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListExamTemplateResponseBuilder toBuilder() =>
      BaseResponseListExamTemplateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListExamTemplateResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListExamTemplateResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListExamTemplateResponseBuilder
    implements
        Builder<
          BaseResponseListExamTemplateResponse,
          BaseResponseListExamTemplateResponseBuilder
        > {
  _$BaseResponseListExamTemplateResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ExamTemplateResponse>? _data;
  ListBuilder<ExamTemplateResponse> get data =>
      _$this._data ??= ListBuilder<ExamTemplateResponse>();
  set data(ListBuilder<ExamTemplateResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListExamTemplateResponseBuilder() {
    BaseResponseListExamTemplateResponse._defaults(this);
  }

  BaseResponseListExamTemplateResponseBuilder get _$this {
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
  void replace(BaseResponseListExamTemplateResponse other) {
    _$v = other as _$BaseResponseListExamTemplateResponse;
  }

  @override
  void update(
    void Function(BaseResponseListExamTemplateResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListExamTemplateResponse build() => _build();

  _$BaseResponseListExamTemplateResponse _build() {
    _$BaseResponseListExamTemplateResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListExamTemplateResponse._(
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
          r'BaseResponseListExamTemplateResponse',
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
