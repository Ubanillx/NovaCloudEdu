// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_template_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowTemplateResponse
    extends BaseResponseWorkflowTemplateResponse {
  @override
  final int? code;
  @override
  final WorkflowTemplateResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowTemplateResponse([
    void Function(BaseResponseWorkflowTemplateResponseBuilder)? updates,
  ]) =>
      (BaseResponseWorkflowTemplateResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowTemplateResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowTemplateResponse rebuild(
    void Function(BaseResponseWorkflowTemplateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowTemplateResponseBuilder toBuilder() =>
      BaseResponseWorkflowTemplateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowTemplateResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowTemplateResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowTemplateResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowTemplateResponse,
          BaseResponseWorkflowTemplateResponseBuilder
        > {
  _$BaseResponseWorkflowTemplateResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowTemplateResponseBuilder? _data;
  WorkflowTemplateResponseBuilder get data =>
      _$this._data ??= WorkflowTemplateResponseBuilder();
  set data(WorkflowTemplateResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowTemplateResponseBuilder() {
    BaseResponseWorkflowTemplateResponse._defaults(this);
  }

  BaseResponseWorkflowTemplateResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowTemplateResponse other) {
    _$v = other as _$BaseResponseWorkflowTemplateResponse;
  }

  @override
  void update(
    void Function(BaseResponseWorkflowTemplateResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowTemplateResponse build() => _build();

  _$BaseResponseWorkflowTemplateResponse _build() {
    _$BaseResponseWorkflowTemplateResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowTemplateResponse._(
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
          r'BaseResponseWorkflowTemplateResponse',
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
