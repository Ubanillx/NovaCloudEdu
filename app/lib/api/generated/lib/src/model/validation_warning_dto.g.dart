// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_warning_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ValidationWarningDTO extends ValidationWarningDTO {
  @override
  final String? code;
  @override
  final String? message;
  @override
  final String? nodeId;

  factory _$ValidationWarningDTO([
    void Function(ValidationWarningDTOBuilder)? updates,
  ]) => (ValidationWarningDTOBuilder()..update(updates))._build();

  _$ValidationWarningDTO._({this.code, this.message, this.nodeId}) : super._();
  @override
  ValidationWarningDTO rebuild(
    void Function(ValidationWarningDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ValidationWarningDTOBuilder toBuilder() =>
      ValidationWarningDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ValidationWarningDTO &&
        code == other.code &&
        message == other.message &&
        nodeId == other.nodeId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, nodeId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ValidationWarningDTO')
          ..add('code', code)
          ..add('message', message)
          ..add('nodeId', nodeId))
        .toString();
  }
}

class ValidationWarningDTOBuilder
    implements Builder<ValidationWarningDTO, ValidationWarningDTOBuilder> {
  _$ValidationWarningDTO? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _nodeId;
  String? get nodeId => _$this._nodeId;
  set nodeId(String? nodeId) => _$this._nodeId = nodeId;

  ValidationWarningDTOBuilder() {
    ValidationWarningDTO._defaults(this);
  }

  ValidationWarningDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _message = $v.message;
      _nodeId = $v.nodeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ValidationWarningDTO other) {
    _$v = other as _$ValidationWarningDTO;
  }

  @override
  void update(void Function(ValidationWarningDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ValidationWarningDTO build() => _build();

  _$ValidationWarningDTO _build() {
    final _$result =
        _$v ??
        _$ValidationWarningDTO._(code: code, message: message, nodeId: nodeId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
