// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_config_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TimeConfigItem extends TimeConfigItem {
  @override
  final int? section;
  @override
  final String? start;
  @override
  final String? end;

  factory _$TimeConfigItem([void Function(TimeConfigItemBuilder)? updates]) =>
      (TimeConfigItemBuilder()..update(updates))._build();

  _$TimeConfigItem._({this.section, this.start, this.end}) : super._();
  @override
  TimeConfigItem rebuild(void Function(TimeConfigItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TimeConfigItemBuilder toBuilder() => TimeConfigItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TimeConfigItem &&
        section == other.section &&
        start == other.start &&
        end == other.end;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, section.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TimeConfigItem')
          ..add('section', section)
          ..add('start', start)
          ..add('end', end))
        .toString();
  }
}

class TimeConfigItemBuilder
    implements Builder<TimeConfigItem, TimeConfigItemBuilder> {
  _$TimeConfigItem? _$v;

  int? _section;
  int? get section => _$this._section;
  set section(int? section) => _$this._section = section;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  String? _end;
  String? get end => _$this._end;
  set end(String? end) => _$this._end = end;

  TimeConfigItemBuilder() {
    TimeConfigItem._defaults(this);
  }

  TimeConfigItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _section = $v.section;
      _start = $v.start;
      _end = $v.end;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TimeConfigItem other) {
    _$v = other as _$TimeConfigItem;
  }

  @override
  void update(void Function(TimeConfigItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TimeConfigItem build() => _build();

  _$TimeConfigItem _build() {
    final _$result =
        _$v ?? _$TimeConfigItem._(section: section, start: start, end: end);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
