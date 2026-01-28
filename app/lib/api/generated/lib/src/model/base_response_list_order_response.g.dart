// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_order_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListOrderResponse extends BaseResponseListOrderResponse {
  @override
  final int? code;
  @override
  final BuiltList<OrderResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListOrderResponse([
    void Function(BaseResponseListOrderResponseBuilder)? updates,
  ]) => (BaseResponseListOrderResponseBuilder()..update(updates))._build();

  _$BaseResponseListOrderResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListOrderResponse rebuild(
    void Function(BaseResponseListOrderResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListOrderResponseBuilder toBuilder() =>
      BaseResponseListOrderResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListOrderResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListOrderResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListOrderResponseBuilder
    implements
        Builder<
          BaseResponseListOrderResponse,
          BaseResponseListOrderResponseBuilder
        > {
  _$BaseResponseListOrderResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<OrderResponse>? _data;
  ListBuilder<OrderResponse> get data =>
      _$this._data ??= ListBuilder<OrderResponse>();
  set data(ListBuilder<OrderResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListOrderResponseBuilder() {
    BaseResponseListOrderResponse._defaults(this);
  }

  BaseResponseListOrderResponseBuilder get _$this {
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
  void replace(BaseResponseListOrderResponse other) {
    _$v = other as _$BaseResponseListOrderResponse;
  }

  @override
  void update(void Function(BaseResponseListOrderResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListOrderResponse build() => _build();

  _$BaseResponseListOrderResponse _build() {
    _$BaseResponseListOrderResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListOrderResponse._(
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
          r'BaseResponseListOrderResponse',
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
