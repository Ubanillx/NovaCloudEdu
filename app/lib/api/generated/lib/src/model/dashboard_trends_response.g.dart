// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_trends_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DashboardTrendsResponse extends DashboardTrendsResponse {
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? userGrowth;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? activeTrend;
  @override
  final BuiltList<BuiltMap<String, JsonObject>>? revenueTrend;

  factory _$DashboardTrendsResponse([
    void Function(DashboardTrendsResponseBuilder)? updates,
  ]) => (DashboardTrendsResponseBuilder()..update(updates))._build();

  _$DashboardTrendsResponse._({
    this.userGrowth,
    this.activeTrend,
    this.revenueTrend,
  }) : super._();
  @override
  DashboardTrendsResponse rebuild(
    void Function(DashboardTrendsResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DashboardTrendsResponseBuilder toBuilder() =>
      DashboardTrendsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DashboardTrendsResponse &&
        userGrowth == other.userGrowth &&
        activeTrend == other.activeTrend &&
        revenueTrend == other.revenueTrend;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userGrowth.hashCode);
    _$hash = $jc(_$hash, activeTrend.hashCode);
    _$hash = $jc(_$hash, revenueTrend.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DashboardTrendsResponse')
          ..add('userGrowth', userGrowth)
          ..add('activeTrend', activeTrend)
          ..add('revenueTrend', revenueTrend))
        .toString();
  }
}

class DashboardTrendsResponseBuilder
    implements
        Builder<DashboardTrendsResponse, DashboardTrendsResponseBuilder> {
  _$DashboardTrendsResponse? _$v;

  ListBuilder<BuiltMap<String, JsonObject>>? _userGrowth;
  ListBuilder<BuiltMap<String, JsonObject>> get userGrowth =>
      _$this._userGrowth ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set userGrowth(ListBuilder<BuiltMap<String, JsonObject>>? userGrowth) =>
      _$this._userGrowth = userGrowth;

  ListBuilder<BuiltMap<String, JsonObject>>? _activeTrend;
  ListBuilder<BuiltMap<String, JsonObject>> get activeTrend =>
      _$this._activeTrend ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set activeTrend(ListBuilder<BuiltMap<String, JsonObject>>? activeTrend) =>
      _$this._activeTrend = activeTrend;

  ListBuilder<BuiltMap<String, JsonObject>>? _revenueTrend;
  ListBuilder<BuiltMap<String, JsonObject>> get revenueTrend =>
      _$this._revenueTrend ??= ListBuilder<BuiltMap<String, JsonObject>>();
  set revenueTrend(ListBuilder<BuiltMap<String, JsonObject>>? revenueTrend) =>
      _$this._revenueTrend = revenueTrend;

  DashboardTrendsResponseBuilder() {
    DashboardTrendsResponse._defaults(this);
  }

  DashboardTrendsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userGrowth = $v.userGrowth?.toBuilder();
      _activeTrend = $v.activeTrend?.toBuilder();
      _revenueTrend = $v.revenueTrend?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DashboardTrendsResponse other) {
    _$v = other as _$DashboardTrendsResponse;
  }

  @override
  void update(void Function(DashboardTrendsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DashboardTrendsResponse build() => _build();

  _$DashboardTrendsResponse _build() {
    _$DashboardTrendsResponse _$result;
    try {
      _$result =
          _$v ??
          _$DashboardTrendsResponse._(
            userGrowth: _userGrowth?.build(),
            activeTrend: _activeTrend?.build(),
            revenueTrend: _revenueTrend?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userGrowth';
        _userGrowth?.build();
        _$failedField = 'activeTrend';
        _activeTrend?.build();
        _$failedField = 'revenueTrend';
        _revenueTrend?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DashboardTrendsResponse',
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
