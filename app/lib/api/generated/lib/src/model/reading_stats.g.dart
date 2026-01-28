// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReadingStats extends ReadingStats {
  @override
  final int? total;
  @override
  final int? read;

  factory _$ReadingStats([void Function(ReadingStatsBuilder)? updates]) =>
      (ReadingStatsBuilder()..update(updates))._build();

  _$ReadingStats._({this.total, this.read}) : super._();
  @override
  ReadingStats rebuild(void Function(ReadingStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReadingStatsBuilder toBuilder() => ReadingStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingStats && total == other.total && read == other.read;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, read.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReadingStats')
          ..add('total', total)
          ..add('read', read))
        .toString();
  }
}

class ReadingStatsBuilder
    implements Builder<ReadingStats, ReadingStatsBuilder> {
  _$ReadingStats? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _read;
  int? get read => _$this._read;
  set read(int? read) => _$this._read = read;

  ReadingStatsBuilder() {
    ReadingStats._defaults(this);
  }

  ReadingStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _read = $v.read;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReadingStats other) {
    _$v = other as _$ReadingStats;
  }

  @override
  void update(void Function(ReadingStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReadingStats build() => _build();

  _$ReadingStats _build() {
    final _$result = _$v ?? _$ReadingStats._(total: total, read: read);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
