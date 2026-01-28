// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_schedule_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseScheduleResponse extends BaseResponseScheduleResponse {
  @override
  final int? code;
  @override
  final ScheduleResponse? data;
  @override
  final String? message;

  factory _$BaseResponseScheduleResponse([
    void Function(BaseResponseScheduleResponseBuilder)? updates,
  ]) => (BaseResponseScheduleResponseBuilder()..update(updates))._build();

  _$BaseResponseScheduleResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseScheduleResponse rebuild(
    void Function(BaseResponseScheduleResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseScheduleResponseBuilder toBuilder() =>
      BaseResponseScheduleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseScheduleResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseScheduleResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseScheduleResponseBuilder
    implements
        Builder<
          BaseResponseScheduleResponse,
          BaseResponseScheduleResponseBuilder
        > {
  _$BaseResponseScheduleResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ScheduleResponseBuilder? _data;
  ScheduleResponseBuilder get data =>
      _$this._data ??= ScheduleResponseBuilder();
  set data(ScheduleResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseScheduleResponseBuilder() {
    BaseResponseScheduleResponse._defaults(this);
  }

  BaseResponseScheduleResponseBuilder get _$this {
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
  void replace(BaseResponseScheduleResponse other) {
    _$v = other as _$BaseResponseScheduleResponse;
  }

  @override
  void update(void Function(BaseResponseScheduleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseScheduleResponse build() => _build();

  _$BaseResponseScheduleResponse _build() {
    _$BaseResponseScheduleResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseScheduleResponse._(
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
          r'BaseResponseScheduleResponse',
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
