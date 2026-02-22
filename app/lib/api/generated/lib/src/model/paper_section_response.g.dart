// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_section_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaperSectionResponse extends PaperSectionResponse {
  @override
  final int? id;
  @override
  final int? paperId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? questionType;
  @override
  final String? questionTypeDesc;
  @override
  final int? sortOrder;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$PaperSectionResponse([
    void Function(PaperSectionResponseBuilder)? updates,
  ]) => (PaperSectionResponseBuilder()..update(updates))._build();

  _$PaperSectionResponse._({
    this.id,
    this.paperId,
    this.title,
    this.description,
    this.questionType,
    this.questionTypeDesc,
    this.sortOrder,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  PaperSectionResponse rebuild(
    void Function(PaperSectionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PaperSectionResponseBuilder toBuilder() =>
      PaperSectionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaperSectionResponse &&
        id == other.id &&
        paperId == other.paperId &&
        title == other.title &&
        description == other.description &&
        questionType == other.questionType &&
        questionTypeDesc == other.questionTypeDesc &&
        sortOrder == other.sortOrder &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, paperId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, questionType.hashCode);
    _$hash = $jc(_$hash, questionTypeDesc.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaperSectionResponse')
          ..add('id', id)
          ..add('paperId', paperId)
          ..add('title', title)
          ..add('description', description)
          ..add('questionType', questionType)
          ..add('questionTypeDesc', questionTypeDesc)
          ..add('sortOrder', sortOrder)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class PaperSectionResponseBuilder
    implements Builder<PaperSectionResponse, PaperSectionResponseBuilder> {
  _$PaperSectionResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _paperId;
  int? get paperId => _$this._paperId;
  set paperId(int? paperId) => _$this._paperId = paperId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _questionType;
  String? get questionType => _$this._questionType;
  set questionType(String? questionType) => _$this._questionType = questionType;

  String? _questionTypeDesc;
  String? get questionTypeDesc => _$this._questionTypeDesc;
  set questionTypeDesc(String? questionTypeDesc) =>
      _$this._questionTypeDesc = questionTypeDesc;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  PaperSectionResponseBuilder() {
    PaperSectionResponse._defaults(this);
  }

  PaperSectionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _paperId = $v.paperId;
      _title = $v.title;
      _description = $v.description;
      _questionType = $v.questionType;
      _questionTypeDesc = $v.questionTypeDesc;
      _sortOrder = $v.sortOrder;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaperSectionResponse other) {
    _$v = other as _$PaperSectionResponse;
  }

  @override
  void update(void Function(PaperSectionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaperSectionResponse build() => _build();

  _$PaperSectionResponse _build() {
    final _$result =
        _$v ??
        _$PaperSectionResponse._(
          id: id,
          paperId: paperId,
          title: title,
          description: description,
          questionType: questionType,
          questionTypeDesc: questionTypeDesc,
          sortOrder: sortOrder,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
