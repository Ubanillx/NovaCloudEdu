// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChapterSummarySummaryTypeEnum _$chapterSummarySummaryTypeEnum_BRIEF =
    const ChapterSummarySummaryTypeEnum._('BRIEF');
const ChapterSummarySummaryTypeEnum _$chapterSummarySummaryTypeEnum_DETAILED =
    const ChapterSummarySummaryTypeEnum._('DETAILED');
const ChapterSummarySummaryTypeEnum _$chapterSummarySummaryTypeEnum_KEYPOINTS =
    const ChapterSummarySummaryTypeEnum._('KEYPOINTS');

ChapterSummarySummaryTypeEnum _$chapterSummarySummaryTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'BRIEF':
      return _$chapterSummarySummaryTypeEnum_BRIEF;
    case 'DETAILED':
      return _$chapterSummarySummaryTypeEnum_DETAILED;
    case 'KEYPOINTS':
      return _$chapterSummarySummaryTypeEnum_KEYPOINTS;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChapterSummarySummaryTypeEnum>
_$chapterSummarySummaryTypeEnumValues = BuiltSet<ChapterSummarySummaryTypeEnum>(
  const <ChapterSummarySummaryTypeEnum>[
    _$chapterSummarySummaryTypeEnum_BRIEF,
    _$chapterSummarySummaryTypeEnum_DETAILED,
    _$chapterSummarySummaryTypeEnum_KEYPOINTS,
  ],
);

Serializer<ChapterSummarySummaryTypeEnum>
_$chapterSummarySummaryTypeEnumSerializer =
    _$ChapterSummarySummaryTypeEnumSerializer();

class _$ChapterSummarySummaryTypeEnumSerializer
    implements PrimitiveSerializer<ChapterSummarySummaryTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BRIEF': 'BRIEF',
    'DETAILED': 'DETAILED',
    'KEYPOINTS': 'KEYPOINTS',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BRIEF': 'BRIEF',
    'DETAILED': 'DETAILED',
    'KEYPOINTS': 'KEYPOINTS',
  };

  @override
  final Iterable<Type> types = const <Type>[ChapterSummarySummaryTypeEnum];
  @override
  final String wireName = 'ChapterSummarySummaryTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChapterSummarySummaryTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChapterSummarySummaryTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChapterSummarySummaryTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChapterSummary extends ChapterSummary {
  @override
  final ChapterSummaryId? id;
  @override
  final ChapterId? chapterId;
  @override
  final ChapterSummarySummaryTypeEnum? summaryType;
  @override
  final String? content;
  @override
  final BuiltList<String>? keyPoints;
  @override
  final String? aiModel;
  @override
  final bool? cached;
  @override
  final DateTime? createTime;

  factory _$ChapterSummary([void Function(ChapterSummaryBuilder)? updates]) =>
      (ChapterSummaryBuilder()..update(updates))._build();

  _$ChapterSummary._({
    this.id,
    this.chapterId,
    this.summaryType,
    this.content,
    this.keyPoints,
    this.aiModel,
    this.cached,
    this.createTime,
  }) : super._();
  @override
  ChapterSummary rebuild(void Function(ChapterSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChapterSummaryBuilder toBuilder() => ChapterSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChapterSummary &&
        id == other.id &&
        chapterId == other.chapterId &&
        summaryType == other.summaryType &&
        content == other.content &&
        keyPoints == other.keyPoints &&
        aiModel == other.aiModel &&
        cached == other.cached &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, summaryType.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, keyPoints.hashCode);
    _$hash = $jc(_$hash, aiModel.hashCode);
    _$hash = $jc(_$hash, cached.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChapterSummary')
          ..add('id', id)
          ..add('chapterId', chapterId)
          ..add('summaryType', summaryType)
          ..add('content', content)
          ..add('keyPoints', keyPoints)
          ..add('aiModel', aiModel)
          ..add('cached', cached)
          ..add('createTime', createTime))
        .toString();
  }
}

class ChapterSummaryBuilder
    implements Builder<ChapterSummary, ChapterSummaryBuilder> {
  _$ChapterSummary? _$v;

  ChapterSummaryIdBuilder? _id;
  ChapterSummaryIdBuilder get id => _$this._id ??= ChapterSummaryIdBuilder();
  set id(ChapterSummaryIdBuilder? id) => _$this._id = id;

  ChapterIdBuilder? _chapterId;
  ChapterIdBuilder get chapterId => _$this._chapterId ??= ChapterIdBuilder();
  set chapterId(ChapterIdBuilder? chapterId) => _$this._chapterId = chapterId;

  ChapterSummarySummaryTypeEnum? _summaryType;
  ChapterSummarySummaryTypeEnum? get summaryType => _$this._summaryType;
  set summaryType(ChapterSummarySummaryTypeEnum? summaryType) =>
      _$this._summaryType = summaryType;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  ListBuilder<String>? _keyPoints;
  ListBuilder<String> get keyPoints =>
      _$this._keyPoints ??= ListBuilder<String>();
  set keyPoints(ListBuilder<String>? keyPoints) =>
      _$this._keyPoints = keyPoints;

  String? _aiModel;
  String? get aiModel => _$this._aiModel;
  set aiModel(String? aiModel) => _$this._aiModel = aiModel;

  bool? _cached;
  bool? get cached => _$this._cached;
  set cached(bool? cached) => _$this._cached = cached;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  ChapterSummaryBuilder() {
    ChapterSummary._defaults(this);
  }

  ChapterSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _chapterId = $v.chapterId?.toBuilder();
      _summaryType = $v.summaryType;
      _content = $v.content;
      _keyPoints = $v.keyPoints?.toBuilder();
      _aiModel = $v.aiModel;
      _cached = $v.cached;
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChapterSummary other) {
    _$v = other as _$ChapterSummary;
  }

  @override
  void update(void Function(ChapterSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChapterSummary build() => _build();

  _$ChapterSummary _build() {
    _$ChapterSummary _$result;
    try {
      _$result =
          _$v ??
          _$ChapterSummary._(
            id: _id?.build(),
            chapterId: _chapterId?.build(),
            summaryType: summaryType,
            content: content,
            keyPoints: _keyPoints?.build(),
            aiModel: aiModel,
            cached: cached,
            createTime: createTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();
        _$failedField = 'chapterId';
        _chapterId?.build();

        _$failedField = 'keyPoints';
        _keyPoints?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ChapterSummary',
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
