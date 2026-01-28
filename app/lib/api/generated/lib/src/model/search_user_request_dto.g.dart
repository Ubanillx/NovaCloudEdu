// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchUserRequestDTO extends SearchUserRequestDTO {
  @override
  final String? keyword;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$SearchUserRequestDTO([
    void Function(SearchUserRequestDTOBuilder)? updates,
  ]) => (SearchUserRequestDTOBuilder()..update(updates))._build();

  _$SearchUserRequestDTO._({this.keyword, this.pageNum, this.pageSize})
    : super._();
  @override
  SearchUserRequestDTO rebuild(
    void Function(SearchUserRequestDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SearchUserRequestDTOBuilder toBuilder() =>
      SearchUserRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchUserRequestDTO &&
        keyword == other.keyword &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, keyword.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SearchUserRequestDTO')
          ..add('keyword', keyword)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class SearchUserRequestDTOBuilder
    implements Builder<SearchUserRequestDTO, SearchUserRequestDTOBuilder> {
  _$SearchUserRequestDTO? _$v;

  String? _keyword;
  String? get keyword => _$this._keyword;
  set keyword(String? keyword) => _$this._keyword = keyword;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  SearchUserRequestDTOBuilder() {
    SearchUserRequestDTO._defaults(this);
  }

  SearchUserRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _keyword = $v.keyword;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchUserRequestDTO other) {
    _$v = other as _$SearchUserRequestDTO;
  }

  @override
  void update(void Function(SearchUserRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SearchUserRequestDTO build() => _build();

  _$SearchUserRequestDTO _build() {
    final _$result =
        _$v ??
        _$SearchUserRequestDTO._(
          keyword: keyword,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
