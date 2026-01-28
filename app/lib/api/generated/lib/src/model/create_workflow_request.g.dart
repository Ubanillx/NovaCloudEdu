// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_workflow_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateWorkflowRequest extends CreateWorkflowRequest {
  @override
  final int userId;
  @override
  final String name;
  @override
  final String? description;

  factory _$CreateWorkflowRequest([
    void Function(CreateWorkflowRequestBuilder)? updates,
  ]) => (CreateWorkflowRequestBuilder()..update(updates))._build();

  _$CreateWorkflowRequest._({
    required this.userId,
    required this.name,
    this.description,
  }) : super._();
  @override
  CreateWorkflowRequest rebuild(
    void Function(CreateWorkflowRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateWorkflowRequestBuilder toBuilder() =>
      CreateWorkflowRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateWorkflowRequest &&
        userId == other.userId &&
        name == other.name &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateWorkflowRequest')
          ..add('userId', userId)
          ..add('name', name)
          ..add('description', description))
        .toString();
  }
}

class CreateWorkflowRequestBuilder
    implements Builder<CreateWorkflowRequest, CreateWorkflowRequestBuilder> {
  _$CreateWorkflowRequest? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CreateWorkflowRequestBuilder() {
    CreateWorkflowRequest._defaults(this);
  }

  CreateWorkflowRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _name = $v.name;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateWorkflowRequest other) {
    _$v = other as _$CreateWorkflowRequest;
  }

  @override
  void update(void Function(CreateWorkflowRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateWorkflowRequest build() => _build();

  _$CreateWorkflowRequest _build() {
    final _$result =
        _$v ??
        _$CreateWorkflowRequest._(
          userId: BuiltValueNullFieldError.checkNotNull(
            userId,
            r'CreateWorkflowRequest',
            'userId',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreateWorkflowRequest',
            'name',
          ),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
