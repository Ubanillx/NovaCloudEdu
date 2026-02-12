// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_skill_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkflowSkillVO extends WorkflowSkillVO {
  @override
  final int? workflowId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? status;
  @override
  final BuiltList<SkillParamVO>? inputParameters;
  @override
  final BuiltList<SkillOutputVO>? outputVariables;

  factory _$WorkflowSkillVO([void Function(WorkflowSkillVOBuilder)? updates]) =>
      (WorkflowSkillVOBuilder()..update(updates))._build();

  _$WorkflowSkillVO._({
    this.workflowId,
    this.name,
    this.description,
    this.status,
    this.inputParameters,
    this.outputVariables,
  }) : super._();
  @override
  WorkflowSkillVO rebuild(void Function(WorkflowSkillVOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkflowSkillVOBuilder toBuilder() => WorkflowSkillVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkflowSkillVO &&
        workflowId == other.workflowId &&
        name == other.name &&
        description == other.description &&
        status == other.status &&
        inputParameters == other.inputParameters &&
        outputVariables == other.outputVariables;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, workflowId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, inputParameters.hashCode);
    _$hash = $jc(_$hash, outputVariables.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WorkflowSkillVO')
          ..add('workflowId', workflowId)
          ..add('name', name)
          ..add('description', description)
          ..add('status', status)
          ..add('inputParameters', inputParameters)
          ..add('outputVariables', outputVariables))
        .toString();
  }
}

class WorkflowSkillVOBuilder
    implements Builder<WorkflowSkillVO, WorkflowSkillVOBuilder> {
  _$WorkflowSkillVO? _$v;

  int? _workflowId;
  int? get workflowId => _$this._workflowId;
  set workflowId(int? workflowId) => _$this._workflowId = workflowId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  ListBuilder<SkillParamVO>? _inputParameters;
  ListBuilder<SkillParamVO> get inputParameters =>
      _$this._inputParameters ??= ListBuilder<SkillParamVO>();
  set inputParameters(ListBuilder<SkillParamVO>? inputParameters) =>
      _$this._inputParameters = inputParameters;

  ListBuilder<SkillOutputVO>? _outputVariables;
  ListBuilder<SkillOutputVO> get outputVariables =>
      _$this._outputVariables ??= ListBuilder<SkillOutputVO>();
  set outputVariables(ListBuilder<SkillOutputVO>? outputVariables) =>
      _$this._outputVariables = outputVariables;

  WorkflowSkillVOBuilder() {
    WorkflowSkillVO._defaults(this);
  }

  WorkflowSkillVOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _workflowId = $v.workflowId;
      _name = $v.name;
      _description = $v.description;
      _status = $v.status;
      _inputParameters = $v.inputParameters?.toBuilder();
      _outputVariables = $v.outputVariables?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkflowSkillVO other) {
    _$v = other as _$WorkflowSkillVO;
  }

  @override
  void update(void Function(WorkflowSkillVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WorkflowSkillVO build() => _build();

  _$WorkflowSkillVO _build() {
    _$WorkflowSkillVO _$result;
    try {
      _$result =
          _$v ??
          _$WorkflowSkillVO._(
            workflowId: workflowId,
            name: name,
            description: description,
            status: status,
            inputParameters: _inputParameters?.build(),
            outputVariables: _outputVariables?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'inputParameters';
        _inputParameters?.build();
        _$failedField = 'outputVariables';
        _outputVariables?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WorkflowSkillVO',
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
