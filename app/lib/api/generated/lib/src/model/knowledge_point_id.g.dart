// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_point_id.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KnowledgePointId extends KnowledgePointId {
  @override
  final int? value;

  factory _$KnowledgePointId([
    void Function(KnowledgePointIdBuilder)? updates,
  ]) => (KnowledgePointIdBuilder()..update(updates))._build();

  _$KnowledgePointId._({this.value}) : super._();
  @override
  KnowledgePointId rebuild(void Function(KnowledgePointIdBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnowledgePointIdBuilder toBuilder() =>
      KnowledgePointIdBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnowledgePointId && value == other.value;
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
      r'KnowledgePointId',
    )..add('value', value)).toString();
  }
}

class KnowledgePointIdBuilder
    implements Builder<KnowledgePointId, KnowledgePointIdBuilder> {
  _$KnowledgePointId? _$v;

  int? _value;
  int? get value => _$this._value;
  set value(int? value) => _$this._value = value;

  KnowledgePointIdBuilder() {
    KnowledgePointId._defaults(this);
  }

  KnowledgePointIdBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnowledgePointId other) {
    _$v = other as _$KnowledgePointId;
  }

  @override
  void update(void Function(KnowledgePointIdBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnowledgePointId build() => _build();

  _$KnowledgePointId _build() {
    final _$result = _$v ?? _$KnowledgePointId._(value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
