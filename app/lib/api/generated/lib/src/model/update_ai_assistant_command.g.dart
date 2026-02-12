// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_ai_assistant_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAiAssistantCommand extends UpdateAiAssistantCommand {
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
  final bool? isPublic;
  @override
  final int? sort;
  @override
  final BuiltList<int>? mcpServerIds;

  factory _$UpdateAiAssistantCommand([
    void Function(UpdateAiAssistantCommandBuilder)? updates,
  ]) => (UpdateAiAssistantCommandBuilder()..update(updates))._build();

  _$UpdateAiAssistantCommand._({
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
    this.isPublic,
    this.sort,
    this.mcpServerIds,
  }) : super._();
  @override
  UpdateAiAssistantCommand rebuild(
    void Function(UpdateAiAssistantCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateAiAssistantCommandBuilder toBuilder() =>
      UpdateAiAssistantCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAiAssistantCommand &&
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
        isPublic == other.isPublic &&
        sort == other.sort &&
        mcpServerIds == other.mcpServerIds;
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
    _$hash = $jc(_$hash, isPublic.hashCode);
    _$hash = $jc(_$hash, sort.hashCode);
    _$hash = $jc(_$hash, mcpServerIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAiAssistantCommand')
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
          ..add('isPublic', isPublic)
          ..add('sort', sort)
          ..add('mcpServerIds', mcpServerIds))
        .toString();
  }
}

class UpdateAiAssistantCommandBuilder
    implements
        Builder<UpdateAiAssistantCommand, UpdateAiAssistantCommandBuilder> {
  _$UpdateAiAssistantCommand? _$v;

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

  bool? _isPublic;
  bool? get isPublic => _$this._isPublic;
  set isPublic(bool? isPublic) => _$this._isPublic = isPublic;

  int? _sort;
  int? get sort => _$this._sort;
  set sort(int? sort) => _$this._sort = sort;

  ListBuilder<int>? _mcpServerIds;
  ListBuilder<int> get mcpServerIds =>
      _$this._mcpServerIds ??= ListBuilder<int>();
  set mcpServerIds(ListBuilder<int>? mcpServerIds) =>
      _$this._mcpServerIds = mcpServerIds;

  UpdateAiAssistantCommandBuilder() {
    UpdateAiAssistantCommand._defaults(this);
  }

  UpdateAiAssistantCommandBuilder get _$this {
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
      _isPublic = $v.isPublic;
      _sort = $v.sort;
      _mcpServerIds = $v.mcpServerIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAiAssistantCommand other) {
    _$v = other as _$UpdateAiAssistantCommand;
  }

  @override
  void update(void Function(UpdateAiAssistantCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAiAssistantCommand build() => _build();

  _$UpdateAiAssistantCommand _build() {
    _$UpdateAiAssistantCommand _$result;
    try {
      _$result =
          _$v ??
          _$UpdateAiAssistantCommand._(
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
            isPublic: isPublic,
            sort: sort,
            mcpServerIds: _mcpServerIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();

        _$failedField = 'suggestedQuestions';
        _suggestedQuestions?.build();

        _$failedField = 'mcpServerIds';
        _mcpServerIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateAiAssistantCommand',
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
