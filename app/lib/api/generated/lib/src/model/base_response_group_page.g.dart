// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_group_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseGroupPage extends BaseResponseGroupPage {
  @override
  final int? code;
  @override
  final GroupPage? data;
  @override
  final String? message;

  factory _$BaseResponseGroupPage([
    void Function(BaseResponseGroupPageBuilder)? updates,
  ]) => (BaseResponseGroupPageBuilder()..update(updates))._build();

  _$BaseResponseGroupPage._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseGroupPage rebuild(
    void Function(BaseResponseGroupPageBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseGroupPageBuilder toBuilder() =>
      BaseResponseGroupPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseGroupPage &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseGroupPage')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseGroupPageBuilder
    implements Builder<BaseResponseGroupPage, BaseResponseGroupPageBuilder> {
  _$BaseResponseGroupPage? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  GroupPageBuilder? _data;
  GroupPageBuilder get data => _$this._data ??= GroupPageBuilder();
  set data(GroupPageBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseGroupPageBuilder() {
    BaseResponseGroupPage._defaults(this);
  }

  BaseResponseGroupPageBuilder get _$this {
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
  void replace(BaseResponseGroupPage other) {
    _$v = other as _$BaseResponseGroupPage;
  }

  @override
  void update(void Function(BaseResponseGroupPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseGroupPage build() => _build();

  _$BaseResponseGroupPage _build() {
    _$BaseResponseGroupPage _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseGroupPage._(
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
          r'BaseResponseGroupPage',
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
