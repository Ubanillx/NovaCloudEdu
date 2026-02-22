// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_overview_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardOverviewResponse extends DashboardOverviewResponse {
  @override
  final int? totalUsers;
  @override
  final BuiltMap<String, int>? usersByRole;
  @override
  final int? todayNewUsers;
  @override
  final int? yesterdayNewUsers;
  @override
  final int? totalCourses;
  @override
  final BuiltMap<String, int>? coursesByStatus;
  @override
  final int? activeMembers;
  @override
  final BuiltMap<String, int>? membersByPlan;
  @override
  final int? todayOrders;
  @override
  final int? yesterdayOrders;
  @override
  final double? todayRevenue;
  @override
  final double? yesterdayRevenue;
  @override
  final int? todayDau;
  @override
  final int? yesterdayDau;
  @override
  final int? pendingFeedbacks;
  @override
  final int? myClassCount;
  @override
  final int? myStudentCount;

  factory _$DashboardOverviewResponse([
    void Function(DashboardOverviewResponseBuilder)? updates,
  ]) => (DashboardOverviewResponseBuilder()..update(updates))._build();

  _$DashboardOverviewResponse._({
    this.totalUsers,
    this.usersByRole,
    this.todayNewUsers,
    this.yesterdayNewUsers,
    this.totalCourses,
    this.coursesByStatus,
    this.activeMembers,
    this.membersByPlan,
    this.todayOrders,
    this.yesterdayOrders,
    this.todayRevenue,
    this.yesterdayRevenue,
    this.todayDau,
    this.yesterdayDau,
    this.pendingFeedbacks,
    this.myClassCount,
    this.myStudentCount,
  }) : super._();
  @override
  DashboardOverviewResponse rebuild(
    void Function(DashboardOverviewResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardOverviewResponseBuilder toBuilder() =>
      DashboardOverviewResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardOverviewResponse &&
        totalUsers == other.totalUsers &&
        usersByRole == other.usersByRole &&
        todayNewUsers == other.todayNewUsers &&
        yesterdayNewUsers == other.yesterdayNewUsers &&
        totalCourses == other.totalCourses &&
        coursesByStatus == other.coursesByStatus &&
        activeMembers == other.activeMembers &&
        membersByPlan == other.membersByPlan &&
        todayOrders == other.todayOrders &&
        yesterdayOrders == other.yesterdayOrders &&
        todayRevenue == other.todayRevenue &&
        yesterdayRevenue == other.yesterdayRevenue &&
        todayDau == other.todayDau &&
        yesterdayDau == other.yesterdayDau &&
        pendingFeedbacks == other.pendingFeedbacks &&
        myClassCount == other.myClassCount &&
        myStudentCount == other.myStudentCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalUsers.hashCode);
    _$hash = $jc(_$hash, usersByRole.hashCode);
    _$hash = $jc(_$hash, todayNewUsers.hashCode);
    _$hash = $jc(_$hash, yesterdayNewUsers.hashCode);
    _$hash = $jc(_$hash, totalCourses.hashCode);
    _$hash = $jc(_$hash, coursesByStatus.hashCode);
    _$hash = $jc(_$hash, activeMembers.hashCode);
    _$hash = $jc(_$hash, membersByPlan.hashCode);
    _$hash = $jc(_$hash, todayOrders.hashCode);
    _$hash = $jc(_$hash, yesterdayOrders.hashCode);
    _$hash = $jc(_$hash, todayRevenue.hashCode);
    _$hash = $jc(_$hash, yesterdayRevenue.hashCode);
    _$hash = $jc(_$hash, todayDau.hashCode);
    _$hash = $jc(_$hash, yesterdayDau.hashCode);
    _$hash = $jc(_$hash, pendingFeedbacks.hashCode);
    _$hash = $jc(_$hash, myClassCount.hashCode);
    _$hash = $jc(_$hash, myStudentCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardOverviewResponse')
          ..add('totalUsers', totalUsers)
          ..add('usersByRole', usersByRole)
          ..add('todayNewUsers', todayNewUsers)
          ..add('yesterdayNewUsers', yesterdayNewUsers)
          ..add('totalCourses', totalCourses)
          ..add('coursesByStatus', coursesByStatus)
          ..add('activeMembers', activeMembers)
          ..add('membersByPlan', membersByPlan)
          ..add('todayOrders', todayOrders)
          ..add('yesterdayOrders', yesterdayOrders)
          ..add('todayRevenue', todayRevenue)
          ..add('yesterdayRevenue', yesterdayRevenue)
          ..add('todayDau', todayDau)
          ..add('yesterdayDau', yesterdayDau)
          ..add('pendingFeedbacks', pendingFeedbacks)
          ..add('myClassCount', myClassCount)
          ..add('myStudentCount', myStudentCount))
        .toString();
  }
}

