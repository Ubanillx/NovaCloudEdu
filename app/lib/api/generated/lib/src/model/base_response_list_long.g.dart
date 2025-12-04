// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_long.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListLong extends BaseResponseListLong {
  @override
  final int? code;
  @override
  final BuiltList<int>? data;
  @override
  final String? message;

  factory _$BaseResponseListLong(
          [void Function(BaseResponseListLongBuilder)? updates]) =>
      (BaseResponseListLongBuilder()..update(updates))._build();

  _$BaseResponseListLong._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseListLong rebuild(
          void Function(BaseResponseListLongBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BaseResponseListLongBuilder toBuilder() =>
      BaseResponseListLongBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListLong &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListLong')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListLongBuilder
    implements Builder<BaseResponseListLong, BaseResponseListLongBuilder> {
  _$BaseResponseListLong? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<int>? _data;
  ListBuilder<int> get data => _$this._data ??= ListBuilder<int>();
  set data(ListBuilder<int>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListLongBuilder() {
    BaseResponseListLong._defaults(this);
  }

  BaseResponseListLongBuilder get _$this {
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
  void replace(BaseResponseListLong other) {
    _$v = other as _$BaseResponseListLong;
  }

  @override
  void update(void Function(BaseResponseListLongBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListLong build() => _build();

  _$BaseResponseListLong _build() {
    _$BaseResponseListLong _$result;
    try {
      _$result = _$v ??
          _$BaseResponseListLong._(
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
            r'BaseResponseListLong', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
