// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_knowledge_base_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseKnowledgeBaseVO extends BaseResponseKnowledgeBaseVO {
  @override
  final int? code;
  @override
  final KnowledgeBaseVO? data;
  @override
  final String? message;

  factory _$BaseResponseKnowledgeBaseVO([
    void Function(BaseResponseKnowledgeBaseVOBuilder)? updates,
  ]) => (BaseResponseKnowledgeBaseVOBuilder()..update(updates))._build();

  _$BaseResponseKnowledgeBaseVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseKnowledgeBaseVO rebuild(
    void Function(BaseResponseKnowledgeBaseVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseKnowledgeBaseVOBuilder toBuilder() =>
      BaseResponseKnowledgeBaseVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseKnowledgeBaseVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseKnowledgeBaseVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseKnowledgeBaseVOBuilder
    implements
        Builder<
          BaseResponseKnowledgeBaseVO,
          BaseResponseKnowledgeBaseVOBuilder
        > {
  _$BaseResponseKnowledgeBaseVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  KnowledgeBaseVOBuilder? _data;
  KnowledgeBaseVOBuilder get data => _$this._data ??= KnowledgeBaseVOBuilder();
  set data(KnowledgeBaseVOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseKnowledgeBaseVOBuilder() {
    BaseResponseKnowledgeBaseVO._defaults(this);
  }

  BaseResponseKnowledgeBaseVOBuilder get _$this {
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
  void replace(BaseResponseKnowledgeBaseVO other) {
    _$v = other as _$BaseResponseKnowledgeBaseVO;
  }

  @override
  void update(void Function(BaseResponseKnowledgeBaseVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseKnowledgeBaseVO build() => _build();

  _$BaseResponseKnowledgeBaseVO _build() {
    _$BaseResponseKnowledgeBaseVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseKnowledgeBaseVO._(
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
          r'BaseResponseKnowledgeBaseVO',
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
