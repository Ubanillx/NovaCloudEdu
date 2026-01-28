// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FriendRequestPageResponse extends FriendRequestPageResponse {
  @override
  final BuiltList<FriendRequestResponse>? records;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;

  factory _$FriendRequestPageResponse([
    void Function(FriendRequestPageResponseBuilder)? updates,
  ]) => (FriendRequestPageResponseBuilder()..update(updates))._build();

  _$FriendRequestPageResponse._({
    this.records,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
  }) : super._();
  @override
  FriendRequestPageResponse rebuild(
    void Function(FriendRequestPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FriendRequestPageResponseBuilder toBuilder() =>
      FriendRequestPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FriendRequestPageResponse &&
        records == other.records &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FriendRequestPageResponse')
          ..add('records', records)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages))
        .toString();
  }
}

class FriendRequestPageResponseBuilder
    implements
        Builder<FriendRequestPageResponse, FriendRequestPageResponseBuilder> {
  _$FriendRequestPageResponse? _$v;

  ListBuilder<FriendRequestResponse>? _records;
  ListBuilder<FriendRequestResponse> get records =>
      _$this._records ??= ListBuilder<FriendRequestResponse>();
  set records(ListBuilder<FriendRequestResponse>? records) =>
      _$this._records = records;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  int? _totalPages;
  int? get totalPages => _$this._totalPages;
  set totalPages(int? totalPages) => _$this._totalPages = totalPages;

  FriendRequestPageResponseBuilder() {
    FriendRequestPageResponse._defaults(this);
  }

  FriendRequestPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FriendRequestPageResponse other) {
    _$v = other as _$FriendRequestPageResponse;
  }

  @override
  void update(void Function(FriendRequestPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FriendRequestPageResponse build() => _build();

  _$FriendRequestPageResponse _build() {
    _$FriendRequestPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$FriendRequestPageResponse._(
            records: _records?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        _records?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FriendRequestPageResponse',
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
