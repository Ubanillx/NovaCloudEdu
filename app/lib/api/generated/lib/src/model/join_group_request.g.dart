// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_group_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JoinGroupRequest extends JoinGroupRequest {
  @override
  final String? message;

  factory _$JoinGroupRequest([
    void Function(JoinGroupRequestBuilder)? updates,
  ]) => (JoinGroupRequestBuilder()..update(updates))._build();

  _$JoinGroupRequest._({this.message}) : super._();
  @override
  JoinGroupRequest rebuild(void Function(JoinGroupRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JoinGroupRequestBuilder toBuilder() =>
      JoinGroupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JoinGroupRequest && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'JoinGroupRequest',
    )..add('message', message)).toString();
  }
}

class JoinGroupRequestBuilder
    implements Builder<JoinGroupRequest, JoinGroupRequestBuilder> {
  _$JoinGroupRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JoinGroupRequestBuilder() {
    JoinGroupRequest._defaults(this);
  }

  JoinGroupRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JoinGroupRequest other) {
    _$v = other as _$JoinGroupRequest;
  }

  @override
  void update(void Function(JoinGroupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JoinGroupRequest build() => _build();

  _$JoinGroupRequest _build() {
    final _$result = _$v ?? _$JoinGroupRequest._(message: message);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
