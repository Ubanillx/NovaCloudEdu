// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_edge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowEdgeResponse
    extends BaseResponseListWorkflowEdgeResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowEdgeResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowEdgeResponse([
    void Function(BaseResponseListWorkflowEdgeResponseBuilder)? updates,
  ]) =>
      (BaseResponseListWorkflowEdgeResponseBuilder()..update(updates))._build();

  _$BaseResponseListWorkflowEdgeResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListWorkflowEdgeResponse rebuild(
    void Function(BaseResponseListWorkflowEdgeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowEdgeResponseBuilder toBuilder() =>
      BaseResponseListWorkflowEdgeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowEdgeResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListWorkflowEdgeResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowEdgeResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowEdgeResponse,
          BaseResponseListWorkflowEdgeResponseBuilder
        > {
  _$BaseResponseListWorkflowEdgeResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowEdgeResponse>? _data;
  ListBuilder<WorkflowEdgeResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowEdgeResponse>();
  set data(ListBuilder<WorkflowEdgeResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowEdgeResponseBuilder() {
    BaseResponseListWorkflowEdgeResponse._defaults(this);
  }

  BaseResponseListWorkflowEdgeResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowEdgeResponse other) {
    _$v = other as _$BaseResponseListWorkflowEdgeResponse;
  }

  @override
  void update(
    void Function(BaseResponseListWorkflowEdgeResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowEdgeResponse build() => _build();

  _$BaseResponseListWorkflowEdgeResponse _build() {
    _$BaseResponseListWorkflowEdgeResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowEdgeResponse._(
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
          r'BaseResponseListWorkflowEdgeResponse',
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
