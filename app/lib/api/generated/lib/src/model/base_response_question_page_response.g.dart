// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_question_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseQuestionPageResponse
    extends BaseResponseQuestionPageResponse {
  @override
  final int? code;
  @override
  final QuestionPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseQuestionPageResponse([
    void Function(BaseResponseQuestionPageResponseBuilder)? updates,
  ]) => (BaseResponseQuestionPageResponseBuilder()..update(updates))._build();

  _$BaseResponseQuestionPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseQuestionPageResponse rebuild(
    void Function(BaseResponseQuestionPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseQuestionPageResponseBuilder toBuilder() =>
      BaseResponseQuestionPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseQuestionPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseQuestionPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseQuestionPageResponseBuilder
    implements
        Builder<
          BaseResponseQuestionPageResponse,
          BaseResponseQuestionPageResponseBuilder
        > {
  _$BaseResponseQuestionPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  QuestionPageResponseBuilder? _data;
  QuestionPageResponseBuilder get data =>
      _$this._data ??= QuestionPageResponseBuilder();
  set data(QuestionPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseQuestionPageResponseBuilder() {
    BaseResponseQuestionPageResponse._defaults(this);
  }

  BaseResponseQuestionPageResponseBuilder get _$this {
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
  void replace(BaseResponseQuestionPageResponse other) {
    _$v = other as _$BaseResponseQuestionPageResponse;
  }

  @override
  void update(void Function(BaseResponseQuestionPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseQuestionPageResponse build() => _build();

  _$BaseResponseQuestionPageResponse _build() {
    _$BaseResponseQuestionPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseQuestionPageResponse._(
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
          r'BaseResponseQuestionPageResponse',
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
