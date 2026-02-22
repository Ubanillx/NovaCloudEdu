// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_trend_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LearningTrendResponse extends LearningTrendResponse {
  @override
  final String? granularity;
  @override
  final BuiltList<TrendItem>? items;

  factory _$LearningTrendResponse([
    void Function(LearningTrendResponseBuilder)? updates,
  ]) => (LearningTrendResponseBuilder()..update(updates))._build();

  _$LearningTrendResponse._({this.granularity, this.items}) : super._();
  @override
  LearningTrendResponse rebuild(
    void Function(LearningTrendResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LearningTrendResponseBuilder toBuilder() =>
      LearningTrendResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LearningTrendResponse &&
        granularity == other.granularity &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, granularity.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LearningTrendResponse')
          ..add('granularity', granularity)
          ..add('items', items))
        .toString();
  }
}

class LearningTrendResponseBuilder
    implements Builder<LearningTrendResponse, LearningTrendResponseBuilder> {
  _$LearningTrendResponse? _$v;

  String? _granularity;
  String? get granularity => _$this._granularity;
  set granularity(String? granularity) => _$this._granularity = granularity;

  ListBuilder<TrendItem>? _items;
  ListBuilder<TrendItem> get items =>
      _$this._items ??= ListBuilder<TrendItem>();
  set items(ListBuilder<TrendItem>? items) => _$this._items = items;

  LearningTrendResponseBuilder() {
    LearningTrendResponse._defaults(this);
  }

  LearningTrendResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _granularity = $v.granularity;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LearningTrendResponse other) {
    _$v = other as _$LearningTrendResponse;
  }

  @override
  void update(void Function(LearningTrendResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LearningTrendResponse build() => _build();

  _$LearningTrendResponse _build() {
    _$LearningTrendResponse _$result;
    try {
      _$result =
          _$v ??
          _$LearningTrendResponse._(
            granularity: granularity,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LearningTrendResponse',
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
