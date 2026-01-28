// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowResponse
    extends BaseResponseListWorkflowResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowResponse([
    void Function(BaseResponseListWorkflowResponseBuilder)? updates,
  ]) => (BaseResponseListWorkflowResponseBuilder()..update(updates))._build();

  _$BaseResponseListWorkflowResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListWorkflowResponse rebuild(
    void Function(BaseResponseListWorkflowResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowResponseBuilder toBuilder() =>
      BaseResponseListWorkflowResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListWorkflowResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowResponse,
          BaseResponseListWorkflowResponseBuilder
        > {
  _$BaseResponseListWorkflowResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowResponse>? _data;
  ListBuilder<WorkflowResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowResponse>();
  set data(ListBuilder<WorkflowResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowResponseBuilder() {
    BaseResponseListWorkflowResponse._defaults(this);
  }

  BaseResponseListWorkflowResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowResponse other) {
    _$v = other as _$BaseResponseListWorkflowResponse;
  }

  @override
  void update(void Function(BaseResponseListWorkflowResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowResponse build() => _build();

  _$BaseResponseListWorkflowResponse _build() {
    _$BaseResponseListWorkflowResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowResponse._(
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
          r'BaseResponseListWorkflowResponse',
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
