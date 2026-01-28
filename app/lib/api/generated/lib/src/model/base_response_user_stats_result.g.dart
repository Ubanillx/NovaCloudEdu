// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_user_stats_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseUserStatsResult extends BaseResponseUserStatsResult {
  @override
  final int? code;
  @override
  final UserStatsResult? data;
  @override
  final String? message;

  factory _$BaseResponseUserStatsResult([
    void Function(BaseResponseUserStatsResultBuilder)? updates,
  ]) => (BaseResponseUserStatsResultBuilder()..update(updates))._build();

  _$BaseResponseUserStatsResult._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseUserStatsResult rebuild(
    void Function(BaseResponseUserStatsResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseUserStatsResultBuilder toBuilder() =>
      BaseResponseUserStatsResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseUserStatsResult &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseUserStatsResult')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseUserStatsResultBuilder
    implements
        Builder<
          BaseResponseUserStatsResult,
          BaseResponseUserStatsResultBuilder
        > {
  _$BaseResponseUserStatsResult? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  UserStatsResultBuilder? _data;
  UserStatsResultBuilder get data => _$this._data ??= UserStatsResultBuilder();
  set data(UserStatsResultBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseUserStatsResultBuilder() {
    BaseResponseUserStatsResult._defaults(this);
  }

  BaseResponseUserStatsResultBuilder get _$this {
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
  void replace(BaseResponseUserStatsResult other) {
    _$v = other as _$BaseResponseUserStatsResult;
  }

  @override
  void update(void Function(BaseResponseUserStatsResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseUserStatsResult build() => _build();

  _$BaseResponseUserStatsResult _build() {
    _$BaseResponseUserStatsResult _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseUserStatsResult._(
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
          r'BaseResponseUserStatsResult',
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
