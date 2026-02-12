// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_trigger_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowTriggerResponse
    extends BaseResponseWorkflowTriggerResponse {
  @override
  final int? code;
  @override
  final WorkflowTriggerResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowTriggerResponse([
    void Function(BaseResponseWorkflowTriggerResponseBuilder)? updates,
  ]) =>
      (BaseResponseWorkflowTriggerResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowTriggerResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowTriggerResponse rebuild(
    void Function(BaseResponseWorkflowTriggerResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowTriggerResponseBuilder toBuilder() =>
      BaseResponseWorkflowTriggerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowTriggerResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowTriggerResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowTriggerResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowTriggerResponse,
          BaseResponseWorkflowTriggerResponseBuilder
        > {
  _$BaseResponseWorkflowTriggerResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowTriggerResponseBuilder? _data;
  WorkflowTriggerResponseBuilder get data =>
      _$this._data ??= WorkflowTriggerResponseBuilder();
  set data(WorkflowTriggerResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowTriggerResponseBuilder() {
    BaseResponseWorkflowTriggerResponse._defaults(this);
  }

  BaseResponseWorkflowTriggerResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowTriggerResponse other) {
    _$v = other as _$BaseResponseWorkflowTriggerResponse;
  }

  @override
  void update(
    void Function(BaseResponseWorkflowTriggerResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowTriggerResponse build() => _build();

  _$BaseResponseWorkflowTriggerResponse _build() {
    _$BaseResponseWorkflowTriggerResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowTriggerResponse._(
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
          r'BaseResponseWorkflowTriggerResponse',
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
