// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_subject_profile_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseSubjectProfileSummary
    extends BaseResponseSubjectProfileSummary {
  @override
  final int? code;
  @override
  final SubjectProfileSummary? data;
  @override
  final String? message;

  factory _$BaseResponseSubjectProfileSummary([
    void Function(BaseResponseSubjectProfileSummaryBuilder)? updates,
  ]) => (BaseResponseSubjectProfileSummaryBuilder()..update(updates))._build();

  _$BaseResponseSubjectProfileSummary._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseSubjectProfileSummary rebuild(
    void Function(BaseResponseSubjectProfileSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseSubjectProfileSummaryBuilder toBuilder() =>
      BaseResponseSubjectProfileSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseSubjectProfileSummary &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseSubjectProfileSummary')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseSubjectProfileSummaryBuilder
    implements
        Builder<
          BaseResponseSubjectProfileSummary,
          BaseResponseSubjectProfileSummaryBuilder
        > {
  _$BaseResponseSubjectProfileSummary? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  SubjectProfileSummaryBuilder? _data;
  SubjectProfileSummaryBuilder get data =>
      _$this._data ??= SubjectProfileSummaryBuilder();
  set data(SubjectProfileSummaryBuilder? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseSubjectProfileSummaryBuilder() {
    BaseResponseSubjectProfileSummary._defaults(this);
  }

  BaseResponseSubjectProfileSummaryBuilder get _$this {
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
  void replace(BaseResponseSubjectProfileSummary other) {
    _$v = other as _$BaseResponseSubjectProfileSummary;
  }

  @override
  void update(
    void Function(BaseResponseSubjectProfileSummaryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseSubjectProfileSummary build() => _build();

  _$BaseResponseSubjectProfileSummary _build() {
    _$BaseResponseSubjectProfileSummary _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseSubjectProfileSummary._(
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
          r'BaseResponseSubjectProfileSummary',
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
