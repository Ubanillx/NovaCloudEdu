// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_assistant_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AiAssistantVO extends AiAssistantVO {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? avatarUrl;
  @override
  final BuiltList<String>? tags;
  @override
  final String? category;
  @override
  final String? systemPrompt;
  @override
  final String? openingMessage;
  @override
  final BuiltList<String>? suggestedQuestions;
  @override
  final String? modelName;
  @override
  final num? temperature;
  @override
  final num? topP;
  @override
  final int? maxTokens;
  @override
  final String? status;
  @override
  final int? version;
  @override
  final int? publishedVersion;
  @override
  final bool? isPublic;
  @override
  final int? usageCount;
  @override
  final double? rating;
  @override
  final BuiltList<KnowledgeBaseVO>? knowledgeBases;
  @override
  final int? creatorId;
  @override
  final int? sort;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$AiAssistantVO([void Function(AiAssistantVOBuilder)? updates]) =>
      (AiAssistantVOBuilder()..update(updates))._build();

  _$AiAssistantVO._({
    this.id,
    this.name,
    this.description,
    this.avatarUrl,
    this.tags,
    this.category,
    this.systemPrompt,
    this.openingMessage,
    this.suggestedQuestions,
    this.modelName,
    this.temperature,
    this.topP,
    this.maxTokens,
    this.status,
    this.version,
    this.publishedVersion,
    this.isPublic,
    this.usageCount,
    this.rating,
    this.knowledgeBases,
    this.creatorId,
    this.sort,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  AiAssistantVO rebuild(void Function(AiAssistantVOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AiAssistantVOBuilder toBuilder() => AiAssistantVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AiAssistantVO &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        avatarUrl == other.avatarUrl &&
        tags == other.tags &&
        category == other.category &&
        systemPrompt == other.systemPrompt &&
        openingMessage == other.openingMessage &&
        suggestedQuestions == other.suggestedQuestions &&
        modelName == other.modelName &&
        temperature == other.temperature &&
        topP == other.topP &&
        maxTokens == other.maxTokens &&
        status == other.status &&
        version == other.version &&
        publishedVersion == other.publishedVersion &&
        isPublic == other.isPublic &&
        usageCount == other.usageCount &&
        rating == other.rating &&
        knowledgeBases == other.knowledgeBases &&
        creatorId == other.creatorId &&
        sort == other.sort &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, systemPrompt.hashCode);
    _$hash = $jc(_$hash, openingMessage.hashCode);
    _$hash = $jc(_$hash, suggestedQuestions.hashCode);
    _$hash = $jc(_$hash, modelName.hashCode);
    _$hash = $jc(_$hash, temperature.hashCode);
    _$hash = $jc(_$hash, topP.hashCode);
    _$hash = $jc(_$hash, maxTokens.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, publishedVersion.hashCode);
    _$hash = $jc(_$hash, isPublic.hashCode);
    _$hash = $jc(_$hash, usageCount.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jc(_$hash, knowledgeBases.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AiAssistantVO')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('avatarUrl', avatarUrl)
          ..add('tags', tags)
          ..add('category', category)
          ..add('systemPrompt', systemPrompt)
          ..add('openingMessage', openingMessage)
          ..add('suggestedQuestions', suggestedQuestions)
          ..add('modelName', modelName)
          ..add('temperature', temperature)
          ..add('topP', topP)
          ..add('maxTokens', maxTokens)
          ..add('status', status)
          ..add('version', version)
          ..add('publishedVersion', publishedVersion)
          ..add('isPublic', isPublic)
          ..add('usageCount', usageCount)
          ..add('rating', rating)
          ..add('knowledgeBases', knowledgeBases)
          ..add('creatorId', creatorId)
          ..add('sort', sort)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class AiAssistantVOBuilder
    implements Builder<AiAssistantVO, AiAssistantVOBuilder> {
  _$AiAssistantVO? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _systemPrompt;
  String? get systemPrompt => _$this._systemPrompt;
  set systemPrompt(String? systemPrompt) => _$this._systemPrompt = systemPrompt;

  String? _openingMessage;
  String? get openingMessage => _$this._openingMessage;
  set openingMessage(String? openingMessage) =>
      _$this._openingMessage = openingMessage;

  ListBuilder<String>? _suggestedQuestions;
  ListBuilder<String> get suggestedQuestions =>
      _$this._suggestedQuestions ??= ListBuilder<String>();
  set suggestedQuestions(ListBuilder<String>? suggestedQuestions) =>
      _$this._suggestedQuestions = suggestedQuestions;

  String? _modelName;
  String? get modelName => _$this._modelName;
  set modelName(String? modelName) => _$this._modelName = modelName;

  num? _temperature;
  num? get temperature => _$this._temperature;
  set temperature(num? temperature) => _$this._temperature = temperature;

  num? _topP;
  num? get topP => _$this._topP;
  set topP(num? topP) => _$this._topP = topP;

  int? _maxTokens;
  int? get maxTokens => _$this._maxTokens;
  set maxTokens(int? maxTokens) => _$this._maxTokens = maxTokens;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  int? _publishedVersion;
  int? get publishedVersion => _$this._publishedVersion;
  set publishedVersion(int? publishedVersion) =>
      _$this._publishedVersion = publishedVersion;

  bool? _isPublic;
  bool? get isPublic => _$this._isPublic;
  set isPublic(bool? isPublic) => _$this._isPublic = isPublic;

  int? _usageCount;
  int? get usageCount => _$this._usageCount;
  set usageCount(int? usageCount) => _$this._usageCount = usageCount;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  ListBuilder<KnowledgeBaseVO>? _knowledgeBases;
  ListBuilder<KnowledgeBaseVO> get knowledgeBases =>
      _$this._knowledgeBases ??= ListBuilder<KnowledgeBaseVO>();
  set knowledgeBases(ListBuilder<KnowledgeBaseVO>? knowledgeBases) =>
      _$this._knowledgeBases = knowledgeBases;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  AiAssistantVOBuilder() {
    AiAssistantVO._defaults(this);
  }

  AiAssistantVOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _avatarUrl = $v.avatarUrl;
      _tags = $v.tags?.toBuilder();
      _category = $v.category;
      _systemPrompt = $v.systemPrompt;
      _openingMessage = $v.openingMessage;
      _suggestedQuestions = $v.suggestedQuestions?.toBuilder();
      _modelName = $v.modelName;
      _temperature = $v.temperature;
      _topP = $v.topP;
      _maxTokens = $v.maxTokens;
      _status = $v.status;
      _version = $v.version;
      _publishedVersion = $v.publishedVersion;
      _isPublic = $v.isPublic;
      _usageCount = $v.usageCount;
      _rating = $v.rating;
      _knowledgeBases = $v.knowledgeBases?.toBuilder();
      _creatorId = $v.creatorId;
      _sort = $v.sort;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AiAssistantVO other) {
    _$v = other as _$AiAssistantVO;
  }

  @override
  void update(void Function(AiAssistantVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AiAssistantVO build() => _build();

  _$AiAssistantVO _build() {
    _$AiAssistantVO _$result;
    try {
      _$result =
          _$v ??
          _$AiAssistantVO._(
            id: id,
            name: name,
            description: description,
            avatarUrl: avatarUrl,
            tags: _tags?.build(),
            category: category,
            systemPrompt: systemPrompt,
            openingMessage: openingMessage,
            suggestedQuestions: _suggestedQuestions?.build(),
            modelName: modelName,
            temperature: temperature,
            topP: topP,
            maxTokens: maxTokens,
            status: status,
            version: version,
            publishedVersion: publishedVersion,
            isPublic: isPublic,
            usageCount: usageCount,
            rating: rating,
            knowledgeBases: _knowledgeBases?.build(),
            creatorId: creatorId,
            sort: sort,
            createTime: createTime,
            updateTime: updateTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();

        _$failedField = 'suggestedQuestions';
        _suggestedQuestions?.build();

        _$failedField = 'knowledgeBases';
        _knowledgeBases?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AiAssistantVO',
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
