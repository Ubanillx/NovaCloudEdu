// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_class_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateClassRequest extends CreateClassRequest {
  @override
  final String className;
  @override
  final String? description;

  factory _$CreateClassRequest([
    void Function(CreateClassRequestBuilder)? updates,
  ]) => (CreateClassRequestBuilder()..update(updates))._build();

  _$CreateClassRequest._({required this.className, this.description})
    : super._();
  @override
  CreateClassRequest rebuild(
    void Function(CreateClassRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateClassRequestBuilder toBuilder() =>
      CreateClassRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateClassRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateClassRequest')
          ..add('className', className)
          ..add('description', description))
        .toString();
  }
}

class CreateClassRequestBuilder
    implements Builder<CreateClassRequest, CreateClassRequestBuilder> {
  _$CreateClassRequest? _$v;

  String? _className;
  String? get className => _$this._className;
  set className(String? className) => _$this._className = className;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  CreateClassRequestBuilder() {
    CreateClassRequest._defaults(this);
  }

  CreateClassRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _className = $v.className;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateClassRequest other) {
    _$v = other as _$CreateClassRequest;
  }

  @override
  void update(void Function(CreateClassRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateClassRequest build() => _build();

  _$CreateClassRequest _build() {
    final _$result =
        _$v ??
        _$CreateClassRequest._(
          className: BuiltValueNullFieldError.checkNotNull(
            className,
            r'CreateClassRequest',
            'className',
          ),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
