// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_list_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendRequestListDTO extends FriendRequestListDTO {
  @override
  final String? status;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$FriendRequestListDTO([
    void Function(FriendRequestListDTOBuilder)? updates,
  ]) => (FriendRequestListDTOBuilder()..update(updates))._build();

  _$FriendRequestListDTO._({this.status, this.pageNum, this.pageSize})
    : super._();
  @override
  FriendRequestListDTO rebuild(
    void Function(FriendRequestListDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FriendRequestListDTOBuilder toBuilder() =>
      FriendRequestListDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendRequestListDTO &&
        status == other.status &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendRequestListDTO')
          ..add('status', status)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class FriendRequestListDTOBuilder
    implements Builder<FriendRequestListDTO, FriendRequestListDTOBuilder> {
  _$FriendRequestListDTO? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  FriendRequestListDTOBuilder() {
    FriendRequestListDTO._defaults(this);
  }

  FriendRequestListDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendRequestListDTO other) {
    _$v = other as _$FriendRequestListDTO;
  }

  @override
  void update(void Function(FriendRequestListDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendRequestListDTO build() => _build();

  _$FriendRequestListDTO _build() {
    final _$result =
        _$v ??
        _$FriendRequestListDTO._(
          status: status,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
