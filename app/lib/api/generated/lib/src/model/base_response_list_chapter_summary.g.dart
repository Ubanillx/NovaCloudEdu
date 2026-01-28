// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_chapter_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListChapterSummary extends BaseResponseListChapterSummary {
  @override
  final int? code;
  @override
  final BuiltList<ChapterSummary>? data;
  @override
  final String? message;

  factory _$BaseResponseListChapterSummary([
    void Function(BaseResponseListChapterSummaryBuilder)? updates,
  ]) => (BaseResponseListChapterSummaryBuilder()..update(updates))._build();

  _$BaseResponseListChapterSummary._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListChapterSummary rebuild(
    void Function(BaseResponseListChapterSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListChapterSummaryBuilder toBuilder() =>
      BaseResponseListChapterSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListChapterSummary &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListChapterSummary')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListChapterSummaryBuilder
    implements
        Builder<
          BaseResponseListChapterSummary,
          BaseResponseListChapterSummaryBuilder
        > {
  _$BaseResponseListChapterSummary? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<ChapterSummary>? _data;
  ListBuilder<ChapterSummary> get data =>
      _$this._data ??= ListBuilder<ChapterSummary>();
  set data(ListBuilder<ChapterSummary>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListChapterSummaryBuilder() {
    BaseResponseListChapterSummary._defaults(this);
  }

  BaseResponseListChapterSummaryBuilder get _$this {
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
  void replace(BaseResponseListChapterSummary other) {
    _$v = other as _$BaseResponseListChapterSummary;
  }

  @override
  void update(void Function(BaseResponseListChapterSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListChapterSummary build() => _build();

  _$BaseResponseListChapterSummary _build() {
    _$BaseResponseListChapterSummary _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListChapterSummary._(
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
          r'BaseResponseListChapterSummary',
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
