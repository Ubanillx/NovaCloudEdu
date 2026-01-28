// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KnowledgePointPointTypeEnum _$knowledgePointPointTypeEnum_CONCEPT =
    const KnowledgePointPointTypeEnum._('CONCEPT');
const KnowledgePointPointTypeEnum _$knowledgePointPointTypeEnum_TERM =
    const KnowledgePointPointTypeEnum._('TERM');
const KnowledgePointPointTypeEnum _$knowledgePointPointTypeEnum_FORMULA =
    const KnowledgePointPointTypeEnum._('FORMULA');
const KnowledgePointPointTypeEnum _$knowledgePointPointTypeEnum_PRINCIPLE =
    const KnowledgePointPointTypeEnum._('PRINCIPLE');
const KnowledgePointPointTypeEnum _$knowledgePointPointTypeEnum_METHOD =
    const KnowledgePointPointTypeEnum._('METHOD');

KnowledgePointPointTypeEnum _$knowledgePointPointTypeEnumValueOf(String name) {
  switch (name) {
    case 'CONCEPT':
      return _$knowledgePointPointTypeEnum_CONCEPT;
    case 'TERM':
      return _$knowledgePointPointTypeEnum_TERM;
    case 'FORMULA':
      return _$knowledgePointPointTypeEnum_FORMULA;
    case 'PRINCIPLE':
      return _$knowledgePointPointTypeEnum_PRINCIPLE;
    case 'METHOD':
      return _$knowledgePointPointTypeEnum_METHOD;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnowledgePointPointTypeEnum>
_$knowledgePointPointTypeEnumValues =
    BuiltSet<KnowledgePointPointTypeEnum>(const <KnowledgePointPointTypeEnum>[
      _$knowledgePointPointTypeEnum_CONCEPT,
      _$knowledgePointPointTypeEnum_TERM,
      _$knowledgePointPointTypeEnum_FORMULA,
      _$knowledgePointPointTypeEnum_PRINCIPLE,
      _$knowledgePointPointTypeEnum_METHOD,
    ]);

Serializer<KnowledgePointPointTypeEnum>
_$knowledgePointPointTypeEnumSerializer =
    _$KnowledgePointPointTypeEnumSerializer();

class _$KnowledgePointPointTypeEnumSerializer
    implements PrimitiveSerializer<KnowledgePointPointTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CONCEPT': 'CONCEPT',
    'TERM': 'TERM',
    'FORMULA': 'FORMULA',
    'PRINCIPLE': 'PRINCIPLE',
    'METHOD': 'METHOD',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CONCEPT': 'CONCEPT',
    'TERM': 'TERM',
    'FORMULA': 'FORMULA',
    'PRINCIPLE': 'PRINCIPLE',
    'METHOD': 'METHOD',
  };

  @override
  final Iterable<Type> types = const <Type>[KnowledgePointPointTypeEnum];
  @override
  final String wireName = 'KnowledgePointPointTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    KnowledgePointPointTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  KnowledgePointPointTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => KnowledgePointPointTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$KnowledgePoint extends KnowledgePoint {
  @override
  final KnowledgePointId? id;
  @override
  final ChapterId? chapterId;
  @override
  final KnowledgePointPointTypeEnum? pointType;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? position;
  @override
  final BuiltList<int>? relatedChapterIds;
  @override
  final BuiltList<int>? relatedPointIds;
  @override
  final DateTime? createTime;

  factory _$KnowledgePoint([void Function(KnowledgePointBuilder)? updates]) =>
      (KnowledgePointBuilder()..update(updates))._build();

  _$KnowledgePoint._({
    this.id,
    this.chapterId,
    this.pointType,
    this.name,
    this.description,
    this.position,
    this.relatedChapterIds,
    this.relatedPointIds,
    this.createTime,
  }) : super._();
  @override
  KnowledgePoint rebuild(void Function(KnowledgePointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnowledgePointBuilder toBuilder() => KnowledgePointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnowledgePoint &&
        id == other.id &&
        chapterId == other.chapterId &&
        pointType == other.pointType &&
        name == other.name &&
        description == other.description &&
        position == other.position &&
        relatedChapterIds == other.relatedChapterIds &&
        relatedPointIds == other.relatedPointIds &&
        createTime == other.createTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, pointType.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, relatedChapterIds.hashCode);
    _$hash = $jc(_$hash, relatedPointIds.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnowledgePoint')
          ..add('id', id)
          ..add('chapterId', chapterId)
          ..add('pointType', pointType)
          ..add('name', name)
          ..add('description', description)
          ..add('position', position)
          ..add('relatedChapterIds', relatedChapterIds)
          ..add('relatedPointIds', relatedPointIds)
          ..add('createTime', createTime))
        .toString();
  }
}

class KnowledgePointBuilder
    implements Builder<KnowledgePoint, KnowledgePointBuilder> {
  _$KnowledgePoint? _$v;

  KnowledgePointIdBuilder? _id;
  KnowledgePointIdBuilder get id => _$this._id ??= KnowledgePointIdBuilder();
  set id(KnowledgePointIdBuilder? id) => _$this._id = id;

  ChapterIdBuilder? _chapterId;
  ChapterIdBuilder get chapterId => _$this._chapterId ??= ChapterIdBuilder();
  set chapterId(ChapterIdBuilder? chapterId) => _$this._chapterId = chapterId;

  KnowledgePointPointTypeEnum? _pointType;
  KnowledgePointPointTypeEnum? get pointType => _$this._pointType;
  set pointType(KnowledgePointPointTypeEnum? pointType) =>
      _$this._pointType = pointType;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  ListBuilder<int>? _relatedChapterIds;
  ListBuilder<int> get relatedChapterIds =>
      _$this._relatedChapterIds ??= ListBuilder<int>();
  set relatedChapterIds(ListBuilder<int>? relatedChapterIds) =>
      _$this._relatedChapterIds = relatedChapterIds;

  ListBuilder<int>? _relatedPointIds;
  ListBuilder<int> get relatedPointIds =>
      _$this._relatedPointIds ??= ListBuilder<int>();
  set relatedPointIds(ListBuilder<int>? relatedPointIds) =>
      _$this._relatedPointIds = relatedPointIds;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  KnowledgePointBuilder() {
    KnowledgePoint._defaults(this);
  }

  KnowledgePointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _chapterId = $v.chapterId?.toBuilder();
      _pointType = $v.pointType;
      _name = $v.name;
      _description = $v.description;
      _position = $v.position;
      _relatedChapterIds = $v.relatedChapterIds?.toBuilder();
      _relatedPointIds = $v.relatedPointIds?.toBuilder();
      _createTime = $v.createTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnowledgePoint other) {
    _$v = other as _$KnowledgePoint;
  }

  @override
  void update(void Function(KnowledgePointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnowledgePoint build() => _build();

  _$KnowledgePoint _build() {
    _$KnowledgePoint _$result;
    try {
      _$result =
          _$v ??
          _$KnowledgePoint._(
            id: _id?.build(),
            chapterId: _chapterId?.build(),
            pointType: pointType,
            name: name,
            description: description,
            position: position,
            relatedChapterIds: _relatedChapterIds?.build(),
            relatedPointIds: _relatedPointIds?.build(),
            createTime: createTime,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();
        _$failedField = 'chapterId';
        _chapterId?.build();

        _$failedField = 'relatedChapterIds';
        _relatedChapterIds?.build();
        _$failedField = 'relatedPointIds';
        _relatedPointIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'KnowledgePoint',
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
