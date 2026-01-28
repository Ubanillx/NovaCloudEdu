// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_announcement_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserAnnouncementPageResponse extends UserAnnouncementPageResponse {
  @override
  final BuiltList<AnnouncementListResponse>? records;
  @override
  final int? total;
  @override
  final int? pageNum;
  @override
  final int? pageSize;
  @override
  final int? totalPages;
  @override
  final int? unreadCount;

  factory _$UserAnnouncementPageResponse([
    void Function(UserAnnouncementPageResponseBuilder)? updates,
  ]) => (UserAnnouncementPageResponseBuilder()..update(updates))._build();

  _$UserAnnouncementPageResponse._({
    this.records,
    this.total,
    this.pageNum,
    this.pageSize,
    this.totalPages,
    this.unreadCount,
  }) : super._();
  @override
  UserAnnouncementPageResponse rebuild(
    void Function(UserAnnouncementPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserAnnouncementPageResponseBuilder toBuilder() =>
      UserAnnouncementPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserAnnouncementPageResponse &&
        records == other.records &&
        total == other.total &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize &&
        totalPages == other.totalPages &&
        unreadCount == other.unreadCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, records.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, unreadCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserAnnouncementPageResponse')
          ..add('records', records)
          ..add('total', total)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize)
          ..add('totalPages', totalPages)
          ..add('unreadCount', unreadCount))
        .toString();
  }
}

class UserAnnouncementPageResponseBuilder
    implements
        Builder<
          UserAnnouncementPageResponse,
          UserAnnouncementPageResponseBuilder
        > {
  _$UserAnnouncementPageResponse? _$v;

  ListBuilder<AnnouncementListResponse>? _records;
  ListBuilder<AnnouncementListResponse> get records =>
      _$this._records ??= ListBuilder<AnnouncementListResponse>();
  set records(ListBuilder<AnnouncementListResponse>? records) =>
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

  int? _unreadCount;
  int? get unreadCount => _$this._unreadCount;
  set unreadCount(int? unreadCount) => _$this._unreadCount = unreadCount;

  UserAnnouncementPageResponseBuilder() {
    UserAnnouncementPageResponse._defaults(this);
  }

  UserAnnouncementPageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _records = $v.records?.toBuilder();
      _total = $v.total;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _totalPages = $v.totalPages;
      _unreadCount = $v.unreadCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserAnnouncementPageResponse other) {
    _$v = other as _$UserAnnouncementPageResponse;
  }

  @override
  void update(void Function(UserAnnouncementPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserAnnouncementPageResponse build() => _build();

  _$UserAnnouncementPageResponse _build() {
    _$UserAnnouncementPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$UserAnnouncementPageResponse._(
            records: _records?.build(),
            total: total,
            pageNum: pageNum,
            pageSize: pageSize,
            totalPages: totalPages,
            unreadCount: unreadCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'records';
        _records?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UserAnnouncementPageResponse',
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
