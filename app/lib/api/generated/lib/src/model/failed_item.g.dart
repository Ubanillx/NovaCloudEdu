// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failed_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FailedItem extends FailedItem {
  @override
  final int? documentId;
  @override
  final String? reason;

  factory _$FailedItem([void Function(FailedItemBuilder)? updates]) =>
      (FailedItemBuilder()..update(updates))._build();

  _$FailedItem._({this.documentId, this.reason}) : super._();
  @override
  FailedItem rebuild(void Function(FailedItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FailedItemBuilder toBuilder() => FailedItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FailedItem &&
        documentId == other.documentId &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, documentId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FailedItem')
          ..add('documentId', documentId)
          ..add('reason', reason))
        .toString();
  }
}

class FailedItemBuilder implements Builder<FailedItem, FailedItemBuilder> {
  _$FailedItem? _$v;

  int? _documentId;
  int? get documentId => _$this._documentId;
  set documentId(int? documentId) => _$this._documentId = documentId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  FailedItemBuilder() {
    FailedItem._defaults(this);
  }

  FailedItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _documentId = $v.documentId;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FailedItem other) {
    _$v = other as _$FailedItem;
  }

  @override
  void update(void Function(FailedItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FailedItem build() => _build();

  _$FailedItem _build() {
    final _$result =
        _$v ?? _$FailedItem._(documentId: documentId, reason: reason);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
