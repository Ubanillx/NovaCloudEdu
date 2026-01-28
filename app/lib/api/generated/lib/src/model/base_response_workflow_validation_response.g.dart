// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_validation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowValidationResponse
    extends BaseResponseWorkflowValidationResponse {
  @override
  final int? code;
  @override
  final WorkflowValidationResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowValidationResponse([
    void Function(BaseResponseWorkflowValidationResponseBuilder)? updates,
  ]) => (BaseResponseWorkflowValidationResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseWorkflowValidationResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseWorkflowValidationResponse rebuild(
    void Function(BaseResponseWorkflowValidationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowValidationResponseBuilder toBuilder() =>
      BaseResponseWorkflowValidationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowValidationResponse &&
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
            r'BaseResponseWorkflowValidationResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowValidationResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowValidationResponse,
          BaseResponseWorkflowValidationResponseBuilder
        > {
  _$BaseResponseWorkflowValidationResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowValidationResponseBuilder? _data;
  WorkflowValidationResponseBuilder get data =>
      _$this._data ??= WorkflowValidationResponseBuilder();
  set data(WorkflowValidationResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowValidationResponseBuilder() {
    BaseResponseWorkflowValidationResponse._defaults(this);
  }

  BaseResponseWorkflowValidationResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowValidationResponse other) {
    _$v = other as _$BaseResponseWorkflowValidationResponse;
  }

  @override
  void update(
    void Function(BaseResponseWorkflowValidationResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowValidationResponse build() => _build();

  _$BaseResponseWorkflowValidationResponse _build() {
    _$BaseResponseWorkflowValidationResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowValidationResponse._(
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
          r'BaseResponseWorkflowValidationResponse',
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
