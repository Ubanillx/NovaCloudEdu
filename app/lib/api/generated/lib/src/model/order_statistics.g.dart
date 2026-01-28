// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_statistics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderStatistics extends OrderStatistics {
  @override
  final int? unpaidCount;
  @override
  final int? paidCount;
  @override
  final int? expiredCount;
  @override
  final int? refundedCount;

  factory _$OrderStatistics([void Function(OrderStatisticsBuilder)? updates]) =>
      (OrderStatisticsBuilder()..update(updates))._build();

  _$OrderStatistics._({
    this.unpaidCount,
    this.paidCount,
    this.expiredCount,
    this.refundedCount,
  }) : super._();
  @override
  OrderStatistics rebuild(void Function(OrderStatisticsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderStatisticsBuilder toBuilder() => OrderStatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderStatistics &&
        unpaidCount == other.unpaidCount &&
        paidCount == other.paidCount &&
        expiredCount == other.expiredCount &&
        refundedCount == other.refundedCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unpaidCount.hashCode);
    _$hash = $jc(_$hash, paidCount.hashCode);
    _$hash = $jc(_$hash, expiredCount.hashCode);
    _$hash = $jc(_$hash, refundedCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderStatistics')
          ..add('unpaidCount', unpaidCount)
          ..add('paidCount', paidCount)
          ..add('expiredCount', expiredCount)
          ..add('refundedCount', refundedCount))
        .toString();
  }
}

class OrderStatisticsBuilder
    implements Builder<OrderStatistics, OrderStatisticsBuilder> {
  _$OrderStatistics? _$v;

  int? _unpaidCount;
  int? get unpaidCount => _$this._unpaidCount;
  set unpaidCount(int? unpaidCount) => _$this._unpaidCount = unpaidCount;

  int? _paidCount;
  int? get paidCount => _$this._paidCount;
  set paidCount(int? paidCount) => _$this._paidCount = paidCount;

  int? _expiredCount;
  int? get expiredCount => _$this._expiredCount;
  set expiredCount(int? expiredCount) => _$this._expiredCount = expiredCount;

  int? _refundedCount;
  int? get refundedCount => _$this._refundedCount;
  set refundedCount(int? refundedCount) =>
      _$this._refundedCount = refundedCount;

  OrderStatisticsBuilder() {
    OrderStatistics._defaults(this);
  }

  OrderStatisticsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unpaidCount = $v.unpaidCount;
      _paidCount = $v.paidCount;
      _expiredCount = $v.expiredCount;
      _refundedCount = $v.refundedCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderStatistics other) {
    _$v = other as _$OrderStatistics;
  }

  @override
  void update(void Function(OrderStatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderStatistics build() => _build();

  _$OrderStatistics _build() {
    final _$result =
        _$v ??
        _$OrderStatistics._(
          unpaidCount: unpaidCount,
          paidCount: paidCount,
          expiredCount: expiredCount,
          refundedCount: refundedCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
