// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_subject_profile_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListSubjectProfileSummary
    extends BaseResponseListSubjectProfileSummary {
  @override
  final int? code;
  @override
  final BuiltList<SubjectProfileSummary>? data;
  @override
  final String? message;

  factory _$BaseResponseListSubjectProfileSummary([
    void Function(BaseResponseListSubjectProfileSummaryBuilder)? updates,
  ]) => (BaseResponseListSubjectProfileSummaryBuilder()..update(updates))
      ._build();

  _$BaseResponseListSubjectProfileSummary._({
    this.code,
    this.data,
    this.message,
  }) : super._();
  @override
  BaseResponseListSubjectProfileSummary rebuild(
    void Function(BaseResponseListSubjectProfileSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListSubjectProfileSummaryBuilder toBuilder() =>
      BaseResponseListSubjectProfileSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListSubjectProfileSummary &&
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
            r'BaseResponseListSubjectProfileSummary',
          )
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListSubjectProfileSummaryBuilder
    implements
        Builder<
          BaseResponseListSubjectProfileSummary,
          BaseResponseListSubjectProfileSummaryBuilder
        > {
  _$BaseResponseListSubjectProfileSummary? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<SubjectProfileSummary>? _data;
  ListBuilder<SubjectProfileSummary> get data =>
      _$this._data ??= ListBuilder<SubjectProfileSummary>();
  set data(ListBuilder<SubjectProfileSummary>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListSubjectProfileSummaryBuilder() {
    BaseResponseListSubjectProfileSummary._defaults(this);
  }

  BaseResponseListSubjectProfileSummaryBuilder get _$this {
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
  void replace(BaseResponseListSubjectProfileSummary other) {
    _$v = other as _$BaseResponseListSubjectProfileSummary;
  }

  @override
  void update(
    void Function(BaseResponseListSubjectProfileSummaryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListSubjectProfileSummary build() => _build();

  _$BaseResponseListSubjectProfileSummary _build() {
    _$BaseResponseListSubjectProfileSummary _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListSubjectProfileSummary._(
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
          r'BaseResponseListSubjectProfileSummary',
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
