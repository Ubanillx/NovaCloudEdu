// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_map_string_string.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseMapStringString extends BaseResponseMapStringString {
  @override
  final int? code;
  @override
  final BuiltMap<String, String>? data;
  @override
  final String? message;

  factory _$BaseResponseMapStringString([
    void Function(BaseResponseMapStringStringBuilder)? updates,
  ]) => (BaseResponseMapStringStringBuilder()..update(updates))._build();

  _$BaseResponseMapStringString._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseMapStringString rebuild(
    void Function(BaseResponseMapStringStringBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseMapStringStringBuilder toBuilder() =>
      BaseResponseMapStringStringBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseMapStringString &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseMapStringString')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseMapStringStringBuilder
    implements
        Builder<
          BaseResponseMapStringString,
          BaseResponseMapStringStringBuilder
        > {
  _$BaseResponseMapStringString? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  MapBuilder<String, String>? _data;
  MapBuilder<String, String> get data =>
      _$this._data ??= MapBuilder<String, String>();
  set data(MapBuilder<String, String>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseMapStringStringBuilder() {
    BaseResponseMapStringString._defaults(this);
  }

  BaseResponseMapStringStringBuilder get _$this {
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
  void replace(BaseResponseMapStringString other) {
    _$v = other as _$BaseResponseMapStringString;
  }

  @override
  void update(void Function(BaseResponseMapStringStringBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseMapStringString build() => _build();

  _$BaseResponseMapStringString _build() {
    _$BaseResponseMapStringString _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseMapStringString._(
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
          r'BaseResponseMapStringString',
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
