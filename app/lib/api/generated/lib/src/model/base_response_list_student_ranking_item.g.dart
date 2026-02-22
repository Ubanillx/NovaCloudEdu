// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_student_ranking_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListStudentRankingItem
    extends BaseResponseListStudentRankingItem {
  @override
  final int? code;
  @override
  final BuiltList<StudentRankingItem>? data;
  @override
  final String? message;

  factory _$BaseResponseListStudentRankingItem([
    void Function(BaseResponseListStudentRankingItemBuilder)? updates,
  ]) => (BaseResponseListStudentRankingItemBuilder()..update(updates))._build();

  _$BaseResponseListStudentRankingItem._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListStudentRankingItem rebuild(
    void Function(BaseResponseListStudentRankingItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListStudentRankingItemBuilder toBuilder() =>
      BaseResponseListStudentRankingItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListStudentRankingItem &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListStudentRankingItem')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListStudentRankingItemBuilder
    implements
        Builder<
          BaseResponseListStudentRankingItem,
          BaseResponseListStudentRankingItemBuilder
        > {
  _$BaseResponseListStudentRankingItem? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<StudentRankingItem>? _data;
  ListBuilder<StudentRankingItem> get data =>
      _$this._data ??= ListBuilder<StudentRankingItem>();
  set data(ListBuilder<StudentRankingItem>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListStudentRankingItemBuilder() {
    BaseResponseListStudentRankingItem._defaults(this);
  }

  BaseResponseListStudentRankingItemBuilder get _$this {
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
  void replace(BaseResponseListStudentRankingItem other) {
    _$v = other as _$BaseResponseListStudentRankingItem;
  }

  @override
  void update(
    void Function(BaseResponseListStudentRankingItemBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListStudentRankingItem build() => _build();

  _$BaseResponseListStudentRankingItem _build() {
    _$BaseResponseListStudentRankingItem _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListStudentRankingItem._(
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
          r'BaseResponseListStudentRankingItem',
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
