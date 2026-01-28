// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_knowledge_document_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseKnowledgeDocumentVO
    extends BaseResponseKnowledgeDocumentVO {
  @override
  final int? code;
  @override
  final KnowledgeDocumentVO? data;
  @override
  final String? message;

  factory _$BaseResponseKnowledgeDocumentVO([
    void Function(BaseResponseKnowledgeDocumentVOBuilder)? updates,
  ]) => (BaseResponseKnowledgeDocumentVOBuilder()..update(updates))._build();

  _$BaseResponseKnowledgeDocumentVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseKnowledgeDocumentVO rebuild(
    void Function(BaseResponseKnowledgeDocumentVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseKnowledgeDocumentVOBuilder toBuilder() =>
      BaseResponseKnowledgeDocumentVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseKnowledgeDocumentVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseKnowledgeDocumentVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseKnowledgeDocumentVOBuilder
    implements
        Builder<
          BaseResponseKnowledgeDocumentVO,
          BaseResponseKnowledgeDocumentVOBuilder
        > {
  _$BaseResponseKnowledgeDocumentVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  KnowledgeDocumentVOBuilder? _data;
  KnowledgeDocumentVOBuilder get data =>
      _$this._data ??= KnowledgeDocumentVOBuilder();
  set data(KnowledgeDocumentVOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseKnowledgeDocumentVOBuilder() {
    BaseResponseKnowledgeDocumentVO._defaults(this);
  }

  BaseResponseKnowledgeDocumentVOBuilder get _$this {
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
  void replace(BaseResponseKnowledgeDocumentVO other) {
    _$v = other as _$BaseResponseKnowledgeDocumentVO;
  }

  @override
  void update(void Function(BaseResponseKnowledgeDocumentVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseKnowledgeDocumentVO build() => _build();

  _$BaseResponseKnowledgeDocumentVO _build() {
    _$BaseResponseKnowledgeDocumentVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseKnowledgeDocumentVO._(
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
          r'BaseResponseKnowledgeDocumentVO',
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
