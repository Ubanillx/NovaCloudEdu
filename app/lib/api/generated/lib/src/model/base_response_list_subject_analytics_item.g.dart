// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_subject_analytics_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListSubjectAnalyticsItem
    extends BaseResponseListSubjectAnalyticsItem {
  @override
  final int? code;
  @override
  final BuiltList<SubjectAnalyticsItem>? data;
  @override
  final String? message;

  factory _$BaseResponseListSubjectAnalyticsItem([
    void Function(BaseResponseListSubjectAnalyticsItemBuilder)? updates,
  ]) =>
      (BaseResponseListSubjectAnalyticsItemBuilder()..update(updates))._build();

  _$BaseResponseListSubjectAnalyticsItem._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListSubjectAnalyticsItem rebuild(
    void Function(BaseResponseListSubjectAnalyticsItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListSubjectAnalyticsItemBuilder toBuilder() =>
      BaseResponseListSubjectAnalyticsItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListSubjectAnalyticsItem &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListSubjectAnalyticsItem')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListSubjectAnalyticsItemBuilder
    implements
        Builder<
          BaseResponseListSubjectAnalyticsItem,
          BaseResponseListSubjectAnalyticsItemBuilder
        > {
  _$BaseResponseListSubjectAnalyticsItem? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<SubjectAnalyticsItem>? _data;
  ListBuilder<SubjectAnalyticsItem> get data =>
      _$this._data ??= ListBuilder<SubjectAnalyticsItem>();
  set data(ListBuilder<SubjectAnalyticsItem>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListSubjectAnalyticsItemBuilder() {
    BaseResponseListSubjectAnalyticsItem._defaults(this);
  }

  BaseResponseListSubjectAnalyticsItemBuilder get _$this {
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
  void replace(BaseResponseListSubjectAnalyticsItem other) {
    _$v = other as _$BaseResponseListSubjectAnalyticsItem;
  }

  @override
  void update(
    void Function(BaseResponseListSubjectAnalyticsItemBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListSubjectAnalyticsItem build() => _build();

  _$BaseResponseListSubjectAnalyticsItem _build() {
    _$BaseResponseListSubjectAnalyticsItem _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListSubjectAnalyticsItem._(
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
          r'BaseResponseListSubjectAnalyticsItem',
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
