// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_template_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowTemplateResponse
    extends BaseResponseListWorkflowTemplateResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowTemplateResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowTemplateResponse([
    void Function(BaseResponseListWorkflowTemplateResponseBuilder)? updates,
  ]) => (BaseResponseListWorkflowTemplateResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListWorkflowTemplateResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListWorkflowTemplateResponse rebuild(
    void Function(BaseResponseListWorkflowTemplateResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowTemplateResponseBuilder toBuilder() =>
      BaseResponseListWorkflowTemplateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowTemplateResponse &&
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
            r'BaseResponseListWorkflowTemplateResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowTemplateResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowTemplateResponse,
          BaseResponseListWorkflowTemplateResponseBuilder
        > {
  _$BaseResponseListWorkflowTemplateResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowTemplateResponse>? _data;
  ListBuilder<WorkflowTemplateResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowTemplateResponse>();
  set data(ListBuilder<WorkflowTemplateResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowTemplateResponseBuilder() {
    BaseResponseListWorkflowTemplateResponse._defaults(this);
  }

  BaseResponseListWorkflowTemplateResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowTemplateResponse other) {
    _$v = other as _$BaseResponseListWorkflowTemplateResponse;
  }

  @override
  void update(
    void Function(BaseResponseListWorkflowTemplateResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowTemplateResponse build() => _build();

  _$BaseResponseListWorkflowTemplateResponse _build() {
    _$BaseResponseListWorkflowTemplateResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowTemplateResponse._(
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
          r'BaseResponseListWorkflowTemplateResponse',
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
