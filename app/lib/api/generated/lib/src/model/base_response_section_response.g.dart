// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_section_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseSectionResponse extends BaseResponseSectionResponse {
  @override
  final int? code;
  @override
  final SectionResponse? data;
  @override
  final String? message;

  factory _$BaseResponseSectionResponse([
    void Function(BaseResponseSectionResponseBuilder)? updates,
  ]) => (BaseResponseSectionResponseBuilder()..update(updates))._build();

  _$BaseResponseSectionResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseSectionResponse rebuild(
    void Function(BaseResponseSectionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseSectionResponseBuilder toBuilder() =>
      BaseResponseSectionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseSectionResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseSectionResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseSectionResponseBuilder
    implements
        Builder<
          BaseResponseSectionResponse,
          BaseResponseSectionResponseBuilder
        > {
  _$BaseResponseSectionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  SectionResponseBuilder? _data;
  SectionResponseBuilder get data => _$this._data ??= SectionResponseBuilder();
  set data(SectionResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseSectionResponseBuilder() {
    BaseResponseSectionResponse._defaults(this);
  }

  BaseResponseSectionResponseBuilder get _$this {
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
  void replace(BaseResponseSectionResponse other) {
    _$v = other as _$BaseResponseSectionResponse;
  }

  @override
  void update(void Function(BaseResponseSectionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseSectionResponse build() => _build();

  _$BaseResponseSectionResponse _build() {
    _$BaseResponseSectionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseSectionResponse._(
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
          r'BaseResponseSectionResponse',
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
