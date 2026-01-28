// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_learning_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseLearningStats extends BaseResponseLearningStats {
  @override
  final int? code;
  @override
  final LearningStats? data;
  @override
  final String? message;

  factory _$BaseResponseLearningStats([
    void Function(BaseResponseLearningStatsBuilder)? updates,
  ]) => (BaseResponseLearningStatsBuilder()..update(updates))._build();

  _$BaseResponseLearningStats._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseLearningStats rebuild(
    void Function(BaseResponseLearningStatsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseLearningStatsBuilder toBuilder() =>
      BaseResponseLearningStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseLearningStats &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseLearningStats')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseLearningStatsBuilder
    implements
        Builder<BaseResponseLearningStats, BaseResponseLearningStatsBuilder> {
  _$BaseResponseLearningStats? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  LearningStatsBuilder? _data;
  LearningStatsBuilder get data => _$this._data ??= LearningStatsBuilder();
  set data(LearningStatsBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseLearningStatsBuilder() {
    BaseResponseLearningStats._defaults(this);
  }

  BaseResponseLearningStatsBuilder get _$this {
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
  void replace(BaseResponseLearningStats other) {
    _$v = other as _$BaseResponseLearningStats;
  }

  @override
  void update(void Function(BaseResponseLearningStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseLearningStats build() => _build();

  _$BaseResponseLearningStats _build() {
    _$BaseResponseLearningStats _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseLearningStats._(
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
          r'BaseResponseLearningStats',
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
