// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_word_book_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseWordBookStats extends BaseResponseWordBookStats {
  @override
  final int? code;
  @override
  final WordBookStats? data;
  @override
  final String? message;

  factory _$BaseResponseWordBookStats([
    void Function(BaseResponseWordBookStatsBuilder)? updates,
  ]) => (BaseResponseWordBookStatsBuilder()..update(updates))._build();

  _$BaseResponseWordBookStats._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseWordBookStats rebuild(
    void Function(BaseResponseWordBookStatsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseWordBookStatsBuilder toBuilder() =>
      BaseResponseWordBookStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseWordBookStats &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseWordBookStats')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseWordBookStatsBuilder
    implements
        Builder<BaseResponseWordBookStats, BaseResponseWordBookStatsBuilder> {
  _$BaseResponseWordBookStats? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  WordBookStatsBuilder? _data;
  WordBookStatsBuilder get data => _$this._data ??= WordBookStatsBuilder();
  set data(WordBookStatsBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseWordBookStatsBuilder() {
    BaseResponseWordBookStats._defaults(this);
  }

  BaseResponseWordBookStatsBuilder get _$this {
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
  void replace(BaseResponseWordBookStats other) {
    _$v = other as _$BaseResponseWordBookStats;
  }

  @override
  void update(void Function(BaseResponseWordBookStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseWordBookStats build() => _build();

  _$BaseResponseWordBookStats _build() {
    _$BaseResponseWordBookStats _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseWordBookStats._(
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
          r'BaseResponseWordBookStats',
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
