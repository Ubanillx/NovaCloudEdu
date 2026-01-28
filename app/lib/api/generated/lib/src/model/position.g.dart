// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Position extends Position {
  @override
  final int? x;
  @override
  final int? y;

  factory _$Position([void Function(PositionBuilder)? updates]) =>
      (PositionBuilder()..update(updates))._build();

  _$Position._({this.x, this.y}) : super._();
  @override
  Position rebuild(void Function(PositionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PositionBuilder toBuilder() => PositionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Position && x == other.x && y == other.y;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, x.hashCode);
    _$hash = $jc(_$hash, y.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Position')
          ..add('x', x)
          ..add('y', y))
        .toString();
  }
}

class PositionBuilder implements Builder<Position, PositionBuilder> {
  _$Position? _$v;

  int? _x;
  int? get x => _$this._x;
  set x(int? x) => _$this._x = x;

  int? _y;
  int? get y => _$this._y;
  set y(int? y) => _$this._y = y;

  PositionBuilder() {
    Position._defaults(this);
  }

  PositionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _x = $v.x;
      _y = $v.y;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Position other) {
    _$v = other as _$Position;
  }

  @override
  void update(void Function(PositionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Position build() => _build();

  _$Position _build() {
    final _$result = _$v ?? _$Position._(x: x, y: y);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
