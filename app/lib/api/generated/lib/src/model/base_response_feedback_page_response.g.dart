// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_feedback_page_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseFeedbackPageResponse
    extends BaseResponseFeedbackPageResponse {
  @override
  final int? code;
  @override
  final FeedbackPageResponse? data;
  @override
  final String? message;

  factory _$BaseResponseFeedbackPageResponse([
    void Function(BaseResponseFeedbackPageResponseBuilder)? updates,
  ]) => (BaseResponseFeedbackPageResponseBuilder()..update(updates))._build();

  _$BaseResponseFeedbackPageResponse._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseFeedbackPageResponse rebuild(
    void Function(BaseResponseFeedbackPageResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseFeedbackPageResponseBuilder toBuilder() =>
      BaseResponseFeedbackPageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseFeedbackPageResponse &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseFeedbackPageResponse')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseFeedbackPageResponseBuilder
    implements
        Builder<
          BaseResponseFeedbackPageResponse,
          BaseResponseFeedbackPageResponseBuilder
        > {
  _$BaseResponseFeedbackPageResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  FeedbackPageResponseBuilder? _data;
  FeedbackPageResponseBuilder get data =>
      _$this._data ??= FeedbackPageResponseBuilder();
  set data(FeedbackPageResponseBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseFeedbackPageResponseBuilder() {
    BaseResponseFeedbackPageResponse._defaults(this);
  }

  BaseResponseFeedbackPageResponseBuilder get _$this {
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
  void replace(BaseResponseFeedbackPageResponse other) {
    _$v = other as _$BaseResponseFeedbackPageResponse;
  }

  @override
  void update(void Function(BaseResponseFeedbackPageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseFeedbackPageResponse build() => _build();

  _$BaseResponseFeedbackPageResponse _build() {
    _$BaseResponseFeedbackPageResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseFeedbackPageResponse._(
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
          r'BaseResponseFeedbackPageResponse',
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
