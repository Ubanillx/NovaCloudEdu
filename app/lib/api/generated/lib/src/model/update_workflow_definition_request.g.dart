// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_workflow_definition_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateWorkflowDefinitionRequest
    extends UpdateWorkflowDefinitionRequest {
  @override
  final WorkflowDefinition definition;

  factory _$UpdateWorkflowDefinitionRequest([
    void Function(UpdateWorkflowDefinitionRequestBuilder)? updates,
  ]) => (UpdateWorkflowDefinitionRequestBuilder()..update(updates))._build();

  _$UpdateWorkflowDefinitionRequest._({required this.definition}) : super._();
  @override
  UpdateWorkflowDefinitionRequest rebuild(
    void Function(UpdateWorkflowDefinitionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateWorkflowDefinitionRequestBuilder toBuilder() =>
      UpdateWorkflowDefinitionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateWorkflowDefinitionRequest &&
        definition == other.definition;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, definition.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UpdateWorkflowDefinitionRequest',
    )..add('definition', definition)).toString();
  }
}

class UpdateWorkflowDefinitionRequestBuilder
    implements
        Builder<
          UpdateWorkflowDefinitionRequest,
          UpdateWorkflowDefinitionRequestBuilder
        > {
  _$UpdateWorkflowDefinitionRequest? _$v;

  WorkflowDefinitionBuilder? _definition;
  WorkflowDefinitionBuilder get definition =>
      _$this._definition ??= WorkflowDefinitionBuilder();
  set definition(WorkflowDefinitionBuilder? definition) =>
      _$this._definition = definition;

  UpdateWorkflowDefinitionRequestBuilder() {
    UpdateWorkflowDefinitionRequest._defaults(this);
  }

  UpdateWorkflowDefinitionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _definition = $v.definition.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateWorkflowDefinitionRequest other) {
    _$v = other as _$UpdateWorkflowDefinitionRequest;
  }

  @override
  void update(void Function(UpdateWorkflowDefinitionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateWorkflowDefinitionRequest build() => _build();

  _$UpdateWorkflowDefinitionRequest _build() {
    _$UpdateWorkflowDefinitionRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateWorkflowDefinitionRequest._(definition: definition.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'definition';
        definition.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateWorkflowDefinitionRequest',
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
