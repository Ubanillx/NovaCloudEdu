// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_dashboard_content_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseDashboardContentResponse
    extends BaseResponseDashboardContentResponse {
  @override
  final int? code;
  @override
  final DashboardContentResponse? data;
  @override
  final String? message;

  factory _$BaseResponseDashboardContentResponse([
    void Function(BaseResponseDashboardContentResponseBuilder)? updates,
  ]) =>
      (BaseResponseDashboardContentResponseBuilder()..update(updates))._build();

  _$BaseResponseDashboardContentResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseDashboardContentResponse rebuild(
    void Function(BaseResponseDashboardContentResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseDashboardContentResponseBuilder toBuilder() =>
      BaseResponseDashboardContentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseDashboardContentResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseDashboardContentResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseDashboardContentResponseBuilder
    implements
        Builder<
          BaseResponseDashboardContentResponse,
          BaseResponseDashboardContentResponseBuilder
        > {
  _$BaseResponseDashboardContentResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  DashboardContentResponseBuilder? _data;
  DashboardContentResponseBuilder get data =>
      _$this._data ??= DashboardContentResponseBuilder();
  set data(DashboardContentResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseDashboardContentResponseBuilder() {
    BaseResponseDashboardContentResponse._defaults(this);
  }

  BaseResponseDashboardContentResponseBuilder get _$this {
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
  void replace(BaseResponseDashboardContentResponse other) {
    _$v = other as _$BaseResponseDashboardContentResponse;
  }

  @override
  void update(
    void Function(BaseResponseDashboardContentResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseDashboardContentResponse build() => _build();

  _$BaseResponseDashboardContentResponse _build() {
    _$BaseResponseDashboardContentResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseDashboardContentResponse._(
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
          r'BaseResponseDashboardContentResponse',
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
