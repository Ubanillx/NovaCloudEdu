// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_ai_assistant_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListAiAssistantVO extends BaseResponseListAiAssistantVO {
  @override
  final int? code;
  @override
  final BuiltList<AiAssistantVO>? data;
  @override
  final String? message;

  factory _$BaseResponseListAiAssistantVO([
    void Function(BaseResponseListAiAssistantVOBuilder)? updates,
  ]) => (BaseResponseListAiAssistantVOBuilder()..update(updates))._build();

  _$BaseResponseListAiAssistantVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListAiAssistantVO rebuild(
    void Function(BaseResponseListAiAssistantVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListAiAssistantVOBuilder toBuilder() =>
      BaseResponseListAiAssistantVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListAiAssistantVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListAiAssistantVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListAiAssistantVOBuilder
    implements
        Builder<
          BaseResponseListAiAssistantVO,
          BaseResponseListAiAssistantVOBuilder
        > {
  _$BaseResponseListAiAssistantVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<AiAssistantVO>? _data;
  ListBuilder<AiAssistantVO> get data =>
      _$this._data ??= ListBuilder<AiAssistantVO>();
  set data(ListBuilder<AiAssistantVO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListAiAssistantVOBuilder() {
    BaseResponseListAiAssistantVO._defaults(this);
  }

  BaseResponseListAiAssistantVOBuilder get _$this {
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
  void replace(BaseResponseListAiAssistantVO other) {
    _$v = other as _$BaseResponseListAiAssistantVO;
  }

  @override
  void update(void Function(BaseResponseListAiAssistantVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListAiAssistantVO build() => _build();

  _$BaseResponseListAiAssistantVO _build() {
    _$BaseResponseListAiAssistantVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListAiAssistantVO._(
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
          r'BaseResponseListAiAssistantVO',
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
