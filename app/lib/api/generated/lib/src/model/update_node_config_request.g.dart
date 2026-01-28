// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_node_config_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateNodeConfigRequest extends UpdateNodeConfigRequest {
  @override
  final BuiltMap<String, JsonObject> config;

  factory _$UpdateNodeConfigRequest([
    void Function(UpdateNodeConfigRequestBuilder)? updates,
  ]) => (UpdateNodeConfigRequestBuilder()..update(updates))._build();

  _$UpdateNodeConfigRequest._({required this.config}) : super._();
  @override
  UpdateNodeConfigRequest rebuild(
    void Function(UpdateNodeConfigRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateNodeConfigRequestBuilder toBuilder() =>
      UpdateNodeConfigRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateNodeConfigRequest && config == other.config;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, config.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UpdateNodeConfigRequest',
    )..add('config', config)).toString();
  }
}

class UpdateNodeConfigRequestBuilder
    implements
        Builder<UpdateNodeConfigRequest, UpdateNodeConfigRequestBuilder> {
  _$UpdateNodeConfigRequest? _$v;

  MapBuilder<String, JsonObject>? _config;
  MapBuilder<String, JsonObject> get config =>
      _$this._config ??= MapBuilder<String, JsonObject>();
  set config(MapBuilder<String, JsonObject>? config) => _$this._config = config;

  UpdateNodeConfigRequestBuilder() {
    UpdateNodeConfigRequest._defaults(this);
  }

  UpdateNodeConfigRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _config = $v.config.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateNodeConfigRequest other) {
    _$v = other as _$UpdateNodeConfigRequest;
  }

  @override
  void update(void Function(UpdateNodeConfigRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateNodeConfigRequest build() => _build();

  _$UpdateNodeConfigRequest _build() {
    _$UpdateNodeConfigRequest _$result;
    try {
      _$result = _$v ?? _$UpdateNodeConfigRequest._(config: config.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'config';
        config.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateNodeConfigRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
