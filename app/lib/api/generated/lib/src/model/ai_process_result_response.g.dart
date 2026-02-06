// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_process_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AiProcessResultResponse extends AiProcessResultResponse {
  @override
  final String? formattedContent;
  @override
  final String? summary;

  factory _$AiProcessResultResponse([
    void Function(AiProcessResultResponseBuilder)? updates,
  ]) => (AiProcessResultResponseBuilder()..update(updates))._build();

  _$AiProcessResultResponse._({this.formattedContent, this.summary})
    : super._();
  @override
  AiProcessResultResponse rebuild(
    void Function(AiProcessResultResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AiProcessResultResponseBuilder toBuilder() =>
      AiProcessResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AiProcessResultResponse &&
        formattedContent == other.formattedContent &&
        summary == other.summary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, formattedContent.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AiProcessResultResponse')
          ..add('formattedContent', formattedContent)
          ..add('summary', summary))
        .toString();
  }
}

class AiProcessResultResponseBuilder
    implements
        Builder<AiProcessResultResponse, AiProcessResultResponseBuilder> {
  _$AiProcessResultResponse? _$v;

  String? _formattedContent;
  String? get formattedContent => _$this._formattedContent;
  set formattedContent(String? formattedContent) =>
      _$this._formattedContent = formattedContent;

  String? _summary;
  String? get summary => _$this._summary;
  set summary(String? summary) => _$this._summary = summary;

  AiProcessResultResponseBuilder() {
    AiProcessResultResponse._defaults(this);
  }

  AiProcessResultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _formattedContent = $v.formattedContent;
      _summary = $v.summary;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AiProcessResultResponse other) {
    _$v = other as _$AiProcessResultResponse;
  }

  @override
  void update(void Function(AiProcessResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AiProcessResultResponse build() => _build();

  _$AiProcessResultResponse _build() {
    final _$result =
        _$v ??
        _$AiProcessResultResponse._(
          formattedContent: formattedContent,
          summary: summary,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
