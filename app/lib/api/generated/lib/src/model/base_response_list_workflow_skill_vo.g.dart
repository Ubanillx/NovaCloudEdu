// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_workflow_skill_vo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListWorkflowSkillVO
    extends BaseResponseListWorkflowSkillVO {
  @override
  final int? code;
  @override
  final BuiltList<WorkflowSkillVO>? data;
  @override
  final String? message;

  factory _$BaseResponseListWorkflowSkillVO([
    void Function(BaseResponseListWorkflowSkillVOBuilder)? updates,
  ]) => (BaseResponseListWorkflowSkillVOBuilder()..update(updates))._build();

  _$BaseResponseListWorkflowSkillVO._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListWorkflowSkillVO rebuild(
    void Function(BaseResponseListWorkflowSkillVOBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListWorkflowSkillVOBuilder toBuilder() =>
      BaseResponseListWorkflowSkillVOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListWorkflowSkillVO &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListWorkflowSkillVO')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListWorkflowSkillVOBuilder
    implements
        Builder<
          BaseResponseListWorkflowSkillVO,
          BaseResponseListWorkflowSkillVOBuilder
        > {
  _$BaseResponseListWorkflowSkillVO? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<WorkflowSkillVO>? _data;
  ListBuilder<WorkflowSkillVO> get data =>
      _$this._data ??= ListBuilder<WorkflowSkillVO>();
  set data(ListBuilder<WorkflowSkillVO>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListWorkflowSkillVOBuilder() {
    BaseResponseListWorkflowSkillVO._defaults(this);
  }

  BaseResponseListWorkflowSkillVOBuilder get _$this {
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
  void replace(BaseResponseListWorkflowSkillVO other) {
    _$v = other as _$BaseResponseListWorkflowSkillVO;
  }

  @override
  void update(void Function(BaseResponseListWorkflowSkillVOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListWorkflowSkillVO build() => _build();

  _$BaseResponseListWorkflowSkillVO _build() {
    _$BaseResponseListWorkflowSkillVO _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListWorkflowSkillVO._(
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
          r'BaseResponseListWorkflowSkillVO',
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
