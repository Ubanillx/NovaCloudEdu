// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_order_statistics.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseOrderStatistics extends BaseResponseOrderStatistics {
  @override
  final int? code;
  @override
  final OrderStatistics? data;
  @override
  final String? message;

  factory _$BaseResponseOrderStatistics([
    void Function(BaseResponseOrderStatisticsBuilder)? updates,
  ]) => (BaseResponseOrderStatisticsBuilder()..update(updates))._build();

  _$BaseResponseOrderStatistics._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseOrderStatistics rebuild(
    void Function(BaseResponseOrderStatisticsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseOrderStatisticsBuilder toBuilder() =>
      BaseResponseOrderStatisticsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseOrderStatistics &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseOrderStatistics')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseOrderStatisticsBuilder
    implements
        Builder<
          BaseResponseOrderStatistics,
          BaseResponseOrderStatisticsBuilder
        > {
  _$BaseResponseOrderStatistics? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  OrderStatisticsBuilder? _data;
  OrderStatisticsBuilder get data => _$this._data ??= OrderStatisticsBuilder();
  set data(OrderStatisticsBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseOrderStatisticsBuilder() {
    BaseResponseOrderStatistics._defaults(this);
  }

  BaseResponseOrderStatisticsBuilder get _$this {
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
  void replace(BaseResponseOrderStatistics other) {
    _$v = other as _$BaseResponseOrderStatistics;
  }

  @override
  void update(void Function(BaseResponseOrderStatisticsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseOrderStatistics build() => _build();

  _$BaseResponseOrderStatistics _build() {
    _$BaseResponseOrderStatistics _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseOrderStatistics._(
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
          r'BaseResponseOrderStatistics',
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
