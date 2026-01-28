// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_process_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BatchProcessResult extends BatchProcessResult {
  @override
  final int? total;
  @override
  final BuiltList<int>? successIds;
  @override
  final BuiltList<FailedItem>? failedItems;
  @override
  final int? failedCount;
  @override
  final int? successCount;

  factory _$BatchProcessResult([
    void Function(BatchProcessResultBuilder)? updates,
  ]) => (BatchProcessResultBuilder()..update(updates))._build();

  _$BatchProcessResult._({
    this.total,
    this.successIds,
    this.failedItems,
    this.failedCount,
    this.successCount,
  }) : super._();
  @override
  BatchProcessResult rebuild(
    void Function(BatchProcessResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BatchProcessResultBuilder toBuilder() =>
      BatchProcessResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BatchProcessResult &&
        total == other.total &&
        successIds == other.successIds &&
        failedItems == other.failedItems &&
        failedCount == other.failedCount &&
        successCount == other.successCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, successIds.hashCode);
    _$hash = $jc(_$hash, failedItems.hashCode);
    _$hash = $jc(_$hash, failedCount.hashCode);
    _$hash = $jc(_$hash, successCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BatchProcessResult')
          ..add('total', total)
          ..add('successIds', successIds)
          ..add('failedItems', failedItems)
          ..add('failedCount', failedCount)
          ..add('successCount', successCount))
        .toString();
  }
}

class BatchProcessResultBuilder
    implements Builder<BatchProcessResult, BatchProcessResultBuilder> {
  _$BatchProcessResult? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  ListBuilder<int>? _successIds;
  ListBuilder<int> get successIds => _$this._successIds ??= ListBuilder<int>();
  set successIds(ListBuilder<int>? successIds) =>
      _$this._successIds = successIds;

  ListBuilder<FailedItem>? _failedItems;
  ListBuilder<FailedItem> get failedItems =>
      _$this._failedItems ??= ListBuilder<FailedItem>();
  set failedItems(ListBuilder<FailedItem>? failedItems) =>
      _$this._failedItems = failedItems;

  int? _failedCount;
  int? get failedCount => _$this._failedCount;
  set failedCount(int? failedCount) => _$this._failedCount = failedCount;

  int? _successCount;
  int? get successCount => _$this._successCount;
  set successCount(int? successCount) => _$this._successCount = successCount;

  BatchProcessResultBuilder() {
    BatchProcessResult._defaults(this);
  }

  BatchProcessResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _successIds = $v.successIds?.toBuilder();
      _failedItems = $v.failedItems?.toBuilder();
      _failedCount = $v.failedCount;
      _successCount = $v.successCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BatchProcessResult other) {
    _$v = other as _$BatchProcessResult;
  }

  @override
  void update(void Function(BatchProcessResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BatchProcessResult build() => _build();

  _$BatchProcessResult _build() {
    _$BatchProcessResult _$result;
    try {
      _$result =
          _$v ??
          _$BatchProcessResult._(
            total: total,
            successIds: _successIds?.build(),
            failedItems: _failedItems?.build(),
            failedCount: failedCount,
            successCount: successCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'successIds';
        _successIds?.build();
        _$failedField = 'failedItems';
        _failedItems?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BatchProcessResult',
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
