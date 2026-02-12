// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_definition.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChildrenDefinition extends ChildrenDefinition {
  @override
  final BuiltList<WorkflowEdge>? edges;

  factory _$ChildrenDefinition([
    void Function(ChildrenDefinitionBuilder)? updates,
  ]) => (ChildrenDefinitionBuilder()..update(updates))._build();

  _$ChildrenDefinition._({this.edges}) : super._();
  @override
  ChildrenDefinition rebuild(
    void Function(ChildrenDefinitionBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChildrenDefinitionBuilder toBuilder() =>
      ChildrenDefinitionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChildrenDefinition && edges == other.edges;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, edges.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ChildrenDefinition',
    )..add('edges', edges)).toString();
  }
}

class ChildrenDefinitionBuilder
    implements Builder<ChildrenDefinition, ChildrenDefinitionBuilder> {
  _$ChildrenDefinition? _$v;

  ListBuilder<WorkflowEdge>? _edges;
  ListBuilder<WorkflowEdge> get edges =>
      _$this._edges ??= ListBuilder<WorkflowEdge>();
  set edges(ListBuilder<WorkflowEdge>? edges) => _$this._edges = edges;

  ChildrenDefinitionBuilder() {
    ChildrenDefinition._defaults(this);
  }

  ChildrenDefinitionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _edges = $v.edges?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChildrenDefinition other) {
    _$v = other as _$ChildrenDefinition;
  }

  @override
  void update(void Function(ChildrenDefinitionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChildrenDefinition build() => _build();

  _$ChildrenDefinition _build() {
    _$ChildrenDefinition _$result;
    try {
      _$result = _$v ?? _$ChildrenDefinition._(edges: _edges?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'edges';
        _edges?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChildrenDefinition',
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
