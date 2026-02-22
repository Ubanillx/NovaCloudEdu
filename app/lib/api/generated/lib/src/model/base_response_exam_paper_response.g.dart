// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_exam_paper_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseExamPaperResponse extends BaseResponseExamPaperResponse {
  @override
  final int? code;
  @override
  final ExamPaperResponse? data;
  @override
  final String? message;

  factory _$BaseResponseExamPaperResponse([
    void Function(BaseResponseExamPaperResponseBuilder)? updates,
  ]) => (BaseResponseExamPaperResponseBuilder()..update(updates))._build();

  _$BaseResponseExamPaperResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseExamPaperResponse rebuild(
    void Function(BaseResponseExamPaperResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseExamPaperResponseBuilder toBuilder() =>
      BaseResponseExamPaperResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseExamPaperResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseExamPaperResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseExamPaperResponseBuilder
    implements
        Builder<
          BaseResponseExamPaperResponse,
          BaseResponseExamPaperResponseBuilder
        > {
  _$BaseResponseExamPaperResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ExamPaperResponseBuilder? _data;
  ExamPaperResponseBuilder get data =>
      _$this._data ??= ExamPaperResponseBuilder();
  set data(ExamPaperResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseExamPaperResponseBuilder() {
    BaseResponseExamPaperResponse._defaults(this);
  }

  BaseResponseExamPaperResponseBuilder get _$this {
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
  void replace(BaseResponseExamPaperResponse other) {
    _$v = other as _$BaseResponseExamPaperResponse;
  }

  @override
  void update(void Function(BaseResponseExamPaperResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseExamPaperResponse build() => _build();

  _$BaseResponseExamPaperResponse _build() {
    _$BaseResponseExamPaperResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseExamPaperResponse._(
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
          r'BaseResponseExamPaperResponse',
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
