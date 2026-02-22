// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dashboard_trends_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDashboardTrendsResponse
    extends BaseResponseDashboardTrendsResponse {
  @override
  final int? code;
  @override
  final DashboardTrendsResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDashboardTrendsResponse([
    void Function(BaseResponseDashboardTrendsResponseBuilder)? updates,
  ]) =>
      (BaseResponseDashboardTrendsResponseBuilder()..update(updates))._build();

  _$BaseResponseDashboardTrendsResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDashboardTrendsResponse rebuild(
    void Function(BaseResponseDashboardTrendsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDashboardTrendsResponseBuilder toBuilder() =>
      BaseResponseDashboardTrendsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDashboardTrendsResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDashboardTrendsResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDashboardTrendsResponseBuilder
    implements
        Builder<
          BaseResponseDashboardTrendsResponse,
          BaseResponseDashboardTrendsResponseBuilder
        > {
  _$BaseResponseDashboardTrendsResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DashboardTrendsResponseBuilder? _data;
  DashboardTrendsResponseBuilder get data =>
      _$this._data ??= DashboardTrendsResponseBuilder();
  set data(DashboardTrendsResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDashboardTrendsResponseBuilder() {
    BaseResponseDashboardTrendsResponse._defaults(this);
  }

  BaseResponseDashboardTrendsResponseBuilder get _$this {
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
  void replace(BaseResponseDashboardTrendsResponse other) {
    _$v = other as _$BaseResponseDashboardTrendsResponse;
  }

  @override
  void update(
    void Function(BaseResponseDashboardTrendsResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDashboardTrendsResponse build() => _build();

  _$BaseResponseDashboardTrendsResponse _build() {
    _$BaseResponseDashboardTrendsResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDashboardTrendsResponse._(
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
          r'BaseResponseDashboardTrendsResponse',
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
