// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_knowledge_document_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListKnowledgeDocumentVO
    extends BaseResponseListKnowledgeDocumentVO {
  @override
  final int? code;
  @override
  final BuiltList<KnowledgeDocumentVO>? data;
  @override
  final String? message;

  factory _$BaseResponseListKnowledgeDocumentVO([
    void Function(BaseResponseListKnowledgeDocumentVOBuilder)? updates,
  ]) =>
      (BaseResponseListKnowledgeDocumentVOBuilder()..update(updates))._build();

  _$BaseResponseListKnowledgeDocumentVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListKnowledgeDocumentVO rebuild(
    void Function(BaseResponseListKnowledgeDocumentVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListKnowledgeDocumentVOBuilder toBuilder() =>
      BaseResponseListKnowledgeDocumentVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListKnowledgeDocumentVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListKnowledgeDocumentVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListKnowledgeDocumentVOBuilder
    implements
        Builder<
          BaseResponseListKnowledgeDocumentVO,
          BaseResponseListKnowledgeDocumentVOBuilder
        > {
  _$BaseResponseListKnowledgeDocumentVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<KnowledgeDocumentVO>? _data;
  ListBuilder<KnowledgeDocumentVO> get data =>
      _$this._data ??= ListBuilder<KnowledgeDocumentVO>();
  set data(ListBuilder<KnowledgeDocumentVO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListKnowledgeDocumentVOBuilder() {
    BaseResponseListKnowledgeDocumentVO._defaults(this);
  }

  BaseResponseListKnowledgeDocumentVOBuilder get _$this {
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
  void replace(BaseResponseListKnowledgeDocumentVO other) {
    _$v = other as _$BaseResponseListKnowledgeDocumentVO;
  }

  @override
  void update(
    void Function(BaseResponseListKnowledgeDocumentVOBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListKnowledgeDocumentVO build() => _build();

  _$BaseResponseListKnowledgeDocumentVO _build() {
    _$BaseResponseListKnowledgeDocumentVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListKnowledgeDocumentVO._(
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
          r'BaseResponseListKnowledgeDocumentVO',
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
