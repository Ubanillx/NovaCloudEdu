// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_version_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowVersionResponse
    extends BaseResponseListWorkflowVersionResponse {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowVersionResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowVersionResponse([
    void Function(BaseResponseListWorkflowVersionResponseBuilder)? updates,
  ]) => (BaseResponseListWorkflowVersionResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListWorkflowVersionResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListWorkflowVersionResponse rebuild(
    void Function(BaseResponseListWorkflowVersionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowVersionResponseBuilder toBuilder() =>
      BaseResponseListWorkflowVersionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowVersionResponse &&
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
            r'BaseResponseListWorkflowVersionResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowVersionResponseBuilder
    implements
        Builder<
          BaseResponseListWorkflowVersionResponse,
          BaseResponseListWorkflowVersionResponseBuilder
        > {
  _$BaseResponseListWorkflowVersionResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowVersionResponse>? _data;
  ListBuilder<WorkflowVersionResponse> get data =>
      _$this._data ??= ListBuilder<WorkflowVersionResponse>();
  set data(ListBuilder<WorkflowVersionResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowVersionResponseBuilder() {
    BaseResponseListWorkflowVersionResponse._defaults(this);
  }

  BaseResponseListWorkflowVersionResponseBuilder get _$this {
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
  void replace(BaseResponseListWorkflowVersionResponse other) {
    _$v = other as _$BaseResponseListWorkflowVersionResponse;
  }

  @override
  void update(
    void Function(BaseResponseListWorkflowVersionResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowVersionResponse build() => _build();

  _$BaseResponseListWorkflowVersionResponse _build() {
    _$BaseResponseListWorkflowVersionResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowVersionResponse._(
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
          r'BaseResponseListWorkflowVersionResponse',
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
