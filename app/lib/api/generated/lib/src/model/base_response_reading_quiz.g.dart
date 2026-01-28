// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_reading_quiz.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseReadingQuiz extends BaseResponseReadingQuiz {
  @override
  final int? code;
  @override
  final ReadingQuiz? data;
  @override
  final String? message;

  factory _$BaseResponseReadingQuiz([
    void Function(BaseResponseReadingQuizBuilder)? updates,
  ]) => (BaseResponseReadingQuizBuilder()..update(updates))._build();

  _$BaseResponseReadingQuiz._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseReadingQuiz rebuild(
    void Function(BaseResponseReadingQuizBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseReadingQuizBuilder toBuilder() =>
      BaseResponseReadingQuizBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseReadingQuiz &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseReadingQuiz')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseReadingQuizBuilder
    implements
        Builder<BaseResponseReadingQuiz, BaseResponseReadingQuizBuilder> {
  _$BaseResponseReadingQuiz? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ReadingQuizBuilder? _data;
  ReadingQuizBuilder get data => _$this._data ??= ReadingQuizBuilder();
  set data(ReadingQuizBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseReadingQuizBuilder() {
    BaseResponseReadingQuiz._defaults(this);
  }

  BaseResponseReadingQuizBuilder get _$this {
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
  void replace(BaseResponseReadingQuiz other) {
    _$v = other as _$BaseResponseReadingQuiz;
  }

  @override
  void update(void Function(BaseResponseReadingQuizBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseReadingQuiz build() => _build();

  _$BaseResponseReadingQuiz _build() {
    _$BaseResponseReadingQuiz _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseReadingQuiz._(
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
          r'BaseResponseReadingQuiz',
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
