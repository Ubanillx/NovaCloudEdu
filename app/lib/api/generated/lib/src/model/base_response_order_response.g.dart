// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_order_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseOrderResponse extends BaseResponseOrderResponse {
  @override
  final int? code;
  @override
  final OrderResponse? data;
  @override
  final String? message;

  factory _$BaseResponseOrderResponse([
    void Function(BaseResponseOrderResponseBuilder)? updates,
  ]) => (BaseResponseOrderResponseBuilder()..update(updates))._build();

  _$BaseResponseOrderResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseOrderResponse rebuild(
    void Function(BaseResponseOrderResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseOrderResponseBuilder toBuilder() =>
      BaseResponseOrderResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseOrderResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseOrderResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseOrderResponseBuilder
    implements
        Builder<BaseResponseOrderResponse, BaseResponseOrderResponseBuilder> {
  _$BaseResponseOrderResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  OrderResponseBuilder? _data;
  OrderResponseBuilder get data => _$this._data ??= OrderResponseBuilder();
  set data(OrderResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseOrderResponseBuilder() {
    BaseResponseOrderResponse._defaults(this);
  }

  BaseResponseOrderResponseBuilder get _$this {
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
  void replace(BaseResponseOrderResponse other) {
    _$v = other as _$BaseResponseOrderResponse;
  }

  @override
  void update(void Function(BaseResponseOrderResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseOrderResponse build() => _build();

  _$BaseResponseOrderResponse _build() {
    _$BaseResponseOrderResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseOrderResponse._(
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
          r'BaseResponseOrderResponse',
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
