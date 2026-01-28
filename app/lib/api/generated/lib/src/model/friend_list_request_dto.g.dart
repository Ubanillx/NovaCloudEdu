// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_list_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendListRequestDTO extends FriendListRequestDTO {
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$FriendListRequestDTO([
    void Function(FriendListRequestDTOBuilder)? updates,
  ]) => (FriendListRequestDTOBuilder()..update(updates))._build();

  _$FriendListRequestDTO._({this.pageNum, this.pageSize}) : super._();
  @override
  FriendListRequestDTO rebuild(
    void Function(FriendListRequestDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FriendListRequestDTOBuilder toBuilder() =>
      FriendListRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendListRequestDTO &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendListRequestDTO')
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class FriendListRequestDTOBuilder
    implements Builder<FriendListRequestDTO, FriendListRequestDTOBuilder> {
  _$FriendListRequestDTO? _$v;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  FriendListRequestDTOBuilder() {
    FriendListRequestDTO._defaults(this);
  }

  FriendListRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendListRequestDTO other) {
    _$v = other as _$FriendListRequestDTO;
  }

  @override
  void update(void Function(FriendListRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendListRequestDTO build() => _build();

  _$FriendListRequestDTO _build() {
    final _$result =
        _$v ?? _$FriendListRequestDTO._(pageNum: pageNum, pageSize: pageSize);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
