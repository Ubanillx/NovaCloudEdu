// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_exam_paper_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseExamPaperPageResponse
    extends BaseResponseExamPaperPageResponse {
  @override
  final int? code;
  @override
  final ExamPaperPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseExamPaperPageResponse([
    void Function(BaseResponseExamPaperPageResponseBuilder)? updates,
  ]) => (BaseResponseExamPaperPageResponseBuilder()..update(updates))._build();

  _$BaseResponseExamPaperPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseExamPaperPageResponse rebuild(
    void Function(BaseResponseExamPaperPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseExamPaperPageResponseBuilder toBuilder() =>
      BaseResponseExamPaperPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseExamPaperPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseExamPaperPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseExamPaperPageResponseBuilder
    implements
        Builder<
          BaseResponseExamPaperPageResponse,
          BaseResponseExamPaperPageResponseBuilder
        > {
  _$BaseResponseExamPaperPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ExamPaperPageResponseBuilder? _data;
  ExamPaperPageResponseBuilder get data =>
      _$this._data ??= ExamPaperPageResponseBuilder();
  set data(ExamPaperPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseExamPaperPageResponseBuilder() {
    BaseResponseExamPaperPageResponse._defaults(this);
  }

  BaseResponseExamPaperPageResponseBuilder get _$this {
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
  void replace(BaseResponseExamPaperPageResponse other) {
    _$v = other as _$BaseResponseExamPaperPageResponse;
  }

  @override
  void update(
    void Function(BaseResponseExamPaperPageResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseExamPaperPageResponse build() => _build();

  _$BaseResponseExamPaperPageResponse _build() {
    _$BaseResponseExamPaperPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseExamPaperPageResponse._(
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
          r'BaseResponseExamPaperPageResponse',
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
