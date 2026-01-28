// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_variable_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowVariableResponse
    extends BaseResponseWorkflowVariableResponse {
  @override
  final int? code;
  @override
  final WorkflowVariableResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowVariableResponse([
    void Function(BaseResponseWorkflowVariableResponseBuilder)? updates,
  ]) =>
      (BaseResponseWorkflowVariableResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowVariableResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowVariableResponse rebuild(
    void Function(BaseResponseWorkflowVariableResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowVariableResponseBuilder toBuilder() =>
      BaseResponseWorkflowVariableResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowVariableResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowVariableResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowVariableResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowVariableResponse,
          BaseResponseWorkflowVariableResponseBuilder
        > {
  _$BaseResponseWorkflowVariableResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowVariableResponseBuilder? _data;
  WorkflowVariableResponseBuilder get data =>
      _$this._data ??= WorkflowVariableResponseBuilder();
  set data(WorkflowVariableResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowVariableResponseBuilder() {
    BaseResponseWorkflowVariableResponse._defaults(this);
  }

  BaseResponseWorkflowVariableResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowVariableResponse other) {
    _$v = other as _$BaseResponseWorkflowVariableResponse;
  }

  @override
  void update(
    void Function(BaseResponseWorkflowVariableResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowVariableResponse build() => _build();

  _$BaseResponseWorkflowVariableResponse _build() {
    _$BaseResponseWorkflowVariableResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowVariableResponse._(
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
          r'BaseResponseWorkflowVariableResponse',
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
