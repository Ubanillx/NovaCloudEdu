// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_submission_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseSubmissionStatusResponse
    extends BaseResponseSubmissionStatusResponse {
  @override
  final int? code;
  @override
  final SubmissionStatusResponse? data;
  @override
  final String? message;

  factory _$BaseResponseSubmissionStatusResponse([
    void Function(BaseResponseSubmissionStatusResponseBuilder)? updates,
  ]) =>
      (BaseResponseSubmissionStatusResponseBuilder()..update(updates))._build();

  _$BaseResponseSubmissionStatusResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseSubmissionStatusResponse rebuild(
    void Function(BaseResponseSubmissionStatusResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseSubmissionStatusResponseBuilder toBuilder() =>
      BaseResponseSubmissionStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseSubmissionStatusResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseSubmissionStatusResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseSubmissionStatusResponseBuilder
    implements
        Builder<
          BaseResponseSubmissionStatusResponse,
          BaseResponseSubmissionStatusResponseBuilder
        > {
  _$BaseResponseSubmissionStatusResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  SubmissionStatusResponseBuilder? _data;
  SubmissionStatusResponseBuilder get data =>
      _$this._data ??= SubmissionStatusResponseBuilder();
  set data(SubmissionStatusResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseSubmissionStatusResponseBuilder() {
    BaseResponseSubmissionStatusResponse._defaults(this);
  }

  BaseResponseSubmissionStatusResponseBuilder get _$this {
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
  void replace(BaseResponseSubmissionStatusResponse other) {
    _$v = other as _$BaseResponseSubmissionStatusResponse;
  }

  @override
  void update(
    void Function(BaseResponseSubmissionStatusResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseSubmissionStatusResponse build() => _build();

  _$BaseResponseSubmissionStatusResponse _build() {
    _$BaseResponseSubmissionStatusResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseSubmissionStatusResponse._(
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
          r'BaseResponseSubmissionStatusResponse',
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
