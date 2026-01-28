// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_section_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListSectionResponse
    extends BaseResponseListSectionResponse {
  @override
  final int? code;
  @override
  final BuiltList<SectionResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListSectionResponse([
    void Function(BaseResponseListSectionResponseBuilder)? updates,
  ]) => (BaseResponseListSectionResponseBuilder()..update(updates))._build();

  _$BaseResponseListSectionResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListSectionResponse rebuild(
    void Function(BaseResponseListSectionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListSectionResponseBuilder toBuilder() =>
      BaseResponseListSectionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListSectionResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListSectionResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListSectionResponseBuilder
    implements
        Builder<
          BaseResponseListSectionResponse,
          BaseResponseListSectionResponseBuilder
        > {
  _$BaseResponseListSectionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<SectionResponse>? _data;
  ListBuilder<SectionResponse> get data =>
      _$this._data ??= ListBuilder<SectionResponse>();
  set data(ListBuilder<SectionResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListSectionResponseBuilder() {
    BaseResponseListSectionResponse._defaults(this);
  }

  BaseResponseListSectionResponseBuilder get _$this {
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
  void replace(BaseResponseListSectionResponse other) {
    _$v = other as _$BaseResponseListSectionResponse;
  }

  @override
  void update(void Function(BaseResponseListSectionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListSectionResponse build() => _build();

  _$BaseResponseListSectionResponse _build() {
    _$BaseResponseListSectionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListSectionResponse._(
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
          r'BaseResponseListSectionResponse',
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
