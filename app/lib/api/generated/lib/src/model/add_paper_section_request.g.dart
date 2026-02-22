// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_paper_section_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddPaperSectionRequest extends AddPaperSectionRequest {
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? questionType;
  @override
  final int? sortOrder;

  factory _$AddPaperSectionRequest([
    void Function(AddPaperSectionRequestBuilder)? updates,
  ]) => (AddPaperSectionRequestBuilder()..update(updates))._build();

  _$AddPaperSectionRequest._({
    required this.title,
    this.description,
    this.questionType,
    this.sortOrder,
  }) : super._();
  @override
  AddPaperSectionRequest rebuild(
    void Function(AddPaperSectionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AddPaperSectionRequestBuilder toBuilder() =>
      AddPaperSectionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddPaperSectionRequest &&
        title == other.title &&
        description == other.description &&
        questionType == other.questionType &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, questionType.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddPaperSectionRequest')
          ..add('title', title)
          ..add('description', description)
          ..add('questionType', questionType)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class AddPaperSectionRequestBuilder
    implements Builder<AddPaperSectionRequest, AddPaperSectionRequestBuilder> {
  _$AddPaperSectionRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _questionType;
  String? get questionType => _$this._questionType;
  set questionType(String? questionType) => _$this._questionType = questionType;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  AddPaperSectionRequestBuilder() {
    AddPaperSectionRequest._defaults(this);
  }

  AddPaperSectionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _questionType = $v.questionType;
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddPaperSectionRequest other) {
    _$v = other as _$AddPaperSectionRequest;
  }

  @override
  void update(void Function(AddPaperSectionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddPaperSectionRequest build() => _build();

  _$AddPaperSectionRequest _build() {
    final _$result =
        _$v ??
        _$AddPaperSectionRequest._(
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'AddPaperSectionRequest',
            'title',
          ),
          description: description,
          questionType: questionType,
          sortOrder: sortOrder,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
