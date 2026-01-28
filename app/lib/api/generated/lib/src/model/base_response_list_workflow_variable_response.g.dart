// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_variable_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowVariableResponse
    extends BaseResponseListWorkflowVariableResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowVariableResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowVariableResponse([
    void Function(BaseResponseListWorkflowVariableResponseBuilder)? updates,
  ]) => (BaseResponseListWorkflowVariableResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListWorkflowVariableResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListWorkflowVariableResponse rebuild(
    void Function(BaseResponseListWorkflowVariableResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowVariableResponseBuilder toBuilder() =>
      BaseResponseListWorkflowVariableResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowVariableResponse &&
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
            r'BaseResponseListWorkflowVariableResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowVariableResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowVariableResponse,
          BaseResponseListWorkflowVariableResponseBuilder
        > {
  _$BaseResponseListWorkflowVariableResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowVariableResponse>? _data;
  ListBuilder<WorkflowVariableResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowVariableResponse>();
  set data(ListBuilder<WorkflowVariableResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowVariableResponseBuilder() {
    BaseResponseListWorkflowVariableResponse._defaults(this);
  }

  BaseResponseListWorkflowVariableResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowVariableResponse other) {
    _$v = other as _$BaseResponseListWorkflowVariableResponse;
  }

  @override
  void update(
    void Function(BaseResponseListWorkflowVariableResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowVariableResponse build() => _build();

  _$BaseResponseListWorkflowVariableResponse _build() {
    _$BaseResponseListWorkflowVariableResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowVariableResponse._(
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
          r'BaseResponseListWorkflowVariableResponse',
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
