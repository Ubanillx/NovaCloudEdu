// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_node_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowNodeResponse
    extends BaseResponseWorkflowNodeResponse {
  @override
  final int? code;
  @override
  final WorkflowNodeResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowNodeResponse([
    void Function(BaseResponseWorkflowNodeResponseBuilder)? updates,
  ]) => (BaseResponseWorkflowNodeResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowNodeResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowNodeResponse rebuild(
    void Function(BaseResponseWorkflowNodeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowNodeResponseBuilder toBuilder() =>
      BaseResponseWorkflowNodeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowNodeResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowNodeResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowNodeResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowNodeResponse,
          BaseResponseWorkflowNodeResponseBuilder
        > {
  _$BaseResponseWorkflowNodeResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowNodeResponseBuilder? _data;
  WorkflowNodeResponseBuilder get data =>
      _$this._data ??= WorkflowNodeResponseBuilder();
  set data(WorkflowNodeResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowNodeResponseBuilder() {
    BaseResponseWorkflowNodeResponse._defaults(this);
  }

  BaseResponseWorkflowNodeResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowNodeResponse other) {
    _$v = other as _$BaseResponseWorkflowNodeResponse;
  }

  @override
  void update(void Function(BaseResponseWorkflowNodeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowNodeResponse build() => _build();

  _$BaseResponseWorkflowNodeResponse _build() {
    _$BaseResponseWorkflowNodeResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowNodeResponse._(
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
          r'BaseResponseWorkflowNodeResponse',
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
