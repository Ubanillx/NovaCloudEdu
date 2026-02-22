// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_category_count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ErrorCategoryCount extends ErrorCategoryCount {
  @override
  final String? category;
  @override
  final String? categoryName;
  @override
  final int? count;

  factory _$ErrorCategoryCount([
    void Function(ErrorCategoryCountBuilder)? updates,
  ]) => (ErrorCategoryCountBuilder()..update(updates))._build();

  _$ErrorCategoryCount._({this.category, this.categoryName, this.count})
    : super._();
  @override
  ErrorCategoryCount rebuild(
    void Function(ErrorCategoryCountBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ErrorCategoryCountBuilder toBuilder() =>
      ErrorCategoryCountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorCategoryCount &&
        category == other.category &&
        categoryName == other.categoryName &&
        count == other.count;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, categoryName.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ErrorCategoryCount')
          ..add('category', category)
          ..add('categoryName', categoryName)
          ..add('count', count))
        .toString();
  }
}

class ErrorCategoryCountBuilder
    implements Builder<ErrorCategoryCount, ErrorCategoryCountBuilder> {
  _$ErrorCategoryCount? _$v;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _categoryName;
  String? get categoryName => _$this._categoryName;
  set categoryName(String? categoryName) => _$this._categoryName = categoryName;

  int? _count;
  int? get count => _$this._count;
  set count(int? count) => _$this._count = count;

  ErrorCategoryCountBuilder() {
    ErrorCategoryCount._defaults(this);
  }

  ErrorCategoryCountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _categoryName = $v.categoryName;
      _count = $v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorCategoryCount other) {
    _$v = other as _$ErrorCategoryCount;
  }

  @override
  void update(void Function(ErrorCategoryCountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ErrorCategoryCount build() => _build();

  _$ErrorCategoryCount _build() {
    final _$result =
        _$v ??
        _$ErrorCategoryCount._(
          category: category,
          categoryName: categoryName,
          count: count,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
