// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_definition_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowDefinitionResponse
    extends BaseResponseWorkflowDefinitionResponse {
  @override
  final int? code;
  @override
  final WorkflowDefinitionResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowDefinitionResponse([
    void Function(BaseResponseWorkflowDefinitionResponseBuilder)? updates,
  ]) => (BaseResponseWorkflowDefinitionResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseWorkflowDefinitionResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseWorkflowDefinitionResponse rebuild(
    void Function(BaseResponseWorkflowDefinitionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowDefinitionResponseBuilder toBuilder() =>
      BaseResponseWorkflowDefinitionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowDefinitionResponse &&
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
            r'BaseResponseWorkflowDefinitionResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowDefinitionResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowDefinitionResponse,
          BaseResponseWorkflowDefinitionResponseBuilder
        > {
  _$BaseResponseWorkflowDefinitionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowDefinitionResponseBuilder? _data;
  WorkflowDefinitionResponseBuilder get data =>
      _$this._data ??= WorkflowDefinitionResponseBuilder();
  set data(WorkflowDefinitionResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowDefinitionResponseBuilder() {
    BaseResponseWorkflowDefinitionResponse._defaults(this);
  }

  BaseResponseWorkflowDefinitionResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowDefinitionResponse other) {
    _$v = other as _$BaseResponseWorkflowDefinitionResponse;
  }

  @override
  void update(
    void Function(BaseResponseWorkflowDefinitionResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowDefinitionResponse build() => _build();

  _$BaseResponseWorkflowDefinitionResponse _build() {
    _$BaseResponseWorkflowDefinitionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowDefinitionResponse._(
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
          r'BaseResponseWorkflowDefinitionResponse',
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
