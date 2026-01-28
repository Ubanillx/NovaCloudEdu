// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_validation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowValidationResponse extends WorkflowValidationResponse {
  @override
  final bool? valid;
  @override
  final BuiltList<ValidationErrorDTO>? errors;
  @override
  final BuiltList<ValidationWarningDTO>? warnings;

  factory _$WorkflowValidationResponse([
    void Function(WorkflowValidationResponseBuilder)? updates,
  ]) => (WorkflowValidationResponseBuilder()..update(updates))._build();

  _$WorkflowValidationResponse._({this.valid, this.errors, this.warnings})
    : super._();
  @override
  WorkflowValidationResponse rebuild(
    void Function(WorkflowValidationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WorkflowValidationResponseBuilder toBuilder() =>
      WorkflowValidationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowValidationResponse &&
        valid == other.valid &&
        errors == other.errors &&
        warnings == other.warnings;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, valid.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowValidationResponse')
          ..add('valid', valid)
          ..add('errors', errors)
          ..add('warnings', warnings))
        .toString();
  }
}

class WorkflowValidationResponseBuilder
    implements
        Builder<WorkflowValidationResponse, WorkflowValidationResponseBuilder> {
  _$WorkflowValidationResponse? _$v;

  bool? _valid;
  bool? get valid => _$this._valid;
  set valid(bool? valid) => _$this._valid = valid;

  ListBuilder<ValidationErrorDTO>? _errors;
  ListBuilder<ValidationErrorDTO> get errors =>
      _$this._errors ??= ListBuilder<ValidationErrorDTO>();
  set errors(ListBuilder<ValidationErrorDTO>? errors) =>
      _$this._errors = errors;

  ListBuilder<ValidationWarningDTO>? _warnings;
  ListBuilder<ValidationWarningDTO> get warnings =>
      _$this._warnings ??= ListBuilder<ValidationWarningDTO>();
  set warnings(ListBuilder<ValidationWarningDTO>? warnings) =>
      _$this._warnings = warnings;

  WorkflowValidationResponseBuilder() {
    WorkflowValidationResponse._defaults(this);
  }

  WorkflowValidationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _valid = $v.valid;
      _errors = $v.errors?.toBuilder();
      _warnings = $v.warnings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowValidationResponse other) {
    _$v = other as _$WorkflowValidationResponse;
  }

  @override
  void update(void Function(WorkflowValidationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowValidationResponse build() => _build();

  _$WorkflowValidationResponse _build() {
    _$WorkflowValidationResponse _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowValidationResponse._(
            valid: valid,
            errors: _errors?.build(),
            warnings: _warnings?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
        _$failedField = 'warnings';
        _warnings?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WorkflowValidationResponse',
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
