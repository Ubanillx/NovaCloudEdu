// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_batch_process_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseBatchProcessResult extends BaseResponseBatchProcessResult {
  @override
  final int? code;
  @override
  final BatchProcessResult? data;
  @override
  final String? message;

  factory _$BaseResponseBatchProcessResult([
    void Function(BaseResponseBatchProcessResultBuilder)? updates,
  ]) => (BaseResponseBatchProcessResultBuilder()..update(updates))._build();

  _$BaseResponseBatchProcessResult._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseBatchProcessResult rebuild(
    void Function(BaseResponseBatchProcessResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseBatchProcessResultBuilder toBuilder() =>
      BaseResponseBatchProcessResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseBatchProcessResult &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseBatchProcessResult')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseBatchProcessResultBuilder
    implements
        Builder<
          BaseResponseBatchProcessResult,
          BaseResponseBatchProcessResultBuilder
        > {
  _$BaseResponseBatchProcessResult? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  BatchProcessResultBuilder? _data;
  BatchProcessResultBuilder get data =>
      _$this._data ??= BatchProcessResultBuilder();
  set data(BatchProcessResultBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseBatchProcessResultBuilder() {
    BaseResponseBatchProcessResult._defaults(this);
  }

  BaseResponseBatchProcessResultBuilder get _$this {
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
  void replace(BaseResponseBatchProcessResult other) {
    _$v = other as _$BaseResponseBatchProcessResult;
  }

  @override
  void update(void Function(BaseResponseBatchProcessResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseBatchProcessResult build() => _build();

  _$BaseResponseBatchProcessResult _build() {
    _$BaseResponseBatchProcessResult _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseBatchProcessResult._(
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
          r'BaseResponseBatchProcessResult',
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
