// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dashboard_full_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDashboardFullResponse
    extends BaseResponseDashboardFullResponse {
  @override
  final int? code;
  @override
  final DashboardFullResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDashboardFullResponse([
    void Function(BaseResponseDashboardFullResponseBuilder)? updates,
  ]) => (BaseResponseDashboardFullResponseBuilder()..update(updates))._build();

  _$BaseResponseDashboardFullResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDashboardFullResponse rebuild(
    void Function(BaseResponseDashboardFullResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDashboardFullResponseBuilder toBuilder() =>
      BaseResponseDashboardFullResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDashboardFullResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDashboardFullResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDashboardFullResponseBuilder
    implements
        Builder<
          BaseResponseDashboardFullResponse,
          BaseResponseDashboardFullResponseBuilder
        > {
  _$BaseResponseDashboardFullResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DashboardFullResponseBuilder? _data;
  DashboardFullResponseBuilder get data =>
      _$this._data ??= DashboardFullResponseBuilder();
  set data(DashboardFullResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDashboardFullResponseBuilder() {
    BaseResponseDashboardFullResponse._defaults(this);
  }

  BaseResponseDashboardFullResponseBuilder get _$this {
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
  void replace(BaseResponseDashboardFullResponse other) {
    _$v = other as _$BaseResponseDashboardFullResponse;
  }

  @override
  void update(
    void Function(BaseResponseDashboardFullResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDashboardFullResponse build() => _build();

  _$BaseResponseDashboardFullResponse _build() {
    _$BaseResponseDashboardFullResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDashboardFullResponse._(
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
          r'BaseResponseDashboardFullResponse',
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
