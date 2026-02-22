// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dashboard_overview_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDashboardOverviewResponse
    extends BaseResponseDashboardOverviewResponse {
  @override
  final int? code;
  @override
  final DashboardOverviewResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDashboardOverviewResponse([
    void Function(BaseResponseDashboardOverviewResponseBuilder)? updates,
  ]) => (BaseResponseDashboardOverviewResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseDashboardOverviewResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseDashboardOverviewResponse rebuild(
    void Function(BaseResponseDashboardOverviewResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDashboardOverviewResponseBuilder toBuilder() =>
      BaseResponseDashboardOverviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDashboardOverviewResponse &&
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
            r'BaseResponseDashboardOverviewResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDashboardOverviewResponseBuilder
    implements
        Builder<
          BaseResponseDashboardOverviewResponse,
          BaseResponseDashboardOverviewResponseBuilder
        > {
  _$BaseResponseDashboardOverviewResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DashboardOverviewResponseBuilder? _data;
  DashboardOverviewResponseBuilder get data =>
      _$this._data ??= DashboardOverviewResponseBuilder();
  set data(DashboardOverviewResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDashboardOverviewResponseBuilder() {
    BaseResponseDashboardOverviewResponse._defaults(this);
  }

  BaseResponseDashboardOverviewResponseBuilder get _$this {
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
  void replace(BaseResponseDashboardOverviewResponse other) {
    _$v = other as _$BaseResponseDashboardOverviewResponse;
  }

  @override
  void update(
    void Function(BaseResponseDashboardOverviewResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDashboardOverviewResponse build() => _build();

  _$BaseResponseDashboardOverviewResponse _build() {
    _$BaseResponseDashboardOverviewResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDashboardOverviewResponse._(
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
          r'BaseResponseDashboardOverviewResponse',
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
