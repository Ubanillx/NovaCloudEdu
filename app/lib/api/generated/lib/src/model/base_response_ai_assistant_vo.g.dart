// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_ai_assistant_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseAiAssistantVO extends BaseResponseAiAssistantVO {
  @override
  final int? code;
  @override
  final AiAssistantVO? data;
  @override
  final String? message;

  factory _$BaseResponseAiAssistantVO([
    void Function(BaseResponseAiAssistantVOBuilder)? updates,
  ]) => (BaseResponseAiAssistantVOBuilder()..update(updates))._build();

  _$BaseResponseAiAssistantVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseAiAssistantVO rebuild(
    void Function(BaseResponseAiAssistantVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseAiAssistantVOBuilder toBuilder() =>
      BaseResponseAiAssistantVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseAiAssistantVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseAiAssistantVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseAiAssistantVOBuilder
    implements
        Builder<BaseResponseAiAssistantVO, BaseResponseAiAssistantVOBuilder> {
  _$BaseResponseAiAssistantVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  AiAssistantVOBuilder? _data;
  AiAssistantVOBuilder get data => _$this._data ??= AiAssistantVOBuilder();
  set data(AiAssistantVOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseAiAssistantVOBuilder() {
    BaseResponseAiAssistantVO._defaults(this);
  }

  BaseResponseAiAssistantVOBuilder get _$this {
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
  void replace(BaseResponseAiAssistantVO other) {
    _$v = other as _$BaseResponseAiAssistantVO;
  }

  @override
  void update(void Function(BaseResponseAiAssistantVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseAiAssistantVO build() => _build();

  _$BaseResponseAiAssistantVO _build() {
    _$BaseResponseAiAssistantVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseAiAssistantVO._(
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
          r'BaseResponseAiAssistantVO',
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
