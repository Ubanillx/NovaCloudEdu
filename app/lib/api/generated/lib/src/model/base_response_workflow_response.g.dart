// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowResponse extends BaseResponseWorkflowResponse {
  @override
  final int? code;
  @override
  final WorkflowResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowResponse([
    void Function(BaseResponseWorkflowResponseBuilder)? updates,
  ]) => (BaseResponseWorkflowResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowResponse rebuild(
    void Function(BaseResponseWorkflowResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowResponseBuilder toBuilder() =>
      BaseResponseWorkflowResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowResponse,
          BaseResponseWorkflowResponseBuilder
        > {
  _$BaseResponseWorkflowResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowResponseBuilder? _data;
  WorkflowResponseBuilder get data =>
      _$this._data ??= WorkflowResponseBuilder();
  set data(WorkflowResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowResponseBuilder() {
    BaseResponseWorkflowResponse._defaults(this);
  }

  BaseResponseWorkflowResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowResponse other) {
    _$v = other as _$BaseResponseWorkflowResponse;
  }

  @override
  void update(void Function(BaseResponseWorkflowResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowResponse build() => _build();

  _$BaseResponseWorkflowResponse _build() {
    _$BaseResponseWorkflowResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowResponse._(
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
          r'BaseResponseWorkflowResponse',
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
