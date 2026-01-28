// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ai_assistant_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAiAssistantCommand extends CreateAiAssistantCommand {
  @override
  final String name;
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
  final BuiltList<int>? knowledgeBaseIds;

  factory _$CreateAiAssistantCommand([
    void Function(CreateAiAssistantCommandBuilder)? updates,
  ]) => (CreateAiAssistantCommandBuilder()..update(updates))._build();

  _$CreateAiAssistantCommand._({
    required this.name,
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
    this.knowledgeBaseIds,
  }) : super._();
  @override
  CreateAiAssistantCommand rebuild(
    void Function(CreateAiAssistantCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateAiAssistantCommandBuilder toBuilder() =>
      CreateAiAssistantCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAiAssistantCommand &&
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
        knowledgeBaseIds == other.knowledgeBaseIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
    _$hash = $jc(_$hash, knowledgeBaseIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAiAssistantCommand')
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
          ..add('knowledgeBaseIds', knowledgeBaseIds))
        .toString();
  }
}

class CreateAiAssistantCommandBuilder
    implements
        Builder<CreateAiAssistantCommand, CreateAiAssistantCommandBuilder> {
  _$CreateAiAssistantCommand? _$v;

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

  ListBuilder<int>? _knowledgeBaseIds;
  ListBuilder<int> get knowledgeBaseIds =>
      _$this._knowledgeBaseIds ??= ListBuilder<int>();
  set knowledgeBaseIds(ListBuilder<int>? knowledgeBaseIds) =>
      _$this._knowledgeBaseIds = knowledgeBaseIds;

  CreateAiAssistantCommandBuilder() {
    CreateAiAssistantCommand._defaults(this);
  }

  CreateAiAssistantCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
      _knowledgeBaseIds = $v.knowledgeBaseIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAiAssistantCommand other) {
    _$v = other as _$CreateAiAssistantCommand;
  }

  @override
  void update(void Function(CreateAiAssistantCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAiAssistantCommand build() => _build();

  _$CreateAiAssistantCommand _build() {
    _$CreateAiAssistantCommand _$result;
    try {
      _$result =
          _$v ??
          _$CreateAiAssistantCommand._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'CreateAiAssistantCommand',
              'name',
            ),
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
            knowledgeBaseIds: _knowledgeBaseIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();

        _$failedField = 'suggestedQuestions';
        _suggestedQuestions?.build();

        _$failedField = 'knowledgeBaseIds';
        _knowledgeBaseIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateAiAssistantCommand',
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
