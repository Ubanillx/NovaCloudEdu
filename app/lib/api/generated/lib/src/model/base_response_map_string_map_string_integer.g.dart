// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_map_string_map_string_integer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseMapStringMapStringInteger
    extends BaseResponseMapStringMapStringInteger {
  @override
  final int? code;
  @override
  final BuiltMap<String, BuiltMap<String, int>>? data;
  @override
  final String? message;

  factory _$BaseResponseMapStringMapStringInteger([
    void Function(BaseResponseMapStringMapStringIntegerBuilder)? updates,
  ]) => (BaseResponseMapStringMapStringIntegerBuilder()..update(updates))
      ._build();

  _$BaseResponseMapStringMapStringInteger._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseMapStringMapStringInteger rebuild(
    void Function(BaseResponseMapStringMapStringIntegerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseMapStringMapStringIntegerBuilder toBuilder() =>
      BaseResponseMapStringMapStringIntegerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseMapStringMapStringInteger &&
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
            r'BaseResponseMapStringMapStringInteger',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseMapStringMapStringIntegerBuilder
    implements
        Builder<
          BaseResponseMapStringMapStringInteger,
          BaseResponseMapStringMapStringIntegerBuilder
        > {
  _$BaseResponseMapStringMapStringInteger? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  MapBuilder<String, BuiltMap<String, int>>? _data;
  MapBuilder<String, BuiltMap<String, int>> get data =>
      _$this._data ??= MapBuilder<String, BuiltMap<String, int>>();
  set data(MapBuilder<String, BuiltMap<String, int>>? data) =>
      _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseMapStringMapStringIntegerBuilder() {
    BaseResponseMapStringMapStringInteger._defaults(this);
  }

  BaseResponseMapStringMapStringIntegerBuilder get _$this {
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
  void replace(BaseResponseMapStringMapStringInteger other) {
    _$v = other as _$BaseResponseMapStringMapStringInteger;
  }

  @override
  void update(
    void Function(BaseResponseMapStringMapStringIntegerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseMapStringMapStringInteger build() => _build();

  _$BaseResponseMapStringMapStringInteger _build() {
    _$BaseResponseMapStringMapStringInteger _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseMapStringMapStringInteger._(
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
          r'BaseResponseMapStringMapStringInteger',
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
