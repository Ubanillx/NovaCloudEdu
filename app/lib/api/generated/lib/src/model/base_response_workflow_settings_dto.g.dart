// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_workflow_settings_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWorkflowSettingsDTO
    extends BaseResponseWorkflowSettingsDTO {
  @override
  final int? code;
  @override
  final WorkflowSettingsDTO? data;
  @override
  final String? message;

  factory _$BaseResponseWorkflowSettingsDTO([
    void Function(BaseResponseWorkflowSettingsDTOBuilder)? updates,
  ]) => (BaseResponseWorkflowSettingsDTOBuilder()..update(updates))._build();

  _$BaseResponseWorkflowSettingsDTO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWorkflowSettingsDTO rebuild(
    void Function(BaseResponseWorkflowSettingsDTOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWorkflowSettingsDTOBuilder toBuilder() =>
      BaseResponseWorkflowSettingsDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWorkflowSettingsDTO &&
        code == other.code &&
        data == other.data &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BaseResponseWorkflowSettingsDTO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWorkflowSettingsDTOBuilder
    implements
        Builder<
          BaseResponseWorkflowSettingsDTO,
          BaseResponseWorkflowSettingsDTOBuilder
        > {
  _$BaseResponseWorkflowSettingsDTO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WorkflowSettingsDTOBuilder? _data;
  WorkflowSettingsDTOBuilder get data =>
      _$this._data ??= WorkflowSettingsDTOBuilder();
  set data(WorkflowSettingsDTOBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWorkflowSettingsDTOBuilder() {
    BaseResponseWorkflowSettingsDTO._defaults(this);
  }

  BaseResponseWorkflowSettingsDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _data = $v.data?.toBuilder();
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BaseResponseWorkflowSettingsDTO other) {
    _$v = other as _$BaseResponseWorkflowSettingsDTO;
  }

  @override
  void update(void Function(BaseResponseWorkflowSettingsDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWorkflowSettingsDTO build() => _build();

  _$BaseResponseWorkflowSettingsDTO _build() {
    _$BaseResponseWorkflowSettingsDTO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWorkflowSettingsDTO._(
            code: code,
            data: _data?.build(),
            message: message,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'BaseResponseWorkflowSettingsDTO',
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
