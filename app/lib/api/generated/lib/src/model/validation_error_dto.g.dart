// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ValidationErrorDTO extends ValidationErrorDTO {
  @override
  final String? code;
  @override
  final String? message;
  @override
  final String? nodeId;
  @override
  final String? edgeId;

  factory _$ValidationErrorDTO([
    void Function(ValidationErrorDTOBuilder)? updates,
  ]) => (ValidationErrorDTOBuilder()..update(updates))._build();

  _$ValidationErrorDTO._({this.code, this.message, this.nodeId, this.edgeId})
    : super._();
  @override
  ValidationErrorDTO rebuild(
    void Function(ValidationErrorDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ValidationErrorDTOBuilder toBuilder() =>
      ValidationErrorDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ValidationErrorDTO &&
        code == other.code &&
        message == other.message &&
        nodeId == other.nodeId &&
        edgeId == other.edgeId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, nodeId.hashCode);
    _$hash = $jc(_$hash, edgeId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ValidationErrorDTO')
          ..add('code', code)
          ..add('message', message)
          ..add('nodeId', nodeId)
          ..add('edgeId', edgeId))
        .toString();
  }
}

class ValidationErrorDTOBuilder
    implements Builder<ValidationErrorDTO, ValidationErrorDTOBuilder> {
  _$ValidationErrorDTO? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _nodeId;
  String? get nodeId => _$this._nodeId;
  set nodeId(String? nodeId) => _$this._nodeId = nodeId;

  String? _edgeId;
  String? get edgeId => _$this._edgeId;
  set edgeId(String? edgeId) => _$this._edgeId = edgeId;

  ValidationErrorDTOBuilder() {
    ValidationErrorDTO._defaults(this);
  }

  ValidationErrorDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _message = $v.message;
      _nodeId = $v.nodeId;
      _edgeId = $v.edgeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ValidationErrorDTO other) {
    _$v = other as _$ValidationErrorDTO;
  }

  @override
  void update(void Function(ValidationErrorDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ValidationErrorDTO build() => _build();

  _$ValidationErrorDTO _build() {
    final _$result =
        _$v ??
        _$ValidationErrorDTO._(
          code: code,
          message: message,
          nodeId: nodeId,
          edgeId: edgeId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
