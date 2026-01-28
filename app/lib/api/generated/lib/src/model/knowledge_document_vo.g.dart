// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_document_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KnowledgeDocumentVO extends KnowledgeDocumentVO {
  @override
  final int? id;
  @override
  final int? knowledgeBaseId;
  @override
  final String? name;
  @override
  final String? fileType;
  @override
  final String? fileUrl;
  @override
  final int? fileSize;
  @override
  final int? chunkCount;
  @override
  final String? status;
  @override
  final String? errorMessage;
  @override
  final int? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$KnowledgeDocumentVO([
    void Function(KnowledgeDocumentVOBuilder)? updates,
  ]) => (KnowledgeDocumentVOBuilder()..update(updates))._build();

  _$KnowledgeDocumentVO._({
    this.id,
    this.knowledgeBaseId,
    this.name,
    this.fileType,
    this.fileUrl,
    this.fileSize,
    this.chunkCount,
    this.status,
    this.errorMessage,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  KnowledgeDocumentVO rebuild(
    void Function(KnowledgeDocumentVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  KnowledgeDocumentVOBuilder toBuilder() =>
      KnowledgeDocumentVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnowledgeDocumentVO &&
        id == other.id &&
        knowledgeBaseId == other.knowledgeBaseId &&
        name == other.name &&
        fileType == other.fileType &&
        fileUrl == other.fileUrl &&
        fileSize == other.fileSize &&
        chunkCount == other.chunkCount &&
        status == other.status &&
        errorMessage == other.errorMessage &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, knowledgeBaseId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jc(_$hash, fileUrl.hashCode);
    _$hash = $jc(_$hash, fileSize.hashCode);
    _$hash = $jc(_$hash, chunkCount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, errorMessage.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnowledgeDocumentVO')
          ..add('id', id)
          ..add('knowledgeBaseId', knowledgeBaseId)
          ..add('name', name)
          ..add('fileType', fileType)
          ..add('fileUrl', fileUrl)
          ..add('fileSize', fileSize)
          ..add('chunkCount', chunkCount)
          ..add('status', status)
          ..add('errorMessage', errorMessage)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class KnowledgeDocumentVOBuilder
    implements Builder<KnowledgeDocumentVO, KnowledgeDocumentVOBuilder> {
  _$KnowledgeDocumentVO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _knowledgeBaseId;
  int? get knowledgeBaseId => _$this._knowledgeBaseId;
  set knowledgeBaseId(int? knowledgeBaseId) =>
      _$this._knowledgeBaseId = knowledgeBaseId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  String? _fileUrl;
  String? get fileUrl => _$this._fileUrl;
  set fileUrl(String? fileUrl) => _$this._fileUrl = fileUrl;

  int? _fileSize;
  int? get fileSize => _$this._fileSize;
  set fileSize(int? fileSize) => _$this._fileSize = fileSize;

  int? _chunkCount;
  int? get chunkCount => _$this._chunkCount;
  set chunkCount(int? chunkCount) => _$this._chunkCount = chunkCount;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _errorMessage;
  String? get errorMessage => _$this._errorMessage;
  set errorMessage(String? errorMessage) => _$this._errorMessage = errorMessage;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  KnowledgeDocumentVOBuilder() {
    KnowledgeDocumentVO._defaults(this);
  }

  KnowledgeDocumentVOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _knowledgeBaseId = $v.knowledgeBaseId;
      _name = $v.name;
      _fileType = $v.fileType;
      _fileUrl = $v.fileUrl;
      _fileSize = $v.fileSize;
      _chunkCount = $v.chunkCount;
      _status = $v.status;
      _errorMessage = $v.errorMessage;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnowledgeDocumentVO other) {
    _$v = other as _$KnowledgeDocumentVO;
  }

  @override
  void update(void Function(KnowledgeDocumentVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnowledgeDocumentVO build() => _build();

  _$KnowledgeDocumentVO _build() {
    final _$result =
        _$v ??
        _$KnowledgeDocumentVO._(
          id: id,
          knowledgeBaseId: knowledgeBaseId,
          name: name,
          fileType: fileType,
          fileUrl: fileUrl,
          fileSize: fileSize,
          chunkCount: chunkCount,
          status: status,
          errorMessage: errorMessage,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
