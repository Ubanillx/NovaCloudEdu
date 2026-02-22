// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_knowledge_profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListKnowledgeProfileResponse
    extends BaseResponseListKnowledgeProfileResponse {
  @override
  final int? code;
  @override
  final BuiltList<KnowledgeProfileResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListKnowledgeProfileResponse([
    void Function(BaseResponseListKnowledgeProfileResponseBuilder)? updates,
  ]) => (BaseResponseListKnowledgeProfileResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListKnowledgeProfileResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListKnowledgeProfileResponse rebuild(
    void Function(BaseResponseListKnowledgeProfileResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListKnowledgeProfileResponseBuilder toBuilder() =>
      BaseResponseListKnowledgeProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListKnowledgeProfileResponse &&
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
            r'BaseResponseListKnowledgeProfileResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListKnowledgeProfileResponseBuilder
    implements
        Builder<
          BaseResponseListKnowledgeProfileResponse,
          BaseResponseListKnowledgeProfileResponseBuilder
        > {
  _$BaseResponseListKnowledgeProfileResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<KnowledgeProfileResponse>? _data;
  ListBuilder<KnowledgeProfileResponse> get data =>
      _$this._data ??= ListBuilder<KnowledgeProfileResponse>();
  set data(ListBuilder<KnowledgeProfileResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListKnowledgeProfileResponseBuilder() {
    BaseResponseListKnowledgeProfileResponse._defaults(this);
  }

  BaseResponseListKnowledgeProfileResponseBuilder get _$this {
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
  void replace(BaseResponseListKnowledgeProfileResponse other) {
    _$v = other as _$BaseResponseListKnowledgeProfileResponse;
  }

  @override
  void update(
    void Function(BaseResponseListKnowledgeProfileResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListKnowledgeProfileResponse build() => _build();

  _$BaseResponseListKnowledgeProfileResponse _build() {
    _$BaseResponseListKnowledgeProfileResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListKnowledgeProfileResponse._(
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
          r'BaseResponseListKnowledgeProfileResponse',
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
