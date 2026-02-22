// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dashboard_learning_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDashboardLearningResponse
    extends BaseResponseDashboardLearningResponse {
  @override
  final int? code;
  @override
  final DashboardLearningResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDashboardLearningResponse([
    void Function(BaseResponseDashboardLearningResponseBuilder)? updates,
  ]) => (BaseResponseDashboardLearningResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseDashboardLearningResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseDashboardLearningResponse rebuild(
    void Function(BaseResponseDashboardLearningResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDashboardLearningResponseBuilder toBuilder() =>
      BaseResponseDashboardLearningResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDashboardLearningResponse &&
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
            r'BaseResponseDashboardLearningResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDashboardLearningResponseBuilder
    implements
        Builder<
          BaseResponseDashboardLearningResponse,
          BaseResponseDashboardLearningResponseBuilder
        > {
  _$BaseResponseDashboardLearningResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DashboardLearningResponseBuilder? _data;
  DashboardLearningResponseBuilder get data =>
      _$this._data ??= DashboardLearningResponseBuilder();
  set data(DashboardLearningResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDashboardLearningResponseBuilder() {
    BaseResponseDashboardLearningResponse._defaults(this);
  }

  BaseResponseDashboardLearningResponseBuilder get _$this {
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
  void replace(BaseResponseDashboardLearningResponse other) {
    _$v = other as _$BaseResponseDashboardLearningResponse;
  }

  @override
  void update(
    void Function(BaseResponseDashboardLearningResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDashboardLearningResponse build() => _build();

  _$BaseResponseDashboardLearningResponse _build() {
    _$BaseResponseDashboardLearningResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDashboardLearningResponse._(
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
          r'BaseResponseDashboardLearningResponse',
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
