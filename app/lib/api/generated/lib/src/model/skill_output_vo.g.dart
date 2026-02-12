// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_output_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SkillOutputVO extends SkillOutputVO {
  @override
  final String? name;
  @override
  final String? sourceVariable;

  factory _$SkillOutputVO([void Function(SkillOutputVOBuilder)? updates]) =>
      (SkillOutputVOBuilder()..update(updates))._build();

  _$SkillOutputVO._({this.name, this.sourceVariable}) : super._();
  @override
  SkillOutputVO rebuild(void Function(SkillOutputVOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SkillOutputVOBuilder toBuilder() => SkillOutputVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SkillOutputVO &&
        name == other.name &&
        sourceVariable == other.sourceVariable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, sourceVariable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SkillOutputVO')
          ..add('name', name)
          ..add('sourceVariable', sourceVariable))
        .toString();
  }
}

class SkillOutputVOBuilder
    implements Builder<SkillOutputVO, SkillOutputVOBuilder> {
  _$SkillOutputVO? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _sourceVariable;
  String? get sourceVariable => _$this._sourceVariable;
  set sourceVariable(String? sourceVariable) =>
      _$this._sourceVariable = sourceVariable;

  SkillOutputVOBuilder() {
    SkillOutputVO._defaults(this);
  }

  SkillOutputVOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _sourceVariable = $v.sourceVariable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SkillOutputVO other) {
    _$v = other as _$SkillOutputVO;
  }

  @override
  void update(void Function(SkillOutputVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SkillOutputVO build() => _build();

  _$SkillOutputVO _build() {
    final _$result =
        _$v ?? _$SkillOutputVO._(name: name, sourceVariable: sourceVariable);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
