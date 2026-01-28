// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_reading_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseReadingStats extends BaseResponseReadingStats {
  @override
  final int? code;
  @override
  final ReadingStats? data;
  @override
  final String? message;

  factory _$BaseResponseReadingStats([
    void Function(BaseResponseReadingStatsBuilder)? updates,
  ]) => (BaseResponseReadingStatsBuilder()..update(updates))._build();

  _$BaseResponseReadingStats._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseReadingStats rebuild(
    void Function(BaseResponseReadingStatsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseReadingStatsBuilder toBuilder() =>
      BaseResponseReadingStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseReadingStats &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseReadingStats')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseReadingStatsBuilder
    implements
        Builder<BaseResponseReadingStats, BaseResponseReadingStatsBuilder> {
  _$BaseResponseReadingStats? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ReadingStatsBuilder? _data;
  ReadingStatsBuilder get data => _$this._data ??= ReadingStatsBuilder();
  set data(ReadingStatsBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseReadingStatsBuilder() {
    BaseResponseReadingStats._defaults(this);
  }

  BaseResponseReadingStatsBuilder get _$this {
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
  void replace(BaseResponseReadingStats other) {
    _$v = other as _$BaseResponseReadingStats;
  }

  @override
  void update(void Function(BaseResponseReadingStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseReadingStats build() => _build();

  _$BaseResponseReadingStats _build() {
    _$BaseResponseReadingStats _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseReadingStats._(
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
          r'BaseResponseReadingStats',
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
