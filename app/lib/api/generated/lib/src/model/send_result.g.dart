// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendResult extends SendResult {
  @override
  final bool? success;
  @override
  final String? requestId;
  @override
  final String? errorMsg;

  factory _$SendResult([void Function(SendResultBuilder)? updates]) =>
      (SendResultBuilder()..update(updates))._build();

  _$SendResult._({this.success, this.requestId, this.errorMsg}) : super._();
  @override
  SendResult rebuild(void Function(SendResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendResultBuilder toBuilder() => SendResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendResult &&
        success == other.success &&
        requestId == other.requestId &&
        errorMsg == other.errorMsg;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jc(_$hash, errorMsg.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendResult')
          ..add('success', success)
          ..add('requestId', requestId)
          ..add('errorMsg', errorMsg))
        .toString();
  }
}

class SendResultBuilder implements Builder<SendResult, SendResultBuilder> {
  _$SendResult? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  String? _requestId;
  String? get requestId => _$this._requestId;
  set requestId(String? requestId) => _$this._requestId = requestId;

  String? _errorMsg;
  String? get errorMsg => _$this._errorMsg;
  set errorMsg(String? errorMsg) => _$this._errorMsg = errorMsg;

  SendResultBuilder() {
    SendResult._defaults(this);
  }

  SendResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _requestId = $v.requestId;
      _errorMsg = $v.errorMsg;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendResult other) {
    _$v = other as _$SendResult;
  }

  @override
  void update(void Function(SendResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendResult build() => _build();

  _$SendResult _build() {
    final _$result = _$v ??
        _$SendResult._(
          success: success,
          requestId: requestId,
          errorMsg: errorMsg,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
