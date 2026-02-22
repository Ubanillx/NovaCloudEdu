// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_submission_status_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListSubmissionStatusResponse
    extends BaseResponseListSubmissionStatusResponse {
  @override
  final int? code;
  @override
  final BuiltList<SubmissionStatusResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListSubmissionStatusResponse([
    void Function(BaseResponseListSubmissionStatusResponseBuilder)? updates,
  ]) => (BaseResponseListSubmissionStatusResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListSubmissionStatusResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListSubmissionStatusResponse rebuild(
    void Function(BaseResponseListSubmissionStatusResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListSubmissionStatusResponseBuilder toBuilder() =>
      BaseResponseListSubmissionStatusResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListSubmissionStatusResponse &&
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
    return (newBuiltValueToStringHelper(
            r'BaseResponseListSubmissionStatusResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListSubmissionStatusResponseBuilder
    implements
        Builder<
          BaseResponseListSubmissionStatusResponse,
          BaseResponseListSubmissionStatusResponseBuilder
        > {
  _$BaseResponseListSubmissionStatusResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<SubmissionStatusResponse>? _data;
  ListBuilder<SubmissionStatusResponse> get data =>
      _$this._data ??= ListBuilder<SubmissionStatusResponse>();
  set data(ListBuilder<SubmissionStatusResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListSubmissionStatusResponseBuilder() {
    BaseResponseListSubmissionStatusResponse._defaults(this);
  }

  BaseResponseListSubmissionStatusResponseBuilder get _$this {
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
  void replace(BaseResponseListSubmissionStatusResponse other) {
    _$v = other as _$BaseResponseListSubmissionStatusResponse;
  }

  @override
  void update(
    void Function(BaseResponseListSubmissionStatusResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListSubmissionStatusResponse build() => _build();

  _$BaseResponseListSubmissionStatusResponse _build() {
    _$BaseResponseListSubmissionStatusResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListSubmissionStatusResponse._(
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
          r'BaseResponseListSubmissionStatusResponse',
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
