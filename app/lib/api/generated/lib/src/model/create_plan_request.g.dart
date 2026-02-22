// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatePlanRequest extends CreatePlanRequest {
  @override
  final String name;
  @override
  final String code;
  @override
  final num price;
  @override
  final String? description;
  @override
  final int? durationDays;

  factory _$CreatePlanRequest([
    void Function(CreatePlanRequestBuilder)? updates,
  ]) => (CreatePlanRequestBuilder()..update(updates))._build();

  _$CreatePlanRequest._({
    required this.name,
    required this.code,
    required this.price,
    this.description,
    this.durationDays,
  }) : super._();
  @override
  CreatePlanRequest rebuild(void Function(CreatePlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreatePlanRequestBuilder toBuilder() =>
      CreatePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePlanRequest &&
        name == other.name &&
        code == other.code &&
        price == other.price &&
        description == other.description &&
        durationDays == other.durationDays;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, durationDays.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatePlanRequest')
          ..add('name', name)
          ..add('code', code)
          ..add('price', price)
          ..add('description', description)
          ..add('durationDays', durationDays))
        .toString();
  }
}

class CreatePlanRequestBuilder
    implements Builder<CreatePlanRequest, CreatePlanRequestBuilder> {
  _$CreatePlanRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _durationDays;
  int? get durationDays => _$this._durationDays;
  set durationDays(int? durationDays) => _$this._durationDays = durationDays;

  CreatePlanRequestBuilder() {
    CreatePlanRequest._defaults(this);
  }

  CreatePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _code = $v.code;
      _price = $v.price;
      _description = $v.description;
      _durationDays = $v.durationDays;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatePlanRequest other) {
    _$v = other as _$CreatePlanRequest;
  }

  @override
  void update(void Function(CreatePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePlanRequest build() => _build();

  _$CreatePlanRequest _build() {
    final _$result =
        _$v ??
        _$CreatePlanRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'CreatePlanRequest',
            'name',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'CreatePlanRequest',
            'code',
          ),
          price: BuiltValueNullFieldError.checkNotNull(
            price,
            r'CreatePlanRequest',
            'price',
          ),
          description: description,
          durationDays: durationDays,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
