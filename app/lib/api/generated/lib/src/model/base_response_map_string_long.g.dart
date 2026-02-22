// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_map_string_long.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseMapStringLong extends BaseResponseMapStringLong {
  @override
  final int? code;
  @override
  final BuiltMap<String, int>? data;
  @override
  final String? message;

  factory _$BaseResponseMapStringLong([
    void Function(BaseResponseMapStringLongBuilder)? updates,
  ]) => (BaseResponseMapStringLongBuilder()..update(updates))._build();

  _$BaseResponseMapStringLong._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseMapStringLong rebuild(
    void Function(BaseResponseMapStringLongBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseMapStringLongBuilder toBuilder() =>
      BaseResponseMapStringLongBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseMapStringLong &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseMapStringLong')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseMapStringLongBuilder
    implements
        Builder<BaseResponseMapStringLong, BaseResponseMapStringLongBuilder> {
  _$BaseResponseMapStringLong? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  MapBuilder<String, int>? _data;
  MapBuilder<String, int> get data =>
      _$this._data ??= MapBuilder<String, int>();
  set data(MapBuilder<String, int>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseMapStringLongBuilder() {
    BaseResponseMapStringLong._defaults(this);
  }

  BaseResponseMapStringLongBuilder get _$this {
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
  void replace(BaseResponseMapStringLong other) {
    _$v = other as _$BaseResponseMapStringLong;
  }

  @override
  void update(void Function(BaseResponseMapStringLongBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseMapStringLong build() => _build();

  _$BaseResponseMapStringLong _build() {
    _$BaseResponseMapStringLong _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseMapStringLong._(
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
          r'BaseResponseMapStringLong',
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
