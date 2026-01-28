// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_checkin_ranking_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListCheckinRankingItem
    extends BaseResponseListCheckinRankingItem {
  @override
  final int? code;
  @override
  final BuiltList<CheckinRankingItem>? data;
  @override
  final String? message;

  factory _$BaseResponseListCheckinRankingItem([
    void Function(BaseResponseListCheckinRankingItemBuilder)? updates,
  ]) => (BaseResponseListCheckinRankingItemBuilder()..update(updates))._build();

  _$BaseResponseListCheckinRankingItem._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListCheckinRankingItem rebuild(
    void Function(BaseResponseListCheckinRankingItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListCheckinRankingItemBuilder toBuilder() =>
      BaseResponseListCheckinRankingItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListCheckinRankingItem &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListCheckinRankingItem')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListCheckinRankingItemBuilder
    implements
        Builder<
          BaseResponseListCheckinRankingItem,
          BaseResponseListCheckinRankingItemBuilder
        > {
  _$BaseResponseListCheckinRankingItem? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<CheckinRankingItem>? _data;
  ListBuilder<CheckinRankingItem> get data =>
      _$this._data ??= ListBuilder<CheckinRankingItem>();
  set data(ListBuilder<CheckinRankingItem>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListCheckinRankingItemBuilder() {
    BaseResponseListCheckinRankingItem._defaults(this);
  }

  BaseResponseListCheckinRankingItemBuilder get _$this {
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
  void replace(BaseResponseListCheckinRankingItem other) {
    _$v = other as _$BaseResponseListCheckinRankingItem;
  }

  @override
  void update(
    void Function(BaseResponseListCheckinRankingItemBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListCheckinRankingItem build() => _build();

  _$BaseResponseListCheckinRankingItem _build() {
    _$BaseResponseListCheckinRankingItem _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListCheckinRankingItem._(
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
          r'BaseResponseListCheckinRankingItem',
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
