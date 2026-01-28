// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execute_workflow_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExecuteWorkflowRequest extends ExecuteWorkflowRequest {
  @override
  final int userId;
  @override
  final BuiltMap<String, JsonObject>? input;

  factory _$ExecuteWorkflowRequest([
    void Function(ExecuteWorkflowRequestBuilder)? updates,
  ]) => (ExecuteWorkflowRequestBuilder()..update(updates))._build();

  _$ExecuteWorkflowRequest._({required this.userId, this.input}) : super._();
  @override
  ExecuteWorkflowRequest rebuild(
    void Function(ExecuteWorkflowRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExecuteWorkflowRequestBuilder toBuilder() =>
      ExecuteWorkflowRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecuteWorkflowRequest &&
        userId == other.userId &&
        input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExecuteWorkflowRequest')
          ..add('userId', userId)
          ..add('input', input))
        .toString();
  }
}

class ExecuteWorkflowRequestBuilder
    implements Builder<ExecuteWorkflowRequest, ExecuteWorkflowRequestBuilder> {
  _$ExecuteWorkflowRequest? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  MapBuilder<String, JsonObject>? _input;
  MapBuilder<String, JsonObject> get input =>
      _$this._input ??= MapBuilder<String, JsonObject>();
  set input(MapBuilder<String, JsonObject>? input) => _$this._input = input;

  ExecuteWorkflowRequestBuilder() {
    ExecuteWorkflowRequest._defaults(this);
  }

  ExecuteWorkflowRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _input = $v.input?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExecuteWorkflowRequest other) {
    _$v = other as _$ExecuteWorkflowRequest;
  }

  @override
  void update(void Function(ExecuteWorkflowRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExecuteWorkflowRequest build() => _build();

  _$ExecuteWorkflowRequest _build() {
    _$ExecuteWorkflowRequest _$result;
    try {
      _$result =
          _$v ??
          _$ExecuteWorkflowRequest._(
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'ExecuteWorkflowRequest',
              'userId',
            ),
            input: _input?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExecuteWorkflowRequest',
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
