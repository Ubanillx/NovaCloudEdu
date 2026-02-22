// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_learning_trend_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseLearningTrendResponse
    extends BaseResponseLearningTrendResponse {
  @override
  final int? code;
  @override
  final LearningTrendResponse? data;
  @override
  final String? message;

  factory _$BaseResponseLearningTrendResponse([
    void Function(BaseResponseLearningTrendResponseBuilder)? updates,
  ]) => (BaseResponseLearningTrendResponseBuilder()..update(updates))._build();

  _$BaseResponseLearningTrendResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseLearningTrendResponse rebuild(
    void Function(BaseResponseLearningTrendResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseLearningTrendResponseBuilder toBuilder() =>
      BaseResponseLearningTrendResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseLearningTrendResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseLearningTrendResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseLearningTrendResponseBuilder
    implements
        Builder<
          BaseResponseLearningTrendResponse,
          BaseResponseLearningTrendResponseBuilder
        > {
  _$BaseResponseLearningTrendResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  LearningTrendResponseBuilder? _data;
  LearningTrendResponseBuilder get data =>
      _$this._data ??= LearningTrendResponseBuilder();
  set data(LearningTrendResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseLearningTrendResponseBuilder() {
    BaseResponseLearningTrendResponse._defaults(this);
  }

  BaseResponseLearningTrendResponseBuilder get _$this {
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
  void replace(BaseResponseLearningTrendResponse other) {
    _$v = other as _$BaseResponseLearningTrendResponse;
  }

  @override
  void update(
    void Function(BaseResponseLearningTrendResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseLearningTrendResponse build() => _build();

  _$BaseResponseLearningTrendResponse _build() {
    _$BaseResponseLearningTrendResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseLearningTrendResponse._(
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
          r'BaseResponseLearningTrendResponse',
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
