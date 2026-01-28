// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_chapter_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseChapterSummary extends BaseResponseChapterSummary {
  @override
  final int? code;
  @override
  final ChapterSummary? data;
  @override
  final String? message;

  factory _$BaseResponseChapterSummary([
    void Function(BaseResponseChapterSummaryBuilder)? updates,
  ]) => (BaseResponseChapterSummaryBuilder()..update(updates))._build();

  _$BaseResponseChapterSummary._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseChapterSummary rebuild(
    void Function(BaseResponseChapterSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseChapterSummaryBuilder toBuilder() =>
      BaseResponseChapterSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseChapterSummary &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseChapterSummary')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseChapterSummaryBuilder
    implements
        Builder<BaseResponseChapterSummary, BaseResponseChapterSummaryBuilder> {
  _$BaseResponseChapterSummary? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ChapterSummaryBuilder? _data;
  ChapterSummaryBuilder get data => _$this._data ??= ChapterSummaryBuilder();
  set data(ChapterSummaryBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseChapterSummaryBuilder() {
    BaseResponseChapterSummary._defaults(this);
  }

  BaseResponseChapterSummaryBuilder get _$this {
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
  void replace(BaseResponseChapterSummary other) {
    _$v = other as _$BaseResponseChapterSummary;
  }

  @override
  void update(void Function(BaseResponseChapterSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseChapterSummary build() => _build();

  _$BaseResponseChapterSummary _build() {
    _$BaseResponseChapterSummary _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseChapterSummary._(
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
          r'BaseResponseChapterSummary',
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
