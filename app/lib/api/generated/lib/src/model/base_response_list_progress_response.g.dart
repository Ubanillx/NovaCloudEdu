// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_progress_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListProgressResponse
    extends BaseResponseListProgressResponse {
  @override
  final int? code;
  @override
  final BuiltList<ProgressResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListProgressResponse([
    void Function(BaseResponseListProgressResponseBuilder)? updates,
  ]) => (BaseResponseListProgressResponseBuilder()..update(updates))._build();

  _$BaseResponseListProgressResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListProgressResponse rebuild(
    void Function(BaseResponseListProgressResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListProgressResponseBuilder toBuilder() =>
      BaseResponseListProgressResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListProgressResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListProgressResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListProgressResponseBuilder
    implements
        Builder<
          BaseResponseListProgressResponse,
          BaseResponseListProgressResponseBuilder
        > {
  _$BaseResponseListProgressResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ProgressResponse>? _data;
  ListBuilder<ProgressResponse> get data =>
      _$this._data ??= ListBuilder<ProgressResponse>();
  set data(ListBuilder<ProgressResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListProgressResponseBuilder() {
    BaseResponseListProgressResponse._defaults(this);
  }

  BaseResponseListProgressResponseBuilder get _$this {
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
  void replace(BaseResponseListProgressResponse other) {
    _$v = other as _$BaseResponseListProgressResponse;
  }

  @override
  void update(void Function(BaseResponseListProgressResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListProgressResponse build() => _build();

  _$BaseResponseListProgressResponse _build() {
    _$BaseResponseListProgressResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListProgressResponse._(
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
          r'BaseResponseListProgressResponse',
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
