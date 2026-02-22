// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_permission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckPermissionRequest extends CheckPermissionRequest {
  @override
  final int? callerId;
  @override
  final int? calleeId;

  factory _$CheckPermissionRequest([
    void Function(CheckPermissionRequestBuilder)? updates,
  ]) => (CheckPermissionRequestBuilder()..update(updates))._build();

  _$CheckPermissionRequest._({this.callerId, this.calleeId}) : super._();
  @override
  CheckPermissionRequest rebuild(
    void Function(CheckPermissionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CheckPermissionRequestBuilder toBuilder() =>
      CheckPermissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckPermissionRequest &&
        callerId == other.callerId &&
        calleeId == other.calleeId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, callerId.hashCode);
    _$hash = $jc(_$hash, calleeId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckPermissionRequest')
          ..add('callerId', callerId)
          ..add('calleeId', calleeId))
        .toString();
  }
}

class CheckPermissionRequestBuilder
    implements Builder<CheckPermissionRequest, CheckPermissionRequestBuilder> {
  _$CheckPermissionRequest? _$v;

  int? _callerId;
  int? get callerId => _$this._callerId;
  set callerId(int? callerId) => _$this._callerId = callerId;

  int? _calleeId;
  int? get calleeId => _$this._calleeId;
  set calleeId(int? calleeId) => _$this._calleeId = calleeId;

  CheckPermissionRequestBuilder() {
    CheckPermissionRequest._defaults(this);
  }

  CheckPermissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _callerId = $v.callerId;
      _calleeId = $v.calleeId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckPermissionRequest other) {
    _$v = other as _$CheckPermissionRequest;
  }

  @override
  void update(void Function(CheckPermissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckPermissionRequest build() => _build();

  _$CheckPermissionRequest _build() {
    final _$result =
        _$v ??
        _$CheckPermissionRequest._(callerId: callerId, calleeId: calleeId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
