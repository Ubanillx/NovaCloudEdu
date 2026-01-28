// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_base_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KnowledgeBaseVO extends KnowledgeBaseVO {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? embeddingModel;
  @override
  final int? embeddingDimension;
  @override
  final int? chunkSize;
  @override
  final int? chunkOverlap;
  @override
  final int? documentCount;
  @override
  final int? chunkCount;
  @override
  final String? status;
  @override
  final int? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$KnowledgeBaseVO([void Function(KnowledgeBaseVOBuilder)? updates]) =>
      (KnowledgeBaseVOBuilder()..update(updates))._build();

  _$KnowledgeBaseVO._({
    this.id,
    this.name,
    this.description,
    this.embeddingModel,
    this.embeddingDimension,
    this.chunkSize,
    this.chunkOverlap,
    this.documentCount,
    this.chunkCount,
    this.status,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  KnowledgeBaseVO rebuild(void Function(KnowledgeBaseVOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnowledgeBaseVOBuilder toBuilder() => KnowledgeBaseVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnowledgeBaseVO &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        embeddingModel == other.embeddingModel &&
        embeddingDimension == other.embeddingDimension &&
        chunkSize == other.chunkSize &&
        chunkOverlap == other.chunkOverlap &&
        documentCount == other.documentCount &&
        chunkCount == other.chunkCount &&
        status == other.status &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, embeddingModel.hashCode);
    _$hash = $jc(_$hash, embeddingDimension.hashCode);
    _$hash = $jc(_$hash, chunkSize.hashCode);
    _$hash = $jc(_$hash, chunkOverlap.hashCode);
    _$hash = $jc(_$hash, documentCount.hashCode);
    _$hash = $jc(_$hash, chunkCount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnowledgeBaseVO')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('embeddingModel', embeddingModel)
          ..add('embeddingDimension', embeddingDimension)
          ..add('chunkSize', chunkSize)
          ..add('chunkOverlap', chunkOverlap)
          ..add('documentCount', documentCount)
          ..add('chunkCount', chunkCount)
          ..add('status', status)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class KnowledgeBaseVOBuilder
    implements Builder<KnowledgeBaseVO, KnowledgeBaseVOBuilder> {
  _$KnowledgeBaseVO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _embeddingModel;
  String? get embeddingModel => _$this._embeddingModel;
  set embeddingModel(String? embeddingModel) =>
      _$this._embeddingModel = embeddingModel;

  int? _embeddingDimension;
  int? get embeddingDimension => _$this._embeddingDimension;
  set embeddingDimension(int? embeddingDimension) =>
      _$this._embeddingDimension = embeddingDimension;

  int? _chunkSize;
  int? get chunkSize => _$this._chunkSize;
  set chunkSize(int? chunkSize) => _$this._chunkSize = chunkSize;

  int? _chunkOverlap;
  int? get chunkOverlap => _$this._chunkOverlap;
  set chunkOverlap(int? chunkOverlap) => _$this._chunkOverlap = chunkOverlap;

  int? _documentCount;
  int? get documentCount => _$this._documentCount;
  set documentCount(int? documentCount) =>
      _$this._documentCount = documentCount;

  int? _chunkCount;
  int? get chunkCount => _$this._chunkCount;
  set chunkCount(int? chunkCount) => _$this._chunkCount = chunkCount;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  KnowledgeBaseVOBuilder() {
    KnowledgeBaseVO._defaults(this);
  }

  KnowledgeBaseVOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _embeddingModel = $v.embeddingModel;
      _embeddingDimension = $v.embeddingDimension;
      _chunkSize = $v.chunkSize;
      _chunkOverlap = $v.chunkOverlap;
      _documentCount = $v.documentCount;
      _chunkCount = $v.chunkCount;
      _status = $v.status;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnowledgeBaseVO other) {
    _$v = other as _$KnowledgeBaseVO;
  }

  @override
  void update(void Function(KnowledgeBaseVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnowledgeBaseVO build() => _build();

  _$KnowledgeBaseVO _build() {
    final _$result =
        _$v ??
        _$KnowledgeBaseVO._(
          id: id,
          name: name,
          description: description,
          embeddingModel: embeddingModel,
          embeddingDimension: embeddingDimension,
          chunkSize: chunkSize,
          chunkOverlap: chunkOverlap,
          documentCount: documentCount,
          chunkCount: chunkCount,
          status: status,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
