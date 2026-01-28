// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_handling_config.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ErrorHandlingConfigOnErrorEnum _$errorHandlingConfigOnErrorEnum_STOP =
    const ErrorHandlingConfigOnErrorEnum._('STOP');
const ErrorHandlingConfigOnErrorEnum _$errorHandlingConfigOnErrorEnum_CONTINUE =
    const ErrorHandlingConfigOnErrorEnum._('CONTINUE');
const ErrorHandlingConfigOnErrorEnum _$errorHandlingConfigOnErrorEnum_RETRY =
    const ErrorHandlingConfigOnErrorEnum._('RETRY');
const ErrorHandlingConfigOnErrorEnum _$errorHandlingConfigOnErrorEnum_FALLBACK =
    const ErrorHandlingConfigOnErrorEnum._('FALLBACK');

ErrorHandlingConfigOnErrorEnum _$errorHandlingConfigOnErrorEnumValueOf(
  String name,
) {
  switch (name) {
    case 'STOP':
      return _$errorHandlingConfigOnErrorEnum_STOP;
    case 'CONTINUE':
      return _$errorHandlingConfigOnErrorEnum_CONTINUE;
    case 'RETRY':
      return _$errorHandlingConfigOnErrorEnum_RETRY;
    case 'FALLBACK':
      return _$errorHandlingConfigOnErrorEnum_FALLBACK;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ErrorHandlingConfigOnErrorEnum>
_$errorHandlingConfigOnErrorEnumValues =
    BuiltSet<ErrorHandlingConfigOnErrorEnum>(
      const <ErrorHandlingConfigOnErrorEnum>[
        _$errorHandlingConfigOnErrorEnum_STOP,
        _$errorHandlingConfigOnErrorEnum_CONTINUE,
        _$errorHandlingConfigOnErrorEnum_RETRY,
        _$errorHandlingConfigOnErrorEnum_FALLBACK,
      ],
    );

Serializer<ErrorHandlingConfigOnErrorEnum>
_$errorHandlingConfigOnErrorEnumSerializer =
    _$ErrorHandlingConfigOnErrorEnumSerializer();

class _$ErrorHandlingConfigOnErrorEnumSerializer
    implements PrimitiveSerializer<ErrorHandlingConfigOnErrorEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'STOP': 'STOP',
    'CONTINUE': 'CONTINUE',
    'RETRY': 'RETRY',
    'FALLBACK': 'FALLBACK',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'STOP': 'STOP',
    'CONTINUE': 'CONTINUE',
    'RETRY': 'RETRY',
    'FALLBACK': 'FALLBACK',
  };

  @override
  final Iterable<Type> types = const <Type>[ErrorHandlingConfigOnErrorEnum];
  @override
  final String wireName = 'ErrorHandlingConfigOnErrorEnum';

  @override
  Object serialize(
    Serializers serializers,
    ErrorHandlingConfigOnErrorEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ErrorHandlingConfigOnErrorEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ErrorHandlingConfigOnErrorEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ErrorHandlingConfig extends ErrorHandlingConfig {
  @override
  final ErrorHandlingConfigOnErrorEnum? onError;
  @override
  final int? retryCount;
  @override
  final int? retryDelayMs;
  @override
  final String? fallbackNodeId;
  @override
  final int? timeoutMs;

  factory _$ErrorHandlingConfig([
    void Function(ErrorHandlingConfigBuilder)? updates,
  ]) => (ErrorHandlingConfigBuilder()..update(updates))._build();

  _$ErrorHandlingConfig._({
    this.onError,
    this.retryCount,
    this.retryDelayMs,
    this.fallbackNodeId,
    this.timeoutMs,
  }) : super._();
  @override
  ErrorHandlingConfig rebuild(
    void Function(ErrorHandlingConfigBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ErrorHandlingConfigBuilder toBuilder() =>
      ErrorHandlingConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorHandlingConfig &&
        onError == other.onError &&
        retryCount == other.retryCount &&
        retryDelayMs == other.retryDelayMs &&
        fallbackNodeId == other.fallbackNodeId &&
        timeoutMs == other.timeoutMs;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, onError.hashCode);
    _$hash = $jc(_$hash, retryCount.hashCode);
    _$hash = $jc(_$hash, retryDelayMs.hashCode);
    _$hash = $jc(_$hash, fallbackNodeId.hashCode);
    _$hash = $jc(_$hash, timeoutMs.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorHandlingConfig')
          ..add('onError', onError)
          ..add('retryCount', retryCount)
          ..add('retryDelayMs', retryDelayMs)
          ..add('fallbackNodeId', fallbackNodeId)
          ..add('timeoutMs', timeoutMs))
        .toString();
  }
}

class ErrorHandlingConfigBuilder
    implements Builder<ErrorHandlingConfig, ErrorHandlingConfigBuilder> {
  _$ErrorHandlingConfig? _$v;

  ErrorHandlingConfigOnErrorEnum? _onError;
  ErrorHandlingConfigOnErrorEnum? get onError => _$this._onError;
  set onError(ErrorHandlingConfigOnErrorEnum? onError) =>
      _$this._onError = onError;

  int? _retryCount;
  int? get retryCount => _$this._retryCount;
  set retryCount(int? retryCount) => _$this._retryCount = retryCount;

  int? _retryDelayMs;
  int? get retryDelayMs => _$this._retryDelayMs;
  set retryDelayMs(int? retryDelayMs) => _$this._retryDelayMs = retryDelayMs;

  String? _fallbackNodeId;
  String? get fallbackNodeId => _$this._fallbackNodeId;
  set fallbackNodeId(String? fallbackNodeId) =>
      _$this._fallbackNodeId = fallbackNodeId;

  int? _timeoutMs;
  int? get timeoutMs => _$this._timeoutMs;
  set timeoutMs(int? timeoutMs) => _$this._timeoutMs = timeoutMs;

  ErrorHandlingConfigBuilder() {
    ErrorHandlingConfig._defaults(this);
  }

  ErrorHandlingConfigBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _onError = $v.onError;
      _retryCount = $v.retryCount;
      _retryDelayMs = $v.retryDelayMs;
      _fallbackNodeId = $v.fallbackNodeId;
      _timeoutMs = $v.timeoutMs;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorHandlingConfig other) {
    _$v = other as _$ErrorHandlingConfig;
  }

  @override
  void update(void Function(ErrorHandlingConfigBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorHandlingConfig build() => _build();

  _$ErrorHandlingConfig _build() {
    final _$result =
        _$v ??
        _$ErrorHandlingConfig._(
          onError: onError,
          retryCount: retryCount,
          retryDelayMs: retryDelayMs,
          fallbackNodeId: fallbackNodeId,
          timeoutMs: timeoutMs,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
