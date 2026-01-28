// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sse_emitter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SseEmitter extends SseEmitter {
  @override
  final int? timeout;

  factory _$SseEmitter([void Function(SseEmitterBuilder)? updates]) =>
      (SseEmitterBuilder()..update(updates))._build();

  _$SseEmitter._({this.timeout}) : super._();
  @override
  SseEmitter rebuild(void Function(SseEmitterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SseEmitterBuilder toBuilder() => SseEmitterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SseEmitter && timeout == other.timeout;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, timeout.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SseEmitter',
    )..add('timeout', timeout)).toString();
  }
}

class SseEmitterBuilder implements Builder<SseEmitter, SseEmitterBuilder> {
  _$SseEmitter? _$v;

  int? _timeout;
  int? get timeout => _$this._timeout;
  set timeout(int? timeout) => _$this._timeout = timeout;

  SseEmitterBuilder() {
    SseEmitter._defaults(this);
  }

  SseEmitterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _timeout = $v.timeout;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SseEmitter other) {
    _$v = other as _$SseEmitter;
  }

  @override
  void update(void Function(SseEmitterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SseEmitter build() => _build();

  _$SseEmitter _build() {
    final _$result = _$v ?? _$SseEmitter._(timeout: timeout);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
