// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_node_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowNodeResponse
    extends BaseResponseListWorkflowNodeResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowNodeResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowNodeResponse([
    void Function(BaseResponseListWorkflowNodeResponseBuilder)? updates,
  ]) =>
      (BaseResponseListWorkflowNodeResponseBuilder()..update(updates))._build();

  _$BaseResponseListWorkflowNodeResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListWorkflowNodeResponse rebuild(
    void Function(BaseResponseListWorkflowNodeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowNodeResponseBuilder toBuilder() =>
      BaseResponseListWorkflowNodeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowNodeResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListWorkflowNodeResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowNodeResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowNodeResponse,
          BaseResponseListWorkflowNodeResponseBuilder
        > {
  _$BaseResponseListWorkflowNodeResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowNodeResponse>? _data;
  ListBuilder<WorkflowNodeResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowNodeResponse>();
  set data(ListBuilder<WorkflowNodeResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowNodeResponseBuilder() {
    BaseResponseListWorkflowNodeResponse._defaults(this);
  }

  BaseResponseListWorkflowNodeResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowNodeResponse other) {
    _$v = other as _$BaseResponseListWorkflowNodeResponse;
  }

  @override
  void update(
    void Function(BaseResponseListWorkflowNodeResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowNodeResponse build() => _build();

  _$BaseResponseListWorkflowNodeResponse _build() {
    _$BaseResponseListWorkflowNodeResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowNodeResponse._(
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
          r'BaseResponseListWorkflowNodeResponse',
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
