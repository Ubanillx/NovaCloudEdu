// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_node_type_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListNodeTypeResponse
    extends BaseResponseListNodeTypeResponse {
  @override
  final int? code;
  @override
  final BuiltList<NodeTypeResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListNodeTypeResponse([
    void Function(BaseResponseListNodeTypeResponseBuilder)? updates,
  ]) => (BaseResponseListNodeTypeResponseBuilder()..update(updates))._build();

  _$BaseResponseListNodeTypeResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListNodeTypeResponse rebuild(
    void Function(BaseResponseListNodeTypeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListNodeTypeResponseBuilder toBuilder() =>
      BaseResponseListNodeTypeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListNodeTypeResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListNodeTypeResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListNodeTypeResponseBuilder
    implements
        Builder<
          BaseResponseListNodeTypeResponse,
          BaseResponseListNodeTypeResponseBuilder
        > {
  _$BaseResponseListNodeTypeResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<NodeTypeResponse>? _data;
  ListBuilder<NodeTypeResponse> get data =>
      _$this._data ??= ListBuilder<NodeTypeResponse>();
  set data(ListBuilder<NodeTypeResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListNodeTypeResponseBuilder() {
    BaseResponseListNodeTypeResponse._defaults(this);
  }

  BaseResponseListNodeTypeResponseBuilder get _$this {
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
  void replace(BaseResponseListNodeTypeResponse other) {
    _$v = other as _$BaseResponseListNodeTypeResponse;
  }

  @override
  void update(void Function(BaseResponseListNodeTypeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListNodeTypeResponse build() => _build();

  _$BaseResponseListNodeTypeResponse _build() {
    _$BaseResponseListNodeTypeResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListNodeTypeResponse._(
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
          r'BaseResponseListNodeTypeResponse',
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
