// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execute_task_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExecuteTaskRequest extends ExecuteTaskRequest {
  @override
  final int configId;
  @override
  final int? maxArticles;

  factory _$ExecuteTaskRequest([
    void Function(ExecuteTaskRequestBuilder)? updates,
  ]) => (ExecuteTaskRequestBuilder()..update(updates))._build();

  _$ExecuteTaskRequest._({required this.configId, this.maxArticles})
    : super._();
  @override
  ExecuteTaskRequest rebuild(
    void Function(ExecuteTaskRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExecuteTaskRequestBuilder toBuilder() =>
      ExecuteTaskRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExecuteTaskRequest &&
        configId == other.configId &&
        maxArticles == other.maxArticles;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, configId.hashCode);
    _$hash = $jc(_$hash, maxArticles.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExecuteTaskRequest')
          ..add('configId', configId)
          ..add('maxArticles', maxArticles))
        .toString();
  }
}

class ExecuteTaskRequestBuilder
    implements Builder<ExecuteTaskRequest, ExecuteTaskRequestBuilder> {
  _$ExecuteTaskRequest? _$v;

  int? _configId;
  int? get configId => _$this._configId;
  set configId(int? configId) => _$this._configId = configId;

  int? _maxArticles;
  int? get maxArticles => _$this._maxArticles;
  set maxArticles(int? maxArticles) => _$this._maxArticles = maxArticles;

  ExecuteTaskRequestBuilder() {
    ExecuteTaskRequest._defaults(this);
  }

  ExecuteTaskRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _configId = $v.configId;
      _maxArticles = $v.maxArticles;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExecuteTaskRequest other) {
    _$v = other as _$ExecuteTaskRequest;
  }

  @override
  void update(void Function(ExecuteTaskRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExecuteTaskRequest build() => _build();

  _$ExecuteTaskRequest _build() {
    final _$result =
        _$v ??
        _$ExecuteTaskRequest._(
          configId: BuiltValueNullFieldError.checkNotNull(
            configId,
            r'ExecuteTaskRequest',
            'configId',
          ),
          maxArticles: maxArticles,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
