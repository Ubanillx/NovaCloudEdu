// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_trigger_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowTriggerResponse
    extends BaseResponseListWorkflowTriggerResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowTriggerResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowTriggerResponse([
    void Function(BaseResponseListWorkflowTriggerResponseBuilder)? updates,
  ]) => (BaseResponseListWorkflowTriggerResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListWorkflowTriggerResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListWorkflowTriggerResponse rebuild(
    void Function(BaseResponseListWorkflowTriggerResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowTriggerResponseBuilder toBuilder() =>
      BaseResponseListWorkflowTriggerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowTriggerResponse &&
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
            r'BaseResponseListWorkflowTriggerResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowTriggerResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowTriggerResponse,
          BaseResponseListWorkflowTriggerResponseBuilder
        > {
  _$BaseResponseListWorkflowTriggerResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowTriggerResponse>? _data;
  ListBuilder<WorkflowTriggerResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowTriggerResponse>();
  set data(ListBuilder<WorkflowTriggerResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowTriggerResponseBuilder() {
    BaseResponseListWorkflowTriggerResponse._defaults(this);
  }

  BaseResponseListWorkflowTriggerResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowTriggerResponse other) {
    _$v = other as _$BaseResponseListWorkflowTriggerResponse;
  }

  @override
  void update(
    void Function(BaseResponseListWorkflowTriggerResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowTriggerResponse build() => _build();

  _$BaseResponseListWorkflowTriggerResponse _build() {
    _$BaseResponseListWorkflowTriggerResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowTriggerResponse._(
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
          r'BaseResponseListWorkflowTriggerResponse',
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
