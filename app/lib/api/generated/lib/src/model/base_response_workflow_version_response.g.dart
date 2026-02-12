// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_version_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowVersionResponse
    extends BaseResponseWorkflowVersionResponse {
  @override
  final int? code;
  @override
  final WorkflowVersionResponse? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowVersionResponse([
    void Function(BaseResponseWorkflowVersionResponseBuilder)? updates,
  ]) =>
      (BaseResponseWorkflowVersionResponseBuilder()..update(updates))._build();

  _$BaseResponseWorkflowVersionResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowVersionResponse rebuild(
    void Function(BaseResponseWorkflowVersionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowVersionResponseBuilder toBuilder() =>
      BaseResponseWorkflowVersionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowVersionResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowVersionResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowVersionResponseBuilder
    implements
        Builder<
          BaseResponseWorkflowVersionResponse,
          BaseResponseWorkflowVersionResponseBuilder
        > {
  _$BaseResponseWorkflowVersionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowVersionResponseBuilder? _data;
  WorkflowVersionResponseBuilder get data =>
      _$this._data ??= WorkflowVersionResponseBuilder();
  set data(WorkflowVersionResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowVersionResponseBuilder() {
    BaseResponseWorkflowVersionResponse._defaults(this);
  }

  BaseResponseWorkflowVersionResponseBuilder get _$this {
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
  void replace(BaseResponseWorkflowVersionResponse other) {
    _$v = other as _$BaseResponseWorkflowVersionResponse;
  }

  @override
  void update(
    void Function(BaseResponseWorkflowVersionResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowVersionResponse build() => _build();

  _$BaseResponseWorkflowVersionResponse _build() {
    _$BaseResponseWorkflowVersionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowVersionResponse._(
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
          r'BaseResponseWorkflowVersionResponse',
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
