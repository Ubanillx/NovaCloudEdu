// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_knowledge_base_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateKnowledgeBaseCommand extends UpdateKnowledgeBaseCommand {
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? chunkSize;
  @override
  final int? chunkOverlap;

  factory _$UpdateKnowledgeBaseCommand([
    void Function(UpdateKnowledgeBaseCommandBuilder)? updates,
  ]) => (UpdateKnowledgeBaseCommandBuilder()..update(updates))._build();

  _$UpdateKnowledgeBaseCommand._({
    this.name,
    this.description,
    this.chunkSize,
    this.chunkOverlap,
  }) : super._();
  @override
  UpdateKnowledgeBaseCommand rebuild(
    void Function(UpdateKnowledgeBaseCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateKnowledgeBaseCommandBuilder toBuilder() =>
      UpdateKnowledgeBaseCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateKnowledgeBaseCommand &&
        name == other.name &&
        description == other.description &&
        chunkSize == other.chunkSize &&
        chunkOverlap == other.chunkOverlap;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, chunkSize.hashCode);
    _$hash = $jc(_$hash, chunkOverlap.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateKnowledgeBaseCommand')
          ..add('name', name)
          ..add('description', description)
          ..add('chunkSize', chunkSize)
          ..add('chunkOverlap', chunkOverlap))
        .toString();
  }
}

class UpdateKnowledgeBaseCommandBuilder
    implements
        Builder<UpdateKnowledgeBaseCommand, UpdateKnowledgeBaseCommandBuilder> {
  _$UpdateKnowledgeBaseCommand? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _chunkSize;
  int? get chunkSize => _$this._chunkSize;
  set chunkSize(int? chunkSize) => _$this._chunkSize = chunkSize;

  int? _chunkOverlap;
  int? get chunkOverlap => _$this._chunkOverlap;
  set chunkOverlap(int? chunkOverlap) => _$this._chunkOverlap = chunkOverlap;

  UpdateKnowledgeBaseCommandBuilder() {
    UpdateKnowledgeBaseCommand._defaults(this);
  }

  UpdateKnowledgeBaseCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _chunkSize = $v.chunkSize;
      _chunkOverlap = $v.chunkOverlap;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateKnowledgeBaseCommand other) {
    _$v = other as _$UpdateKnowledgeBaseCommand;
  }

  @override
  void update(void Function(UpdateKnowledgeBaseCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateKnowledgeBaseCommand build() => _build();

  _$UpdateKnowledgeBaseCommand _build() {
    final _$result =
        _$v ??
        _$UpdateKnowledgeBaseCommand._(
          name: name,
          description: description,
          chunkSize: chunkSize,
          chunkOverlap: chunkOverlap,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
