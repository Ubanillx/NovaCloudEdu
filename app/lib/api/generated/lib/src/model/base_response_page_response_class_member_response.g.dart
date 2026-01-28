// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_page_response_class_member_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePageResponseClassMemberResponse
    extends BaseResponsePageResponseClassMemberResponse {
  @override
  final int? code;
  @override
  final PageResponseClassMemberResponse? data;
  @override
  final String? message;

  factory _$BaseResponsePageResponseClassMemberResponse([
    void Function(BaseResponsePageResponseClassMemberResponseBuilder)? updates,
  ]) => (BaseResponsePageResponseClassMemberResponseBuilder()..update(updates))
      ._build();

  _$BaseResponsePageResponseClassMemberResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponsePageResponseClassMemberResponse rebuild(
    void Function(BaseResponsePageResponseClassMemberResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePageResponseClassMemberResponseBuilder toBuilder() =>
      BaseResponsePageResponseClassMemberResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePageResponseClassMemberResponse &&
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
            r'BaseResponsePageResponseClassMemberResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePageResponseClassMemberResponseBuilder
    implements
        Builder<
          BaseResponsePageResponseClassMemberResponse,
          BaseResponsePageResponseClassMemberResponseBuilder
        > {
  _$BaseResponsePageResponseClassMemberResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PageResponseClassMemberResponseBuilder? _data;
  PageResponseClassMemberResponseBuilder get data =>
      _$this._data ??= PageResponseClassMemberResponseBuilder();
  set data(PageResponseClassMemberResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePageResponseClassMemberResponseBuilder() {
    BaseResponsePageResponseClassMemberResponse._defaults(this);
  }

  BaseResponsePageResponseClassMemberResponseBuilder get _$this {
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
  void replace(BaseResponsePageResponseClassMemberResponse other) {
    _$v = other as _$BaseResponsePageResponseClassMemberResponse;
  }

  @override
  void update(
    void Function(BaseResponsePageResponseClassMemberResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePageResponseClassMemberResponse build() => _build();

  _$BaseResponsePageResponseClassMemberResponse _build() {
    _$BaseResponsePageResponseClassMemberResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePageResponseClassMemberResponse._(
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
          r'BaseResponsePageResponseClassMemberResponse',
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
