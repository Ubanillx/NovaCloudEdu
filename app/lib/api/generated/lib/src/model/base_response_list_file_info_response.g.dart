// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_file_info_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListFileInfoResponse
    extends BaseResponseListFileInfoResponse {
  @override
  final int? code;
  @override
  final BuiltList<FileInfoResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListFileInfoResponse([
    void Function(BaseResponseListFileInfoResponseBuilder)? updates,
  ]) => (BaseResponseListFileInfoResponseBuilder()..update(updates))._build();

  _$BaseResponseListFileInfoResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListFileInfoResponse rebuild(
    void Function(BaseResponseListFileInfoResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListFileInfoResponseBuilder toBuilder() =>
      BaseResponseListFileInfoResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListFileInfoResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListFileInfoResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListFileInfoResponseBuilder
    implements
        Builder<
          BaseResponseListFileInfoResponse,
          BaseResponseListFileInfoResponseBuilder
        > {
  _$BaseResponseListFileInfoResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<FileInfoResponse>? _data;
  ListBuilder<FileInfoResponse> get data =>
      _$this._data ??= ListBuilder<FileInfoResponse>();
  set data(ListBuilder<FileInfoResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListFileInfoResponseBuilder() {
    BaseResponseListFileInfoResponse._defaults(this);
  }

  BaseResponseListFileInfoResponseBuilder get _$this {
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
  void replace(BaseResponseListFileInfoResponse other) {
    _$v = other as _$BaseResponseListFileInfoResponse;
  }

  @override
  void update(void Function(BaseResponseListFileInfoResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListFileInfoResponse build() => _build();

  _$BaseResponseListFileInfoResponse _build() {
    _$BaseResponseListFileInfoResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListFileInfoResponse._(
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
          r'BaseResponseListFileInfoResponse',
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
