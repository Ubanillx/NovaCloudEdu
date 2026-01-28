// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_knowledge_base_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListKnowledgeBaseVO
    extends BaseResponseListKnowledgeBaseVO {
  @override
  final int? code;
  @override
  final BuiltList<KnowledgeBaseVO>? data;
  @override
  final String? message;

  factory _$BaseResponseListKnowledgeBaseVO([
    void Function(BaseResponseListKnowledgeBaseVOBuilder)? updates,
  ]) => (BaseResponseListKnowledgeBaseVOBuilder()..update(updates))._build();

  _$BaseResponseListKnowledgeBaseVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListKnowledgeBaseVO rebuild(
    void Function(BaseResponseListKnowledgeBaseVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListKnowledgeBaseVOBuilder toBuilder() =>
      BaseResponseListKnowledgeBaseVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListKnowledgeBaseVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListKnowledgeBaseVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListKnowledgeBaseVOBuilder
    implements
        Builder<
          BaseResponseListKnowledgeBaseVO,
          BaseResponseListKnowledgeBaseVOBuilder
        > {
  _$BaseResponseListKnowledgeBaseVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<KnowledgeBaseVO>? _data;
  ListBuilder<KnowledgeBaseVO> get data =>
      _$this._data ??= ListBuilder<KnowledgeBaseVO>();
  set data(ListBuilder<KnowledgeBaseVO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListKnowledgeBaseVOBuilder() {
    BaseResponseListKnowledgeBaseVO._defaults(this);
  }

  BaseResponseListKnowledgeBaseVOBuilder get _$this {
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
  void replace(BaseResponseListKnowledgeBaseVO other) {
    _$v = other as _$BaseResponseListKnowledgeBaseVO;
  }

  @override
  void update(void Function(BaseResponseListKnowledgeBaseVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListKnowledgeBaseVO build() => _build();

  _$BaseResponseListKnowledgeBaseVO _build() {
    _$BaseResponseListKnowledgeBaseVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListKnowledgeBaseVO._(
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
          r'BaseResponseListKnowledgeBaseVO',
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
