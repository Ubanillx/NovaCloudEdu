// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scraper_config_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScraperConfigResponse extends ScraperConfigResponse {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? sourceCode;
  @override
  final String? baseUrl;
  @override
  final String? description;
  @override
  final String? titleSelector;
  @override
  final String? authorSelector;
  @override
  final String? sourceSelector;
  @override
  final String? contentSelector;
  @override
  final String? dateSelector;
  @override
  final String? imageSelector;
  @override
  final String? linkSelector;
  @override
  final int? maxDepth;
  @override
  final int? maxPages;
  @override
  final int? delayMs;
  @override
  final bool? useDynamic;
  @override
  final int? waitForJsMs;
  @override
  final String? cronExpression;
  @override
  final bool? enabled;
  @override
  final int? defaultMaxArticles;
  @override
  final String? defaultCategory;
  @override
  final int? defaultDifficulty;
  @override
  final int? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ScraperConfigResponse([
    void Function(ScraperConfigResponseBuilder)? updates,
  ]) => (ScraperConfigResponseBuilder()..update(updates))._build();

  _$ScraperConfigResponse._({
    this.id,
    this.name,
    this.sourceCode,
    this.baseUrl,
    this.description,
    this.titleSelector,
    this.authorSelector,
    this.sourceSelector,
    this.contentSelector,
    this.dateSelector,
    this.imageSelector,
    this.linkSelector,
    this.maxDepth,
    this.maxPages,
    this.delayMs,
    this.useDynamic,
    this.waitForJsMs,
    this.cronExpression,
    this.enabled,
    this.defaultMaxArticles,
    this.defaultCategory,
    this.defaultDifficulty,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ScraperConfigResponse rebuild(
    void Function(ScraperConfigResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ScraperConfigResponseBuilder toBuilder() =>
      ScraperConfigResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScraperConfigResponse &&
        id == other.id &&
        name == other.name &&
        sourceCode == other.sourceCode &&
        baseUrl == other.baseUrl &&
        description == other.description &&
        titleSelector == other.titleSelector &&
        authorSelector == other.authorSelector &&
        sourceSelector == other.sourceSelector &&
        contentSelector == other.contentSelector &&
        dateSelector == other.dateSelector &&
        imageSelector == other.imageSelector &&
        linkSelector == other.linkSelector &&
        maxDepth == other.maxDepth &&
        maxPages == other.maxPages &&
        delayMs == other.delayMs &&
        useDynamic == other.useDynamic &&
        waitForJsMs == other.waitForJsMs &&
        cronExpression == other.cronExpression &&
        enabled == other.enabled &&
        defaultMaxArticles == other.defaultMaxArticles &&
        defaultCategory == other.defaultCategory &&
        defaultDifficulty == other.defaultDifficulty &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, sourceCode.hashCode);
    _$hash = $jc(_$hash, baseUrl.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, titleSelector.hashCode);
    _$hash = $jc(_$hash, authorSelector.hashCode);
    _$hash = $jc(_$hash, sourceSelector.hashCode);
    _$hash = $jc(_$hash, contentSelector.hashCode);
    _$hash = $jc(_$hash, dateSelector.hashCode);
    _$hash = $jc(_$hash, imageSelector.hashCode);
    _$hash = $jc(_$hash, linkSelector.hashCode);
    _$hash = $jc(_$hash, maxDepth.hashCode);
    _$hash = $jc(_$hash, maxPages.hashCode);
    _$hash = $jc(_$hash, delayMs.hashCode);
    _$hash = $jc(_$hash, useDynamic.hashCode);
    _$hash = $jc(_$hash, waitForJsMs.hashCode);
    _$hash = $jc(_$hash, cronExpression.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, defaultMaxArticles.hashCode);
    _$hash = $jc(_$hash, defaultCategory.hashCode);
    _$hash = $jc(_$hash, defaultDifficulty.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScraperConfigResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('sourceCode', sourceCode)
          ..add('baseUrl', baseUrl)
          ..add('description', description)
          ..add('titleSelector', titleSelector)
          ..add('authorSelector', authorSelector)
          ..add('sourceSelector', sourceSelector)
          ..add('contentSelector', contentSelector)
          ..add('dateSelector', dateSelector)
          ..add('imageSelector', imageSelector)
          ..add('linkSelector', linkSelector)
          ..add('maxDepth', maxDepth)
          ..add('maxPages', maxPages)
          ..add('delayMs', delayMs)
          ..add('useDynamic', useDynamic)
          ..add('waitForJsMs', waitForJsMs)
          ..add('cronExpression', cronExpression)
          ..add('enabled', enabled)
          ..add('defaultMaxArticles', defaultMaxArticles)
          ..add('defaultCategory', defaultCategory)
          ..add('defaultDifficulty', defaultDifficulty)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ScraperConfigResponseBuilder
    implements Builder<ScraperConfigResponse, ScraperConfigResponseBuilder> {
  _$ScraperConfigResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _sourceCode;
  String? get sourceCode => _$this._sourceCode;
  set sourceCode(String? sourceCode) => _$this._sourceCode = sourceCode;

  String? _baseUrl;
  String? get baseUrl => _$this._baseUrl;
  set baseUrl(String? baseUrl) => _$this._baseUrl = baseUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _titleSelector;
  String? get titleSelector => _$this._titleSelector;
  set titleSelector(String? titleSelector) =>
      _$this._titleSelector = titleSelector;

  String? _authorSelector;
  String? get authorSelector => _$this._authorSelector;
  set authorSelector(String? authorSelector) =>
      _$this._authorSelector = authorSelector;

  String? _sourceSelector;
  String? get sourceSelector => _$this._sourceSelector;
  set sourceSelector(String? sourceSelector) =>
      _$this._sourceSelector = sourceSelector;

  String? _contentSelector;
  String? get contentSelector => _$this._contentSelector;
  set contentSelector(String? contentSelector) =>
      _$this._contentSelector = contentSelector;

  String? _dateSelector;
  String? get dateSelector => _$this._dateSelector;
  set dateSelector(String? dateSelector) => _$this._dateSelector = dateSelector;

  String? _imageSelector;
  String? get imageSelector => _$this._imageSelector;
  set imageSelector(String? imageSelector) =>
      _$this._imageSelector = imageSelector;

  String? _linkSelector;
  String? get linkSelector => _$this._linkSelector;
  set linkSelector(String? linkSelector) => _$this._linkSelector = linkSelector;

  int? _maxDepth;
  int? get maxDepth => _$this._maxDepth;
  set maxDepth(int? maxDepth) => _$this._maxDepth = maxDepth;

  int? _maxPages;
  int? get maxPages => _$this._maxPages;
  set maxPages(int? maxPages) => _$this._maxPages = maxPages;

  int? _delayMs;
  int? get delayMs => _$this._delayMs;
  set delayMs(int? delayMs) => _$this._delayMs = delayMs;

  bool? _useDynamic;
  bool? get useDynamic => _$this._useDynamic;
  set useDynamic(bool? useDynamic) => _$this._useDynamic = useDynamic;

  int? _waitForJsMs;
  int? get waitForJsMs => _$this._waitForJsMs;
  set waitForJsMs(int? waitForJsMs) => _$this._waitForJsMs = waitForJsMs;

  String? _cronExpression;
  String? get cronExpression => _$this._cronExpression;
  set cronExpression(String? cronExpression) =>
      _$this._cronExpression = cronExpression;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  int? _defaultMaxArticles;
  int? get defaultMaxArticles => _$this._defaultMaxArticles;
  set defaultMaxArticles(int? defaultMaxArticles) =>
      _$this._defaultMaxArticles = defaultMaxArticles;

  String? _defaultCategory;
  String? get defaultCategory => _$this._defaultCategory;
  set defaultCategory(String? defaultCategory) =>
      _$this._defaultCategory = defaultCategory;

  int? _defaultDifficulty;
  int? get defaultDifficulty => _$this._defaultDifficulty;
  set defaultDifficulty(int? defaultDifficulty) =>
      _$this._defaultDifficulty = defaultDifficulty;

  int? _creatorId;
  int? get creatorId => _$this._creatorId;
  set creatorId(int? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ScraperConfigResponseBuilder() {
    ScraperConfigResponse._defaults(this);
  }

  ScraperConfigResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _sourceCode = $v.sourceCode;
      _baseUrl = $v.baseUrl;
      _description = $v.description;
      _titleSelector = $v.titleSelector;
      _authorSelector = $v.authorSelector;
      _sourceSelector = $v.sourceSelector;
      _contentSelector = $v.contentSelector;
      _dateSelector = $v.dateSelector;
      _imageSelector = $v.imageSelector;
      _linkSelector = $v.linkSelector;
      _maxDepth = $v.maxDepth;
      _maxPages = $v.maxPages;
      _delayMs = $v.delayMs;
      _useDynamic = $v.useDynamic;
      _waitForJsMs = $v.waitForJsMs;
      _cronExpression = $v.cronExpression;
      _enabled = $v.enabled;
      _defaultMaxArticles = $v.defaultMaxArticles;
      _defaultCategory = $v.defaultCategory;
      _defaultDifficulty = $v.defaultDifficulty;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScraperConfigResponse other) {
    _$v = other as _$ScraperConfigResponse;
  }

  @override
  void update(void Function(ScraperConfigResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScraperConfigResponse build() => _build();

  _$ScraperConfigResponse _build() {
    final _$result =
        _$v ??
        _$ScraperConfigResponse._(
          id: id,
          name: name,
          sourceCode: sourceCode,
          baseUrl: baseUrl,
          description: description,
          titleSelector: titleSelector,
          authorSelector: authorSelector,
          sourceSelector: sourceSelector,
          contentSelector: contentSelector,
          dateSelector: dateSelector,
          imageSelector: imageSelector,
          linkSelector: linkSelector,
          maxDepth: maxDepth,
          maxPages: maxPages,
          delayMs: delayMs,
          useDynamic: useDynamic,
          waitForJsMs: waitForJsMs,
          cronExpression: cronExpression,
          enabled: enabled,
          defaultMaxArticles: defaultMaxArticles,
          defaultCategory: defaultCategory,
          defaultDifficulty: defaultDifficulty,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
