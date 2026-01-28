// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_post_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponsePostPageResponse extends BaseResponsePostPageResponse {
  @override
  final int? code;
  @override
  final PostPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponsePostPageResponse([
    void Function(BaseResponsePostPageResponseBuilder)? updates,
  ]) => (BaseResponsePostPageResponseBuilder()..update(updates))._build();

  _$BaseResponsePostPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponsePostPageResponse rebuild(
    void Function(BaseResponsePostPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponsePostPageResponseBuilder toBuilder() =>
      BaseResponsePostPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponsePostPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponsePostPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponsePostPageResponseBuilder
    implements
        Builder<
          BaseResponsePostPageResponse,
          BaseResponsePostPageResponseBuilder
        > {
  _$BaseResponsePostPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  PostPageResponseBuilder? _data;
  PostPageResponseBuilder get data =>
      _$this._data ??= PostPageResponseBuilder();
  set data(PostPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponsePostPageResponseBuilder() {
    BaseResponsePostPageResponse._defaults(this);
  }

  BaseResponsePostPageResponseBuilder get _$this {
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
  void replace(BaseResponsePostPageResponse other) {
    _$v = other as _$BaseResponsePostPageResponse;
  }

  @override
  void update(void Function(BaseResponsePostPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponsePostPageResponse build() => _build();

  _$BaseResponsePostPageResponse _build() {
    _$BaseResponsePostPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponsePostPageResponse._(
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
          r'BaseResponsePostPageResponse',
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
