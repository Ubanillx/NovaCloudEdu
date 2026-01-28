// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_class_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateClassRequest extends UpdateClassRequest {
  @override
  final String? className;
  @override
  final String? description;

  factory _$UpdateClassRequest([
    void Function(UpdateClassRequestBuilder)? updates,
  ]) => (UpdateClassRequestBuilder()..update(updates))._build();

  _$UpdateClassRequest._({this.className, this.description}) : super._();
  @override
  UpdateClassRequest rebuild(
    void Function(UpdateClassRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateClassRequestBuilder toBuilder() =>
      UpdateClassRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateClassRequest &&
        className == other.className &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, className.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateClassRequest')
          ..add('className', className)
          ..add('description', description))
        .toString();
  }
}

class UpdateClassRequestBuilder
    implements Builder<UpdateClassRequest, UpdateClassRequestBuilder> {
  _$UpdateClassRequest? _$v;

  String? _className;
  String? get className => _$this._className;
  set className(String? className) => _$this._className = className;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  UpdateClassRequestBuilder() {
    UpdateClassRequest._defaults(this);
  }

  UpdateClassRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _className = $v.className;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateClassRequest other) {
    _$v = other as _$UpdateClassRequest;
  }

  @override
  void update(void Function(UpdateClassRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateClassRequest build() => _build();

  _$UpdateClassRequest _build() {
    final _$result =
        _$v ??
        _$UpdateClassRequest._(className: className, description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
