// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_member_page.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseMemberPage extends BaseResponseMemberPage {
  @override
  final int? code;
  @override
  final MemberPage? data;
  @override
  final String? message;

  factory _$BaseResponseMemberPage([
    void Function(BaseResponseMemberPageBuilder)? updates,
  ]) => (BaseResponseMemberPageBuilder()..update(updates))._build();

  _$BaseResponseMemberPage._({this.code, this.data, this.message}) : super._();
  @override
  BaseResponseMemberPage rebuild(
    void Function(BaseResponseMemberPageBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseMemberPageBuilder toBuilder() =>
      BaseResponseMemberPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseMemberPage &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseMemberPage')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseMemberPageBuilder
    implements Builder<BaseResponseMemberPage, BaseResponseMemberPageBuilder> {
  _$BaseResponseMemberPage? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  MemberPageBuilder? _data;
  MemberPageBuilder get data => _$this._data ??= MemberPageBuilder();
  set data(MemberPageBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseMemberPageBuilder() {
    BaseResponseMemberPage._defaults(this);
  }

  BaseResponseMemberPageBuilder get _$this {
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
  void replace(BaseResponseMemberPage other) {
    _$v = other as _$BaseResponseMemberPage;
  }

  @override
  void update(void Function(BaseResponseMemberPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseMemberPage build() => _build();

  _$BaseResponseMemberPage _build() {
    _$BaseResponseMemberPage _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseMemberPage._(
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
          r'BaseResponseMemberPage',
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
