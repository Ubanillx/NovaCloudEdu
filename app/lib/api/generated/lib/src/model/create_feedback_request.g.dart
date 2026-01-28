// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_feedback_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateFeedbackRequest extends CreateFeedbackRequest {
  @override
  final String feedbackType;
  @override
  final String content;
  @override
  final String? title;
  @override
  final String? attachment;

  factory _$CreateFeedbackRequest([
    void Function(CreateFeedbackRequestBuilder)? updates,
  ]) => (CreateFeedbackRequestBuilder()..update(updates))._build();

  _$CreateFeedbackRequest._({
    required this.feedbackType,
    required this.content,
    this.title,
    this.attachment,
  }) : super._();
  @override
  CreateFeedbackRequest rebuild(
    void Function(CreateFeedbackRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateFeedbackRequestBuilder toBuilder() =>
      CreateFeedbackRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateFeedbackRequest &&
        feedbackType == other.feedbackType &&
        content == other.content &&
        title == other.title &&
        attachment == other.attachment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feedbackType.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, attachment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateFeedbackRequest')
          ..add('feedbackType', feedbackType)
          ..add('content', content)
          ..add('title', title)
          ..add('attachment', attachment))
        .toString();
  }
}

class CreateFeedbackRequestBuilder
    implements Builder<CreateFeedbackRequest, CreateFeedbackRequestBuilder> {
  _$CreateFeedbackRequest? _$v;

  String? _feedbackType;
  String? get feedbackType => _$this._feedbackType;
  set feedbackType(String? feedbackType) => _$this._feedbackType = feedbackType;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _attachment;
  String? get attachment => _$this._attachment;
  set attachment(String? attachment) => _$this._attachment = attachment;

  CreateFeedbackRequestBuilder() {
    CreateFeedbackRequest._defaults(this);
  }

  CreateFeedbackRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feedbackType = $v.feedbackType;
      _content = $v.content;
      _title = $v.title;
      _attachment = $v.attachment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateFeedbackRequest other) {
    _$v = other as _$CreateFeedbackRequest;
  }

  @override
  void update(void Function(CreateFeedbackRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateFeedbackRequest build() => _build();

  _$CreateFeedbackRequest _build() {
    final _$result =
        _$v ??
        _$CreateFeedbackRequest._(
          feedbackType: BuiltValueNullFieldError.checkNotNull(
            feedbackType,
            r'CreateFeedbackRequest',
            'feedbackType',
          ),
          content: BuiltValueNullFieldError.checkNotNull(
            content,
            r'CreateFeedbackRequest',
            'content',
          ),
          title: title,
          attachment: attachment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
