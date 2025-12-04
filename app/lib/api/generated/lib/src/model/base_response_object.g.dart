// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_object.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseObject extends BaseResponseObject {
  @override
  final int? code;
  @override
  final JsonObject? data;
  @override
  final String? message;

  factory _$BaseResponseObject(
          [void Function(BaseResponseObjectBuilder)? updates]) =>
      (BaseResponseObjectBuilder()..update(updates))._build();

  _$BaseResponseObject._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseObject rebuild(
          void Function(BaseResponseObjectBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseObjectBuilder toBuilder() =>
      BaseResponseObjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseObject &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseObject')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseObjectBuilder
    implements Builder<BaseResponseObject, BaseResponseObjectBuilder> {
  _$BaseResponseObject? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseObjectBuilder() {
    BaseResponseObject._defaults(this);
  }

  BaseResponseObjectBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseObject other) {
    _$v = other as _$BaseResponseObject;
  }

  @override
  void update(void Function(BaseResponseObjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseObject build() => _build();

  _$BaseResponseObject _build() {
    final _$result = _$v ??
        _$BaseResponseObject._(
          code: code,
          data: data,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
