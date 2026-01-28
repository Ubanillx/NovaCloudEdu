// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_feedback_reply_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListFeedbackReplyResponse
    extends BaseResponseListFeedbackReplyResponse {
  @override
  final int? code;
  @override
  final BuiltList<FeedbackReplyResponse>? data;
  @override
  final String? message;

  factory _$BaseResponseListFeedbackReplyResponse([
    void Function(BaseResponseListFeedbackReplyResponseBuilder)? updates,
  ]) => (BaseResponseListFeedbackReplyResponseBuilder()..update(updates))
      ._build();

  _$BaseResponseListFeedbackReplyResponse._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListFeedbackReplyResponse rebuild(
    void Function(BaseResponseListFeedbackReplyResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListFeedbackReplyResponseBuilder toBuilder() =>
      BaseResponseListFeedbackReplyResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListFeedbackReplyResponse &&
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
            r'BaseResponseListFeedbackReplyResponse',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListFeedbackReplyResponseBuilder
    implements
        Builder<
          BaseResponseListFeedbackReplyResponse,
          BaseResponseListFeedbackReplyResponseBuilder
        > {
  _$BaseResponseListFeedbackReplyResponse? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<FeedbackReplyResponse>? _data;
  ListBuilder<FeedbackReplyResponse> get data =>
      _$this._data ??= ListBuilder<FeedbackReplyResponse>();
  set data(ListBuilder<FeedbackReplyResponse>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListFeedbackReplyResponseBuilder() {
    BaseResponseListFeedbackReplyResponse._defaults(this);
  }

  BaseResponseListFeedbackReplyResponseBuilder get _$this {
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
  void replace(BaseResponseListFeedbackReplyResponse other) {
    _$v = other as _$BaseResponseListFeedbackReplyResponse;
  }

  @override
  void update(
    void Function(BaseResponseListFeedbackReplyResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListFeedbackReplyResponse build() => _build();

  _$BaseResponseListFeedbackReplyResponse _build() {
    _$BaseResponseListFeedbackReplyResponse _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListFeedbackReplyResponse._(
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
          r'BaseResponseListFeedbackReplyResponse',
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
