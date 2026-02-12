// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_param_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SkillParamVO extends SkillParamVO {
  @override
  final String? name;
  @override
  final String? type;
  @override
  final String? description;
  @override
  final bool? required_;
  @override
  final String? defaultValue;

  factory _$SkillParamVO([void Function(SkillParamVOBuilder)? updates]) =>
      (SkillParamVOBuilder()..update(updates))._build();

  _$SkillParamVO._({
    this.name,
    this.type,
    this.description,
    this.required_,
    this.defaultValue,
  }) : super._();
  @override
  SkillParamVO rebuild(void Function(SkillParamVOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SkillParamVOBuilder toBuilder() => SkillParamVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SkillParamVO &&
        name == other.name &&
        type == other.type &&
        description == other.description &&
        required_ == other.required_ &&
        defaultValue == other.defaultValue;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, required_.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SkillParamVO')
          ..add('name', name)
          ..add('type', type)
          ..add('description', description)
          ..add('required_', required_)
          ..add('defaultValue', defaultValue))
        .toString();
  }
}

class SkillParamVOBuilder
    implements Builder<SkillParamVO, SkillParamVOBuilder> {
  _$SkillParamVO? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _required_;
  bool? get required_ => _$this._required_;
  set required_(bool? required_) => _$this._required_ = required_;

  String? _defaultValue;
  String? get defaultValue => _$this._defaultValue;
  set defaultValue(String? defaultValue) => _$this._defaultValue = defaultValue;

  SkillParamVOBuilder() {
    SkillParamVO._defaults(this);
  }

  SkillParamVOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _type = $v.type;
      _description = $v.description;
      _required_ = $v.required_;
      _defaultValue = $v.defaultValue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SkillParamVO other) {
    _$v = other as _$SkillParamVO;
  }

  @override
  void update(void Function(SkillParamVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SkillParamVO build() => _build();

  _$SkillParamVO _build() {
    final _$result =
        _$v ??
        _$SkillParamVO._(
          name: name,
          type: type,
          description: description,
          required_: required_,
          defaultValue: defaultValue,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
