// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_list_group_message_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BaseResponseListGroupMessageItem
    extends BaseResponseListGroupMessageItem {
  @override
  final int? code;
  @override
  final BuiltList<GroupMessageItem>? data;
  @override
  final String? message;

  factory _$BaseResponseListGroupMessageItem([
    void Function(BaseResponseListGroupMessageItemBuilder)? updates,
  ]) => (BaseResponseListGroupMessageItemBuilder()..update(updates))._build();

  _$BaseResponseListGroupMessageItem._({this.code, this.data, this.message})
    : super._();
  @override
  BaseResponseListGroupMessageItem rebuild(
    void Function(BaseResponseListGroupMessageItemBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BaseResponseListGroupMessageItemBuilder toBuilder() =>
      BaseResponseListGroupMessageItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BaseResponseListGroupMessageItem &&
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
    return (newBuiltValueToStringHelper(r'BaseResponseListGroupMessageItem')
          ..add('code', code)
          ..add('data', data)
          ..add('message', message))
        .toString();
  }
}

class BaseResponseListGroupMessageItemBuilder
    implements
        Builder<
          BaseResponseListGroupMessageItem,
          BaseResponseListGroupMessageItemBuilder
        > {
  _$BaseResponseListGroupMessageItem? _$v;

  int? _code;
  int? get code => _$this._code;
  set code(int? code) => _$this._code = code;

  ListBuilder<GroupMessageItem>? _data;
  ListBuilder<GroupMessageItem> get data =>
      _$this._data ??= ListBuilder<GroupMessageItem>();
  set data(ListBuilder<GroupMessageItem>? data) => _$this._data = data;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  BaseResponseListGroupMessageItemBuilder() {
    BaseResponseListGroupMessageItem._defaults(this);
  }

  BaseResponseListGroupMessageItemBuilder get _$this {
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
  void replace(BaseResponseListGroupMessageItem other) {
    _$v = other as _$BaseResponseListGroupMessageItem;
  }

  @override
  void update(void Function(BaseResponseListGroupMessageItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BaseResponseListGroupMessageItem build() => _build();

  _$BaseResponseListGroupMessageItem _build() {
    _$BaseResponseListGroupMessageItem _$result;
    try {
      _$result =
          _$v ??
          _$BaseResponseListGroupMessageItem._(
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
          r'BaseResponseListGroupMessageItem',
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
