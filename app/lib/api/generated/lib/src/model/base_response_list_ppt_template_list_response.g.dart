// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_ppt_template_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListPptTemplateListResponse
    extends BaseResponseListPptTemplateListResponse {
  @override
  final int? code;
  @override
  final BuiltList<PptTemplateListResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListPptTemplateListResponse([
    void Function(BaseResponseListPptTemplateListResponseBuilder)? updates,
  ]) => (BaseResponseListPptTemplateListResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListPptTemplateListResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListPptTemplateListResponse rebuild(
    void Function(BaseResponseListPptTemplateListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListPptTemplateListResponseBuilder toBuilder() =>
      BaseResponseListPptTemplateListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListPptTemplateListResponse &&
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
            r'BaseResponseListPptTemplateListResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListPptTemplateListResponseBuilder
    implements
        Builder<
          BaseResponseListPptTemplateListResponse,
          BaseResponseListPptTemplateListResponseBuilder
        > {
  _$BaseResponseListPptTemplateListResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<PptTemplateListResponse>? _data;
  ListBuilder<PptTemplateListResponse> get data =>
      _$this._data ??= ListBuilder<PptTemplateListResponse>();
  set data(ListBuilder<PptTemplateListResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListPptTemplateListResponseBuilder() {
    BaseResponseListPptTemplateListResponse._defaults(this);
  }

  BaseResponseListPptTemplateListResponseBuilder get _$this {
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
  void replace(BaseResponseListPptTemplateListResponse other) {
    _$v = other as _$BaseResponseListPptTemplateListResponse;
  }

  @override
  void update(
    void Function(BaseResponseListPptTemplateListResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListPptTemplateListResponse build() => _build();

  _$BaseResponseListPptTemplateListResponse _build() {
    _$BaseResponseListPptTemplateListResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListPptTemplateListResponse._(
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
          r'BaseResponseListPptTemplateListResponse',
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
