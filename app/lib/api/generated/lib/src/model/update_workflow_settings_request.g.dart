// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_workflow_settings_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateWorkflowSettingsRequestLogLevelEnum
_$updateWorkflowSettingsRequestLogLevelEnum_DEBUG =
    const UpdateWorkflowSettingsRequestLogLevelEnum._('DEBUG');
const UpdateWorkflowSettingsRequestLogLevelEnum
_$updateWorkflowSettingsRequestLogLevelEnum_INFO =
    const UpdateWorkflowSettingsRequestLogLevelEnum._('INFO');
const UpdateWorkflowSettingsRequestLogLevelEnum
_$updateWorkflowSettingsRequestLogLevelEnum_WARN =
    const UpdateWorkflowSettingsRequestLogLevelEnum._('WARN');
const UpdateWorkflowSettingsRequestLogLevelEnum
_$updateWorkflowSettingsRequestLogLevelEnum_ERROR =
    const UpdateWorkflowSettingsRequestLogLevelEnum._('ERROR');

UpdateWorkflowSettingsRequestLogLevelEnum
_$updateWorkflowSettingsRequestLogLevelEnumValueOf(String name) {
  switch (name) {
    case 'DEBUG':
      return _$updateWorkflowSettingsRequestLogLevelEnum_DEBUG;
    case 'INFO':
      return _$updateWorkflowSettingsRequestLogLevelEnum_INFO;
    case 'WARN':
      return _$updateWorkflowSettingsRequestLogLevelEnum_WARN;
    case 'ERROR':
      return _$updateWorkflowSettingsRequestLogLevelEnum_ERROR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateWorkflowSettingsRequestLogLevelEnum>
_$updateWorkflowSettingsRequestLogLevelEnumValues =
    BuiltSet<UpdateWorkflowSettingsRequestLogLevelEnum>(
      const <UpdateWorkflowSettingsRequestLogLevelEnum>[
        _$updateWorkflowSettingsRequestLogLevelEnum_DEBUG,
        _$updateWorkflowSettingsRequestLogLevelEnum_INFO,
        _$updateWorkflowSettingsRequestLogLevelEnum_WARN,
        _$updateWorkflowSettingsRequestLogLevelEnum_ERROR,
      ],
    );

Serializer<UpdateWorkflowSettingsRequestLogLevelEnum>
_$updateWorkflowSettingsRequestLogLevelEnumSerializer =
    _$UpdateWorkflowSettingsRequestLogLevelEnumSerializer();

class _$UpdateWorkflowSettingsRequestLogLevelEnumSerializer
    implements PrimitiveSerializer<UpdateWorkflowSettingsRequestLogLevelEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'DEBUG': 'DEBUG',
    'INFO': 'INFO',
    'WARN': 'WARN',
    'ERROR': 'ERROR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'DEBUG': 'DEBUG',
    'INFO': 'INFO',
    'WARN': 'WARN',
    'ERROR': 'ERROR',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateWorkflowSettingsRequestLogLevelEnum,
  ];
  @override
  final String wireName = 'UpdateWorkflowSettingsRequestLogLevelEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateWorkflowSettingsRequestLogLevelEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateWorkflowSettingsRequestLogLevelEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateWorkflowSettingsRequestLogLevelEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateWorkflowSettingsRequest extends UpdateWorkflowSettingsRequest {
  @override
  final int? maxExecutionTimeMs;
  @override
  final bool? enableLogging;
  @override
  final UpdateWorkflowSettingsRequestLogLevelEnum? logLevel;
  @override
  final bool? enableDebug;

  factory _$UpdateWorkflowSettingsRequest([
    void Function(UpdateWorkflowSettingsRequestBuilder)? updates,
  ]) => (UpdateWorkflowSettingsRequestBuilder()..update(updates))._build();

  _$UpdateWorkflowSettingsRequest._({
    this.maxExecutionTimeMs,
    this.enableLogging,
    this.logLevel,
    this.enableDebug,
  }) : super._();
  @override
  UpdateWorkflowSettingsRequest rebuild(
    void Function(UpdateWorkflowSettingsRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateWorkflowSettingsRequestBuilder toBuilder() =>
      UpdateWorkflowSettingsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateWorkflowSettingsRequest &&
        maxExecutionTimeMs == other.maxExecutionTimeMs &&
        enableLogging == other.enableLogging &&
        logLevel == other.logLevel &&
        enableDebug == other.enableDebug;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, maxExecutionTimeMs.hashCode);
    _$hash = $jc(_$hash, enableLogging.hashCode);
    _$hash = $jc(_$hash, logLevel.hashCode);
    _$hash = $jc(_$hash, enableDebug.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateWorkflowSettingsRequest')
          ..add('maxExecutionTimeMs', maxExecutionTimeMs)
          ..add('enableLogging', enableLogging)
          ..add('logLevel', logLevel)
          ..add('enableDebug', enableDebug))
        .toString();
  }
}

class UpdateWorkflowSettingsRequestBuilder
    implements
        Builder<
          UpdateWorkflowSettingsRequest,
          UpdateWorkflowSettingsRequestBuilder
        > {
  _$UpdateWorkflowSettingsRequest? _$v;

  int? _maxExecutionTimeMs;
  int? get maxExecutionTimeMs => _$this._maxExecutionTimeMs;
  set maxExecutionTimeMs(int? maxExecutionTimeMs) =>
      _$this._maxExecutionTimeMs = maxExecutionTimeMs;

  bool? _enableLogging;
  bool? get enableLogging => _$this._enableLogging;
  set enableLogging(bool? enableLogging) =>
      _$this._enableLogging = enableLogging;

  UpdateWorkflowSettingsRequestLogLevelEnum? _logLevel;
  UpdateWorkflowSettingsRequestLogLevelEnum? get logLevel => _$this._logLevel;
  set logLevel(UpdateWorkflowSettingsRequestLogLevelEnum? logLevel) =>
      _$this._logLevel = logLevel;

  bool? _enableDebug;
  bool? get enableDebug => _$this._enableDebug;
  set enableDebug(bool? enableDebug) => _$this._enableDebug = enableDebug;

  UpdateWorkflowSettingsRequestBuilder() {
    UpdateWorkflowSettingsRequest._defaults(this);
  }

  UpdateWorkflowSettingsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _maxExecutionTimeMs = $v.maxExecutionTimeMs;
      _enableLogging = $v.enableLogging;
      _logLevel = $v.logLevel;
      _enableDebug = $v.enableDebug;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateWorkflowSettingsRequest other) {
    _$v = other as _$UpdateWorkflowSettingsRequest;
  }

  @override
  void update(void Function(UpdateWorkflowSettingsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateWorkflowSettingsRequest build() => _build();

  _$UpdateWorkflowSettingsRequest _build() {
    final _$result =
        _$v ??
        _$UpdateWorkflowSettingsRequest._(
          maxExecutionTimeMs: maxExecutionTimeMs,
          enableLogging: enableLogging,
          logLevel: logLevel,
          enableDebug: enableDebug,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
