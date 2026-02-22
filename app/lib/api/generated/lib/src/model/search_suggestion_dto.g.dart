// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchSuggestionDTO extends SearchSuggestionDTO {
  @override
  final String? text;
  @override
  final String? type;
  @override
  final int? id;

  factory _$SearchSuggestionDTO([
    void Function(SearchSuggestionDTOBuilder)? updates,
  ]) => (SearchSuggestionDTOBuilder()..update(updates))._build();

  _$SearchSuggestionDTO._({this.text, this.type, this.id}) : super._();
  @override
  SearchSuggestionDTO rebuild(
    void Function(SearchSuggestionDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SearchSuggestionDTOBuilder toBuilder() =>
      SearchSuggestionDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchSuggestionDTO &&
        text == other.text &&
        type == other.type &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchSuggestionDTO')
          ..add('text', text)
          ..add('type', type)
          ..add('id', id))
        .toString();
  }
}

class SearchSuggestionDTOBuilder
    implements Builder<SearchSuggestionDTO, SearchSuggestionDTOBuilder> {
  _$SearchSuggestionDTO? _$v;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  SearchSuggestionDTOBuilder() {
    SearchSuggestionDTO._defaults(this);
  }

  SearchSuggestionDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _text = $v.text;
      _type = $v.type;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchSuggestionDTO other) {
    _$v = other as _$SearchSuggestionDTO;
  }

  @override
  void update(void Function(SearchSuggestionDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchSuggestionDTO build() => _build();

  _$SearchSuggestionDTO _build() {
    final _$result =
        _$v ?? _$SearchSuggestionDTO._(text: text, type: type, id: id);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
