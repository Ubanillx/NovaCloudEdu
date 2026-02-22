// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_paper_question_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListPaperQuestionResponse
    extends BaseResponseListPaperQuestionResponse {
  @override
  final int? code;
  @override
  final BuiltList<PaperQuestionResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListPaperQuestionResponse([
    void Function(BaseResponseListPaperQuestionResponseBuilder)? updates,
  ]) => (BaseResponseListPaperQuestionResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListPaperQuestionResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListPaperQuestionResponse rebuild(
    void Function(BaseResponseListPaperQuestionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListPaperQuestionResponseBuilder toBuilder() =>
      BaseResponseListPaperQuestionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListPaperQuestionResponse &&
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
            r'BaseResponseListPaperQuestionResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListPaperQuestionResponseBuilder
    implements
        Builder<
          BaseResponseListPaperQuestionResponse,
          BaseResponseListPaperQuestionResponseBuilder
        > {
  _$BaseResponseListPaperQuestionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<PaperQuestionResponse>? _data;
  ListBuilder<PaperQuestionResponse> get data =>
      _$this._data ??= ListBuilder<PaperQuestionResponse>();
  set data(ListBuilder<PaperQuestionResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListPaperQuestionResponseBuilder() {
    BaseResponseListPaperQuestionResponse._defaults(this);
  }

  BaseResponseListPaperQuestionResponseBuilder get _$this {
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
  void replace(BaseResponseListPaperQuestionResponse other) {
    _$v = other as _$BaseResponseListPaperQuestionResponse;
  }

  @override
  void update(
    void Function(BaseResponseListPaperQuestionResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListPaperQuestionResponse build() => _build();

  _$BaseResponseListPaperQuestionResponse _build() {
    _$BaseResponseListPaperQuestionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListPaperQuestionResponse._(
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
          r'BaseResponseListPaperQuestionResponse',
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
