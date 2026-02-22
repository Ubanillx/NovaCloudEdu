// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_plan_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdatePlanRequest extends UpdatePlanRequest {
  @override
  final int id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final num? price;
  @override
  final int? durationDays;

  factory _$UpdatePlanRequest([
    void Function(UpdatePlanRequestBuilder)? updates,
  ]) => (UpdatePlanRequestBuilder()..update(updates))._build();

  _$UpdatePlanRequest._({
    required this.id,
    this.name,
    this.description,
    this.price,
    this.durationDays,
  }) : super._();
  @override
  UpdatePlanRequest rebuild(void Function(UpdatePlanRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePlanRequestBuilder toBuilder() =>
      UpdatePlanRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePlanRequest &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        price == other.price &&
        durationDays == other.durationDays;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, durationDays.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdatePlanRequest')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('price', price)
          ..add('durationDays', durationDays))
        .toString();
  }
}

class UpdatePlanRequestBuilder
    implements Builder<UpdatePlanRequest, UpdatePlanRequestBuilder> {
  _$UpdatePlanRequest? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  int? _durationDays;
  int? get durationDays => _$this._durationDays;
  set durationDays(int? durationDays) => _$this._durationDays = durationDays;

  UpdatePlanRequestBuilder() {
    UpdatePlanRequest._defaults(this);
  }

  UpdatePlanRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _price = $v.price;
      _durationDays = $v.durationDays;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdatePlanRequest other) {
    _$v = other as _$UpdatePlanRequest;
  }

  @override
  void update(void Function(UpdatePlanRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePlanRequest build() => _build();

  _$UpdatePlanRequest _build() {
    final _$result =
        _$v ??
        _$UpdatePlanRequest._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'UpdatePlanRequest',
            'id',
          ),
          name: name,
          description: description,
          price: price,
          durationDays: durationDays,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
