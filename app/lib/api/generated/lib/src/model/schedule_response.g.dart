// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScheduleResponse extends ScheduleResponse {
  @override
  final ClassScheduleSettingResponse? setting;
  @override
  final BuiltList<ClassScheduleItemResponse>? items;

  factory _$ScheduleResponse([
    void Function(ScheduleResponseBuilder)? updates,
  ]) => (ScheduleResponseBuilder()..update(updates))._build();

  _$ScheduleResponse._({this.setting, this.items}) : super._();
  @override
  ScheduleResponse rebuild(void Function(ScheduleResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScheduleResponseBuilder toBuilder() =>
      ScheduleResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScheduleResponse &&
        setting == other.setting &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, setting.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScheduleResponse')
          ..add('setting', setting)
          ..add('items', items))
        .toString();
  }
}

class ScheduleResponseBuilder
    implements Builder<ScheduleResponse, ScheduleResponseBuilder> {
  _$ScheduleResponse? _$v;

  ClassScheduleSettingResponseBuilder? _setting;
  ClassScheduleSettingResponseBuilder get setting =>
      _$this._setting ??= ClassScheduleSettingResponseBuilder();
  set setting(ClassScheduleSettingResponseBuilder? setting) =>
      _$this._setting = setting;

  ListBuilder<ClassScheduleItemResponse>? _items;
  ListBuilder<ClassScheduleItemResponse> get items =>
      _$this._items ??= ListBuilder<ClassScheduleItemResponse>();
  set items(ListBuilder<ClassScheduleItemResponse>? items) =>
      _$this._items = items;

  ScheduleResponseBuilder() {
    ScheduleResponse._defaults(this);
  }

  ScheduleResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _setting = $v.setting?.toBuilder();
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScheduleResponse other) {
    _$v = other as _$ScheduleResponse;
  }

  @override
  void update(void Function(ScheduleResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScheduleResponse build() => _build();

  _$ScheduleResponse _build() {
    _$ScheduleResponse _$result;
    try {
      _$result =
          _$v ??
          _$ScheduleResponse._(
            setting: _setting?.build(),
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'setting';
        _setting?.build();
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ScheduleResponse',
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
