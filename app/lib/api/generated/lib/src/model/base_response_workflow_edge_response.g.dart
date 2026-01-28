// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_edge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowEdgeResponse
    extends BaseResponseWorkflowEdgeResponse {
  @override
  final int? code;
  @override
  final WorkflowEdgeResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowEdgeResponse([
    void Function(BaseResponseWorkflowEdgeResponseBuilder)? updates,
  ]) => (BaseResponseWorkflowEdgeResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowEdgeResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowEdgeResponse rebuild(
    void Function(BaseResponseWorkflowEdgeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowEdgeResponseBuilder toBuilder() =>
      BaseResponseWorkflowEdgeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowEdgeResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowEdgeResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowEdgeResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowEdgeResponse,
          BaseResponseWorkflowEdgeResponseBuilder
        > {
  _$BaseResponseWorkflowEdgeResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowEdgeResponseBuilder? _data;
  WorkflowEdgeResponseBuilder get data =>
      _$this._data ??= WorkflowEdgeResponseBuilder();
  set data(WorkflowEdgeResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowEdgeResponseBuilder() {
    BaseResponseWorkflowEdgeResponse._defaults(this);
  }

  BaseResponseWorkflowEdgeResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowEdgeResponse other) {
    _$v = other as _$BaseResponseWorkflowEdgeResponse;
  }

  @override
  void update(void Function(BaseResponseWorkflowEdgeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowEdgeResponse build() => _build();

  _$BaseResponseWorkflowEdgeResponse _build() {
    _$BaseResponseWorkflowEdgeResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowEdgeResponse._(
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
          r'BaseResponseWorkflowEdgeResponse',
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
