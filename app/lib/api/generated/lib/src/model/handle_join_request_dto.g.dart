// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handle_join_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HandleJoinRequestDTO extends HandleJoinRequestDTO {
  @override
  final bool approve;

  factory _$HandleJoinRequestDTO([
    void Function(HandleJoinRequestDTOBuilder)? updates,
  ]) => (HandleJoinRequestDTOBuilder()..update(updates))._build();

  _$HandleJoinRequestDTO._({required this.approve}) : super._();
  @override
  HandleJoinRequestDTO rebuild(
    void Function(HandleJoinRequestDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HandleJoinRequestDTOBuilder toBuilder() =>
      HandleJoinRequestDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HandleJoinRequestDTO && approve == other.approve;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, approve.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HandleJoinRequestDTO',
    )..add('approve', approve)).toString();
  }
}

class HandleJoinRequestDTOBuilder
    implements Builder<HandleJoinRequestDTO, HandleJoinRequestDTOBuilder> {
  _$HandleJoinRequestDTO? _$v;

  bool? _approve;
  bool? get approve => _$this._approve;
  set approve(bool? approve) => _$this._approve = approve;

  HandleJoinRequestDTOBuilder() {
    HandleJoinRequestDTO._defaults(this);
  }

  HandleJoinRequestDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _approve = $v.approve;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HandleJoinRequestDTO other) {
    _$v = other as _$HandleJoinRequestDTO;
  }

  @override
  void update(void Function(HandleJoinRequestDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HandleJoinRequestDTO build() => _build();

  _$HandleJoinRequestDTO _build() {
    final _$result =
        _$v ??
        _$HandleJoinRequestDTO._(
          approve: BuiltValueNullFieldError.checkNotNull(
            approve,
            r'HandleJoinRequestDTO',
            'approve',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
