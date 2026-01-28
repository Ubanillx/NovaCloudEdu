// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_announcement_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueryAnnouncementRequest extends QueryAnnouncementRequest {
  @override
  final String? title;
  @override
  final int? status;
  @override
  final int? adminId;
  @override
  final int? pageNum;
  @override
  final int? pageSize;

  factory _$QueryAnnouncementRequest([
    void Function(QueryAnnouncementRequestBuilder)? updates,
  ]) => (QueryAnnouncementRequestBuilder()..update(updates))._build();

  _$QueryAnnouncementRequest._({
    this.title,
    this.status,
    this.adminId,
    this.pageNum,
    this.pageSize,
  }) : super._();
  @override
  QueryAnnouncementRequest rebuild(
    void Function(QueryAnnouncementRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  QueryAnnouncementRequestBuilder toBuilder() =>
      QueryAnnouncementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueryAnnouncementRequest &&
        title == other.title &&
        status == other.status &&
        adminId == other.adminId &&
        pageNum == other.pageNum &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, adminId.hashCode);
    _$hash = $jc(_$hash, pageNum.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueryAnnouncementRequest')
          ..add('title', title)
          ..add('status', status)
          ..add('adminId', adminId)
          ..add('pageNum', pageNum)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class QueryAnnouncementRequestBuilder
    implements
        Builder<QueryAnnouncementRequest, QueryAnnouncementRequestBuilder> {
  _$QueryAnnouncementRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  int? _adminId;
  int? get adminId => _$this._adminId;
  set adminId(int? adminId) => _$this._adminId = adminId;

  int? _pageNum;
  int? get pageNum => _$this._pageNum;
  set pageNum(int? pageNum) => _$this._pageNum = pageNum;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  QueryAnnouncementRequestBuilder() {
    QueryAnnouncementRequest._defaults(this);
  }

  QueryAnnouncementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _status = $v.status;
      _adminId = $v.adminId;
      _pageNum = $v.pageNum;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueryAnnouncementRequest other) {
    _$v = other as _$QueryAnnouncementRequest;
  }

  @override
  void update(void Function(QueryAnnouncementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueryAnnouncementRequest build() => _build();

  _$QueryAnnouncementRequest _build() {
    final _$result =
        _$v ??
        _$QueryAnnouncementRequest._(
          title: title,
          status: status,
          adminId: adminId,
          pageNum: pageNum,
          pageSize: pageSize,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
