// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_handling_config_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ErrorHandlingConfigDTOOnErrorEnum
_$errorHandlingConfigDTOOnErrorEnum_STOP =
    const ErrorHandlingConfigDTOOnErrorEnum._('STOP');
const ErrorHandlingConfigDTOOnErrorEnum
_$errorHandlingConfigDTOOnErrorEnum_RETRY =
    const ErrorHandlingConfigDTOOnErrorEnum._('RETRY');
const ErrorHandlingConfigDTOOnErrorEnum
_$errorHandlingConfigDTOOnErrorEnum_SKIP =
    const ErrorHandlingConfigDTOOnErrorEnum._('SKIP');
const ErrorHandlingConfigDTOOnErrorEnum
_$errorHandlingConfigDTOOnErrorEnum_FALLBACK =
    const ErrorHandlingConfigDTOOnErrorEnum._('FALLBACK');

ErrorHandlingConfigDTOOnErrorEnum _$errorHandlingConfigDTOOnErrorEnumValueOf(
  String name,
) {
  switch (name) {
    case 'STOP':
      return _$errorHandlingConfigDTOOnErrorEnum_STOP;
    case 'RETRY':
      return _$errorHandlingConfigDTOOnErrorEnum_RETRY;
    case 'SKIP':
      return _$errorHandlingConfigDTOOnErrorEnum_SKIP;
    case 'FALLBACK':
      return _$errorHandlingConfigDTOOnErrorEnum_FALLBACK;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ErrorHandlingConfigDTOOnErrorEnum>
_$errorHandlingConfigDTOOnErrorEnumValues =
    BuiltSet<ErrorHandlingConfigDTOOnErrorEnum>(
      const <ErrorHandlingConfigDTOOnErrorEnum>[
        _$errorHandlingConfigDTOOnErrorEnum_STOP,
        _$errorHandlingConfigDTOOnErrorEnum_RETRY,
        _$errorHandlingConfigDTOOnErrorEnum_SKIP,
        _$errorHandlingConfigDTOOnErrorEnum_FALLBACK,
      ],
    );

Serializer<ErrorHandlingConfigDTOOnErrorEnum>
_$errorHandlingConfigDTOOnErrorEnumSerializer =
    _$ErrorHandlingConfigDTOOnErrorEnumSerializer();

class _$ErrorHandlingConfigDTOOnErrorEnumSerializer
    implements PrimitiveSerializer<ErrorHandlingConfigDTOOnErrorEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'STOP': 'STOP',
    'RETRY': 'RETRY',
    'SKIP': 'SKIP',
    'FALLBACK': 'FALLBACK',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'STOP': 'STOP',
    'RETRY': 'RETRY',
    'SKIP': 'SKIP',
    'FALLBACK': 'FALLBACK',
  };

  @override
  final Iterable<Type> types = const <Type>[ErrorHandlingConfigDTOOnErrorEnum];
  @override
  final String wireName = 'ErrorHandlingConfigDTOOnErrorEnum';

  @override
  Object serialize(
    Serializers serializers,
    ErrorHandlingConfigDTOOnErrorEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ErrorHandlingConfigDTOOnErrorEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ErrorHandlingConfigDTOOnErrorEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ErrorHandlingConfigDTO extends ErrorHandlingConfigDTO {
  @override
  final ErrorHandlingConfigDTOOnErrorEnum? onError;
  @override
  final int? retryCount;
  @override
  final int? retryDelayMs;
  @override
  final String? fallbackNodeId;
  @override
  final int? timeoutMs;

  factory _$ErrorHandlingConfigDTO([
    void Function(ErrorHandlingConfigDTOBuilder)? updates,
  ]) => (ErrorHandlingConfigDTOBuilder()..update(updates))._build();

  _$ErrorHandlingConfigDTO._({
    this.onError,
    this.retryCount,
    this.retryDelayMs,
    this.fallbackNodeId,
    this.timeoutMs,
  }) : super._();
  @override
  ErrorHandlingConfigDTO rebuild(
    void Function(ErrorHandlingConfigDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ErrorHandlingConfigDTOBuilder toBuilder() =>
      ErrorHandlingConfigDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorHandlingConfigDTO &&
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
    return (newBuiltValueToStringHelper(r'ErrorHandlingConfigDTO')
          ..add('onError', onError)
          ..add('retryCount', retryCount)
          ..add('retryDelayMs', retryDelayMs)
          ..add('fallbackNodeId', fallbackNodeId)
          ..add('timeoutMs', timeoutMs))
        .toString();
  }
}

class ErrorHandlingConfigDTOBuilder
    implements Builder<ErrorHandlingConfigDTO, ErrorHandlingConfigDTOBuilder> {
  _$ErrorHandlingConfigDTO? _$v;

  ErrorHandlingConfigDTOOnErrorEnum? _onError;
  ErrorHandlingConfigDTOOnErrorEnum? get onError => _$this._onError;
  set onError(ErrorHandlingConfigDTOOnErrorEnum? onError) =>
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

  ErrorHandlingConfigDTOBuilder() {
    ErrorHandlingConfigDTO._defaults(this);
  }

  ErrorHandlingConfigDTOBuilder get _$this {
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
  void replace(ErrorHandlingConfigDTO other) {
    _$v = other as _$ErrorHandlingConfigDTO;
  }

  @override
  void update(void Function(ErrorHandlingConfigDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorHandlingConfigDTO build() => _build();

  _$ErrorHandlingConfigDTO _build() {
    final _$result =
        _$v ??
        _$ErrorHandlingConfigDTO._(
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
