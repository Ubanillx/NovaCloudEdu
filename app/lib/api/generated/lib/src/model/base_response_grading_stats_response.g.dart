// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_grading_stats_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGradingStatsResponse
    extends BaseResponseGradingStatsResponse {
  @override
  final int? code;
  @override
  final GradingStatsResponse? data;
  @override
  final String? message;

  factory _$BaseResponseGradingStatsResponse([
    void Function(BaseResponseGradingStatsResponseBuilder)? updates,
  ]) => (BaseResponseGradingStatsResponseBuilder()..update(updates))._build();

  _$BaseResponseGradingStatsResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseGradingStatsResponse rebuild(
    void Function(BaseResponseGradingStatsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGradingStatsResponseBuilder toBuilder() =>
      BaseResponseGradingStatsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGradingStatsResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseGradingStatsResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGradingStatsResponseBuilder
    implements
        Builder<
          BaseResponseGradingStatsResponse,
          BaseResponseGradingStatsResponseBuilder
        > {
  _$BaseResponseGradingStatsResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GradingStatsResponseBuilder? _data;
  GradingStatsResponseBuilder get data =>
      _$this._data ??= GradingStatsResponseBuilder();
  set data(GradingStatsResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGradingStatsResponseBuilder() {
    BaseResponseGradingStatsResponse._defaults(this);
  }

  BaseResponseGradingStatsResponseBuilder get _$this {
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
  void replace(BaseResponseGradingStatsResponse other) {
    _$v = other as _$BaseResponseGradingStatsResponse;
  }

  @override
  void update(void Function(BaseResponseGradingStatsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGradingStatsResponse build() => _build();

  _$BaseResponseGradingStatsResponse _build() {
    _$BaseResponseGradingStatsResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGradingStatsResponse._(
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
          r'BaseResponseGradingStatsResponse',
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
