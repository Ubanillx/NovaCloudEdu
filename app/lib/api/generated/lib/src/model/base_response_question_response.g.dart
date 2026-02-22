// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_question_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseQuestionResponse extends BaseResponseQuestionResponse {
  @override
  final int? code;
  @override
  final QuestionResponse? data;
  @override
  final String? message;

  factory _$BaseResponseQuestionResponse([
    void Function(BaseResponseQuestionResponseBuilder)? updates,
  ]) => (BaseResponseQuestionResponseBuilder()..update(updates))._build();

  _$BaseResponseQuestionResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseQuestionResponse rebuild(
    void Function(BaseResponseQuestionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseQuestionResponseBuilder toBuilder() =>
      BaseResponseQuestionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseQuestionResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseQuestionResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseQuestionResponseBuilder
    implements
        Builder<
          BaseResponseQuestionResponse,
          BaseResponseQuestionResponseBuilder
        > {
  _$BaseResponseQuestionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  QuestionResponseBuilder? _data;
  QuestionResponseBuilder get data =>
      _$this._data ??= QuestionResponseBuilder();
  set data(QuestionResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseQuestionResponseBuilder() {
    BaseResponseQuestionResponse._defaults(this);
  }

  BaseResponseQuestionResponseBuilder get _$this {
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
  void replace(BaseResponseQuestionResponse other) {
    _$v = other as _$BaseResponseQuestionResponse;
  }

  @override
  void update(void Function(BaseResponseQuestionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseQuestionResponse build() => _build();

  _$BaseResponseQuestionResponse _build() {
    _$BaseResponseQuestionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseQuestionResponse._(
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
          r'BaseResponseQuestionResponse',
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
