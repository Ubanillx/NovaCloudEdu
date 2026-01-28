// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_feedback_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseFeedbackDetailResponse
    extends BaseResponseFeedbackDetailResponse {
  @override
  final int? code;
  @override
  final FeedbackDetailResponse? data;
  @override
  final String? message;

  factory _$BaseResponseFeedbackDetailResponse([
    void Function(BaseResponseFeedbackDetailResponseBuilder)? updates,
  ]) => (BaseResponseFeedbackDetailResponseBuilder()..update(updates))._build();

  _$BaseResponseFeedbackDetailResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseFeedbackDetailResponse rebuild(
    void Function(BaseResponseFeedbackDetailResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseFeedbackDetailResponseBuilder toBuilder() =>
      BaseResponseFeedbackDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseFeedbackDetailResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseFeedbackDetailResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseFeedbackDetailResponseBuilder
    implements
        Builder<
          BaseResponseFeedbackDetailResponse,
          BaseResponseFeedbackDetailResponseBuilder
        > {
  _$BaseResponseFeedbackDetailResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  FeedbackDetailResponseBuilder? _data;
  FeedbackDetailResponseBuilder get data =>
      _$this._data ??= FeedbackDetailResponseBuilder();
  set data(FeedbackDetailResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseFeedbackDetailResponseBuilder() {
    BaseResponseFeedbackDetailResponse._defaults(this);
  }

  BaseResponseFeedbackDetailResponseBuilder get _$this {
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
  void replace(BaseResponseFeedbackDetailResponse other) {
    _$v = other as _$BaseResponseFeedbackDetailResponse;
  }

  @override
  void update(
    void Function(BaseResponseFeedbackDetailResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseFeedbackDetailResponse build() => _build();

  _$BaseResponseFeedbackDetailResponse _build() {
    _$BaseResponseFeedbackDetailResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseFeedbackDetailResponse._(
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
          r'BaseResponseFeedbackDetailResponse',
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
