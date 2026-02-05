// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_string.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListString extends BaseResponseListString {
  @override
  final int? code;
  @override
  final BuiltList<String>? data;
  @override
  final String? message;

  factory _$BaseResponseListString([
    void Function(BaseResponseListStringBuilder)? updates,
  ]) => (BaseResponseListStringBuilder()..update(updates))._build();

  _$BaseResponseListString._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseListString rebuild(
    void Function(BaseResponseListStringBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListStringBuilder toBuilder() =>
      BaseResponseListStringBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListString &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListString')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListStringBuilder
    implements Builder<BaseResponseListString, BaseResponseListStringBuilder> {
  _$BaseResponseListString? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<String>? _data;
  ListBuilder<String> get data => _$this._data ??= ListBuilder<String>();
  set data(ListBuilder<String>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListStringBuilder() {
    BaseResponseListString._defaults(this);
  }

  BaseResponseListStringBuilder get _$this {
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
  void replace(BaseResponseListString other) {
    _$v = other as _$BaseResponseListString;
  }

  @override
  void update(void Function(BaseResponseListStringBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListString build() => _build();

  _$BaseResponseListString _build() {
    _$BaseResponseListString _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListString._(
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
          r'BaseResponseListString',
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
