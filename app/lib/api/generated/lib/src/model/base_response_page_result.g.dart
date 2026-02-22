// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_page_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePageResult extends BaseResponsePageResult {
  @override
  final int? code;
  @override
  final PageResult? data;
  @override
  final String? message;

  factory _$BaseResponsePageResult([
    void Function(BaseResponsePageResultBuilder)? updates,
  ]) => (BaseResponsePageResultBuilder()..update(updates))._build();

  _$BaseResponsePageResult._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponsePageResult rebuild(
    void Function(BaseResponsePageResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePageResultBuilder toBuilder() =>
      BaseResponsePageResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePageResult &&
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
    return (newBuiltValueToStringHelper(r'BaseResponsePageResult')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePageResultBuilder
    implements Builder<BaseResponsePageResult, BaseResponsePageResultBuilder> {
  _$BaseResponsePageResult? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PageResultBuilder? _data;
  PageResultBuilder get data => _$this._data ??= PageResultBuilder();
  set data(PageResultBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePageResultBuilder() {
    BaseResponsePageResult._defaults(this);
  }

  BaseResponsePageResultBuilder get _$this {
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
  void replace(BaseResponsePageResult other) {
    _$v = other as _$BaseResponsePageResult;
  }

  @override
  void update(void Function(BaseResponsePageResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePageResult build() => _build();

  _$BaseResponsePageResult _build() {
    _$BaseResponsePageResult _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePageResult._(
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
          r'BaseResponsePageResult',
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
