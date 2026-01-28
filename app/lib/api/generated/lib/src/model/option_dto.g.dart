// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OptionDTO extends OptionDTO {
  @override
  final String? value;
  @override
  final String? label;

  factory _$OptionDTO([void Function(OptionDTOBuilder)? updates]) =>
      (OptionDTOBuilder()..update(updates))._build();

  _$OptionDTO._({this.value, this.label}) : super._();
  @override
  OptionDTO rebuild(void Function(OptionDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OptionDTOBuilder toBuilder() => OptionDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OptionDTO && value == other.value && label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OptionDTO')
          ..add('value', value)
          ..add('label', label))
        .toString();
  }
}

class OptionDTOBuilder implements Builder<OptionDTO, OptionDTOBuilder> {
  _$OptionDTO? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  OptionDTOBuilder() {
    OptionDTO._defaults(this);
  }

  OptionDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OptionDTO other) {
    _$v = other as _$OptionDTO;
  }

  @override
  void update(void Function(OptionDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OptionDTO build() => _build();

  _$OptionDTO _build() {
    final _$result = _$v ?? _$OptionDTO._(value: value, label: label);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
