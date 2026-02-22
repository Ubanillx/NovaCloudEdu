// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_ppt_template_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePptTemplateDetailResponse
    extends BaseResponsePptTemplateDetailResponse {
  @override
  final int? code;
  @override
  final PptTemplateDetailResponse? data;
  @override
  final String? message;

  factory _$BaseResponsePptTemplateDetailResponse([
    void Function(BaseResponsePptTemplateDetailResponseBuilder)? updates,
  ]) => (BaseResponsePptTemplateDetailResponseBuilder()..update(updates))
      ._build();

  _$BaseResponsePptTemplateDetailResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponsePptTemplateDetailResponse rebuild(
    void Function(BaseResponsePptTemplateDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePptTemplateDetailResponseBuilder toBuilder() =>
      BaseResponsePptTemplateDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePptTemplateDetailResponse &&
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
            r'BaseResponsePptTemplateDetailResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePptTemplateDetailResponseBuilder
    implements
        Builder<
          BaseResponsePptTemplateDetailResponse,
          BaseResponsePptTemplateDetailResponseBuilder
        > {
  _$BaseResponsePptTemplateDetailResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PptTemplateDetailResponseBuilder? _data;
  PptTemplateDetailResponseBuilder get data =>
      _$this._data ??= PptTemplateDetailResponseBuilder();
  set data(PptTemplateDetailResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePptTemplateDetailResponseBuilder() {
    BaseResponsePptTemplateDetailResponse._defaults(this);
  }

  BaseResponsePptTemplateDetailResponseBuilder get _$this {
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
  void replace(BaseResponsePptTemplateDetailResponse other) {
    _$v = other as _$BaseResponsePptTemplateDetailResponse;
  }

  @override
  void update(
    void Function(BaseResponsePptTemplateDetailResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePptTemplateDetailResponse build() => _build();

  _$BaseResponsePptTemplateDetailResponse _build() {
    _$BaseResponsePptTemplateDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePptTemplateDetailResponse._(
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
          r'BaseResponsePptTemplateDetailResponse',
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
