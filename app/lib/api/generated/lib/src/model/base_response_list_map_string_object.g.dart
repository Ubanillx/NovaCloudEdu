// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_map_string_object.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListMapStringObject
    extends BaseResponseListMapStringObject {
  @override
  final int? code;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? data;
  @override
  final String? message;

  factory _$BaseResponseListMapStringObject([
    void Function(BaseResponseListMapStringObjectBuilder)? updates,
  ]) => (BaseResponseListMapStringObjectBuilder()..update(updates))._build();

  _$BaseResponseListMapStringObject._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListMapStringObject rebuild(
    void Function(BaseResponseListMapStringObjectBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListMapStringObjectBuilder toBuilder() =>
      BaseResponseListMapStringObjectBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListMapStringObject &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListMapStringObject')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListMapStringObjectBuilder
    implements
        Builder<
          BaseResponseListMapStringObject,
          BaseResponseListMapStringObjectBuilder
        > {
  _$BaseResponseListMapStringObject? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<BuiltMap<String, JsonObject>>? _data;
  ListBuilder<BuiltMap<String, JsonObject>> get data =>
      _$this._data ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set data(ListBuilder<BuiltMap<String, JsonObject>>? data) =>
      _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListMapStringObjectBuilder() {
    BaseResponseListMapStringObject._defaults(this);
  }

  BaseResponseListMapStringObjectBuilder get _$this {
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
  void replace(BaseResponseListMapStringObject other) {
    _$v = other as _$BaseResponseListMapStringObject;
  }

  @override
  void update(void Function(BaseResponseListMapStringObjectBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListMapStringObject build() => _build();

  _$BaseResponseListMapStringObject _build() {
    _$BaseResponseListMapStringObject _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListMapStringObject._(
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
          r'BaseResponseListMapStringObject',
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
