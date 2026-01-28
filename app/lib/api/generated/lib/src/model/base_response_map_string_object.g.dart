// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_map_string_object.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseMapStringObject extends BaseResponseMapStringObject {
  @override
  final int? code;
  @override
  final BuiltMap<String, JsonObject>? data;
  @override
  final String? message;

  factory _$BaseResponseMapStringObject([
    void Function(BaseResponseMapStringObjectBuilder)? updates,
  ]) => (BaseResponseMapStringObjectBuilder()..update(updates))._build();

  _$BaseResponseMapStringObject._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseMapStringObject rebuild(
    void Function(BaseResponseMapStringObjectBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseMapStringObjectBuilder toBuilder() =>
      BaseResponseMapStringObjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseMapStringObject &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseMapStringObject')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseMapStringObjectBuilder
    implements
        Builder<
          BaseResponseMapStringObject,
          BaseResponseMapStringObjectBuilder
        > {
  _$BaseResponseMapStringObject? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  MapBuilder<String, JsonObject>? _data;
  MapBuilder<String, JsonObject> get data =>
      _$this._data ??= MapBuilder<String, JsonObject>();
  set data(MapBuilder<String, JsonObject>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseMapStringObjectBuilder() {
    BaseResponseMapStringObject._defaults(this);
  }

  BaseResponseMapStringObjectBuilder get _$this {
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
  void replace(BaseResponseMapStringObject other) {
    _$v = other as _$BaseResponseMapStringObject;
  }

  @override
  void update(void Function(BaseResponseMapStringObjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseMapStringObject build() => _build();

  _$BaseResponseMapStringObject _build() {
    _$BaseResponseMapStringObject _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseMapStringObject._(
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
          r'BaseResponseMapStringObject',
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