class DashboardOverviewResponseBuilder
    implements
        Builder<DashboardOverviewResponse, DashboardOverviewResponseBuilder> {
  _$DashboardOverviewResponse? _$v;

  int? _totalUsers;
  int? get totalUsers => _$this._totalUsers;
  set totalUsers(int? totalUsers) => _$this._totalUsers = totalUsers;

  MapBuilder<String, int>? _usersByRole;
  MapBuilder<String, int> get usersByRole =>
      _$this._usersByRole ??= MapBuilder<String, int>();
  set usersByRole(MapBuilder<String, int>? usersByRole) =>
      _$this._usersByRole = usersByRole;

  int? _todayNewUsers;
  int? get todayNewUsers => _$this._todayNewUsers;
  set todayNewUsers(int? todayNewUsers) =>
      _$this._todayNewUsers = todayNewUsers;

  int? _yesterdayNewUsers;
  int? get yesterdayNewUsers => _$this._yesterdayNewUsers;
  set yesterdayNewUsers(int? yesterdayNewUsers) =>
      _$this._yesterdayNewUsers = yesterdayNewUsers;

  int? _totalCourses;
  int? get totalCourses => _$this._totalCourses;
  set totalCourses(int? totalCourses) => _$this._totalCourses = totalCourses;

  MapBuilder<String, int>? _coursesByStatus;
  MapBuilder<String, int> get coursesByStatus =>
      _$this._coursesByStatus ??= MapBuilder<String, int>();
  set coursesByStatus(MapBuilder<String, int>? coursesByStatus) =>
      _$this._coursesByStatus = coursesByStatus;

  int? _activeMembers;
  int? get activeMembers => _$this._activeMembers;
  set activeMembers(int? activeMembers) =>
      _$this._activeMembers = activeMembers;

  MapBuilder<String, int>? _membersByPlan;
  MapBuilder<String, int> get membersByPlan =>
      _$this._membersByPlan ??= MapBuilder<String, int>();
  set membersByPlan(MapBuilder<String, int>? membersByPlan) =>
      _$this._membersByPlan = membersByPlan;

  int? _todayOrders;
  int? get todayOrders => _$this._todayOrders;
  set todayOrders(int? todayOrders) => _$this._todayOrders = todayOrders;

  int? _yesterdayOrders;
  int? get yesterdayOrders => _$this._yesterdayOrders;
  set yesterdayOrders(int? yesterdayOrders) =>
      _$this._yesterdayOrders = yesterdayOrders;

  double? _todayRevenue;
  double? get todayRevenue => _$this._todayRevenue;
  set todayRevenue(double? todayRevenue) => _$this._todayRevenue = todayRevenue;

  double? _yesterdayRevenue;
  double? get yesterdayRevenue => _$this._yesterdayRevenue;
  set yesterdayRevenue(double? yesterdayRevenue) =>
      _$this._yesterdayRevenue = yesterdayRevenue;

  int? _todayDau;
  int? get todayDau => _$this._todayDau;
  set todayDau(int? todayDau) => _$this._todayDau = todayDau;

  int? _yesterdayDau;
  int? get yesterdayDau => _$this._yesterdayDau;
  set yesterdayDau(int? yesterdayDau) => _$this._yesterdayDau = yesterdayDau;

  int? _pendingFeedbacks;
  int? get pendingFeedbacks => _$this._pendingFeedbacks;
  set pendingFeedbacks(int? pendingFeedbacks) =>
      _$this._pendingFeedbacks = pendingFeedbacks;

  int? _myClassCount;
  int? get myClassCount => _$this._myClassCount;
  set myClassCount(int? myClassCount) => _$this._myClassCount = myClassCount;

  int? _myStudentCount;
  int? get myStudentCount => _$this._myStudentCount;
  set myStudentCount(int? myStudentCount) =>
      _$this._myStudentCount = myStudentCount;

  DashboardOverviewResponseBuilder() {
    DashboardOverviewResponse._defaults(this);
  }

  DashboardOverviewResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalUsers = $v.totalUsers;
      _usersByRole = $v.usersByRole?.toBuilder();
      _todayNewUsers = $v.todayNewUsers;
      _yesterdayNewUsers = $v.yesterdayNewUsers;
      _totalCourses = $v.totalCourses;
      _coursesByStatus = $v.coursesByStatus?.toBuilder();
      _activeMembers = $v.activeMembers;
      _membersByPlan = $v.membersByPlan?.toBuilder();
      _todayOrders = $v.todayOrders;
      _yesterdayOrders = $v.yesterdayOrders;
      _todayRevenue = $v.todayRevenue;
      _yesterdayRevenue = $v.yesterdayRevenue;
      _todayDau = $v.todayDau;
      _yesterdayDau = $v.yesterdayDau;
      _pendingFeedbacks = $v.pendingFeedbacks;
      _myClassCount = $v.myClassCount;
      _myStudentCount = $v.myStudentCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardOverviewResponse other) {
    _$v = other as _$DashboardOverviewResponse;
  }

  @override
  void update(void Function(DashboardOverviewResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardOverviewResponse build() => _build();

  _$DashboardOverviewResponse _build() {
    _$DashboardOverviewResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardOverviewResponse._(
            totalUsers: totalUsers,
            usersByRole: _usersByRole?.build(),
            todayNewUsers: todayNewUsers,
            yesterdayNewUsers: yesterdayNewUsers,
            totalCourses: totalCourses,
            coursesByStatus: _coursesByStatus?.build(),
            activeMembers: activeMembers,
            membersByPlan: _membersByPlan?.build(),
            todayOrders: todayOrders,
            yesterdayOrders: yesterdayOrders,
            todayRevenue: todayRevenue,
            yesterdayRevenue: yesterdayRevenue,
            todayDau: todayDau,
            yesterdayDau: yesterdayDau,
            pendingFeedbacks: pendingFeedbacks,
            myClassCount: myClassCount,
            myStudentCount: myStudentCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'usersByRole';
        _usersByRole?.build();

        _$failedField = 'coursesByStatus';
        _coursesByStatus?.build();

        _$failedField = 'membersByPlan';
        _membersByPlan?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardOverviewResponse',
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
