// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_workflow_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateWorkflowRequest extends UpdateWorkflowRequest {
  @override
  final String? name;
  @override
  final String? description;

  factory _$UpdateWorkflowRequest([
    void Function(UpdateWorkflowRequestBuilder)? updates,
  ]) => (UpdateWorkflowRequestBuilder()..update(updates))._build();

  _$UpdateWorkflowRequest._({this.name, this.description}) : super._();
  @override
  UpdateWorkflowRequest rebuild(
    void Function(UpdateWorkflowRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateWorkflowRequestBuilder toBuilder() =>
      UpdateWorkflowRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateWorkflowRequest &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateWorkflowRequest')
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class UpdateWorkflowRequestBuilder
    implements Builder<UpdateWorkflowRequest, UpdateWorkflowRequestBuilder> {
  _$UpdateWorkflowRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UpdateWorkflowRequestBuilder() {
    UpdateWorkflowRequest._defaults(this);
  }

  UpdateWorkflowRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateWorkflowRequest other) {
    _$v = other as _$UpdateWorkflowRequest;
  }

  @override
  void update(void Function(UpdateWorkflowRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateWorkflowRequest build() => _build();

  _$UpdateWorkflowRequest _build() {
    final _$result =
        _$v ?? _$UpdateWorkflowRequest._(name: name, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
