// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GroupId extends GroupId {
  @override
  final int? value;

  factory _$GroupId([void Function(GroupIdBuilder)? updates]) =>
      (GroupIdBuilder()..update(updates))._build();

  _$GroupId._({this.value}) : super._();
  @override
  GroupId rebuild(void Function(GroupIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GroupIdBuilder toBuilder() => GroupIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GroupId && value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GroupId',
    )..add('value', value)).toString();
  }
}

class GroupIdBuilder implements Builder<GroupId, GroupIdBuilder> {
  _$GroupId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  GroupIdBuilder() {
    GroupId._defaults(this);
  }

  GroupIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GroupId other) {
    _$v = other as _$GroupId;
  }

  @override
  void update(void Function(GroupIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GroupId build() => _build();

  _$GroupId _build() {
    final _$result = _$v ?? _$GroupId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
