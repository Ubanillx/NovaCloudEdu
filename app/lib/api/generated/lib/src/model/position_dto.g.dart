// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PositionDTO extends PositionDTO {
  @override
  final int? x;
  @override
  final int? y;

  factory _$PositionDTO([void Function(PositionDTOBuilder)? updates]) =>
      (PositionDTOBuilder()..update(updates))._build();

  _$PositionDTO._({this.x, this.y}) : super._();
  @override
  PositionDTO rebuild(void Function(PositionDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PositionDTOBuilder toBuilder() => PositionDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PositionDTO && x == other.x && y == other.y;
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
    return (newBuiltValueToStringHelper(r'PositionDTO')
          ..add('x', x)
          ..add('y', y))
        .toString();
  }
}

class PositionDTOBuilder implements Builder<PositionDTO, PositionDTOBuilder> {
  _$PositionDTO? _$v;

  int? _x;
  int? get x => _$this._x;
  set x(int? x) => _$this._x = x;

  int? _y;
  int? get y => _$this._y;
  set y(int? y) => _$this._y = y;

  PositionDTOBuilder() {
    PositionDTO._defaults(this);
  }

  PositionDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _x = $v.x;
      _y = $v.y;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PositionDTO other) {
    _$v = other as _$PositionDTO;
  }

  @override
  void update(void Function(PositionDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PositionDTO build() => _build();

  _$PositionDTO _build() {
    final _$result = _$v ?? _$PositionDTO._(x: x, y: y);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
