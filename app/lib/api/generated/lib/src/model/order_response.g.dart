// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderResponse extends OrderResponse {
  @override
  final String? orderType;
  @override
  final String? productName;
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final int? courseId;
  @override
  final String? orderNo;
  @override
  final num? price;
  @override
  final int? paymentMethod;
  @override
  final String? paymentMethodDesc;
  @override
  final DateTime? paymentTime;
  @override
  final DateTime? expireTime;
  @override
  final int? status;
  @override
  final String? statusDesc;
  @override
  final bool? isValid;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$OrderResponse([void Function(OrderResponseBuilder)? updates]) =>
      (OrderResponseBuilder()..update(updates))._build();

  _$OrderResponse._({
    this.orderType,
    this.productName,
    this.id,
    this.userId,
    this.courseId,
    this.orderNo,
    this.price,
    this.paymentMethod,
    this.paymentMethodDesc,
    this.paymentTime,
    this.expireTime,
    this.status,
    this.statusDesc,
    this.isValid,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  OrderResponse rebuild(void Function(OrderResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderResponseBuilder toBuilder() => OrderResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderResponse &&
        orderType == other.orderType &&
        productName == other.productName &&
        id == other.id &&
        userId == other.userId &&
        courseId == other.courseId &&
        orderNo == other.orderNo &&
        price == other.price &&
        paymentMethod == other.paymentMethod &&
        paymentMethodDesc == other.paymentMethodDesc &&
        paymentTime == other.paymentTime &&
        expireTime == other.expireTime &&
        status == other.status &&
        statusDesc == other.statusDesc &&
        isValid == other.isValid &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderType.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, courseId.hashCode);
    _$hash = $jc(_$hash, orderNo.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, paymentMethod.hashCode);
    _$hash = $jc(_$hash, paymentMethodDesc.hashCode);
    _$hash = $jc(_$hash, paymentTime.hashCode);
    _$hash = $jc(_$hash, expireTime.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, statusDesc.hashCode);
    _$hash = $jc(_$hash, isValid.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderResponse')
          ..add('orderType', orderType)
          ..add('productName', productName)
          ..add('id', id)
          ..add('userId', userId)
          ..add('courseId', courseId)
          ..add('orderNo', orderNo)
          ..add('price', price)
          ..add('paymentMethod', paymentMethod)
          ..add('paymentMethodDesc', paymentMethodDesc)
          ..add('paymentTime', paymentTime)
          ..add('expireTime', expireTime)
          ..add('status', status)
          ..add('statusDesc', statusDesc)
          ..add('isValid', isValid)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class OrderResponseBuilder
    implements Builder<OrderResponse, OrderResponseBuilder> {
  _$OrderResponse? _$v;

  String? _orderType;
  String? get orderType => _$this._orderType;
  set orderType(String? orderType) => _$this._orderType = orderType;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _courseId;
  int? get courseId => _$this._courseId;
  set courseId(int? courseId) => _$this._courseId = courseId;

  String? _orderNo;
  String? get orderNo => _$this._orderNo;
  set orderNo(String? orderNo) => _$this._orderNo = orderNo;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  int? _paymentMethod;
  int? get paymentMethod => _$this._paymentMethod;
  set paymentMethod(int? paymentMethod) =>
      _$this._paymentMethod = paymentMethod;

  String? _paymentMethodDesc;
  String? get paymentMethodDesc => _$this._paymentMethodDesc;
  set paymentMethodDesc(String? paymentMethodDesc) =>
      _$this._paymentMethodDesc = paymentMethodDesc;

  DateTime? _paymentTime;
  DateTime? get paymentTime => _$this._paymentTime;
  set paymentTime(DateTime? paymentTime) => _$this._paymentTime = paymentTime;

  DateTime? _expireTime;
  DateTime? get expireTime => _$this._expireTime;
  set expireTime(DateTime? expireTime) => _$this._expireTime = expireTime;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _statusDesc;
  String? get statusDesc => _$this._statusDesc;
  set statusDesc(String? statusDesc) => _$this._statusDesc = statusDesc;

  bool? _isValid;
  bool? get isValid => _$this._isValid;
  set isValid(bool? isValid) => _$this._isValid = isValid;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  OrderResponseBuilder() {
    OrderResponse._defaults(this);
  }

  OrderResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderType = $v.orderType;
      _productName = $v.productName;
      _id = $v.id;
      _userId = $v.userId;
      _courseId = $v.courseId;
      _orderNo = $v.orderNo;
      _price = $v.price;
      _paymentMethod = $v.paymentMethod;
      _paymentMethodDesc = $v.paymentMethodDesc;
      _paymentTime = $v.paymentTime;
      _expireTime = $v.expireTime;
      _status = $v.status;
      _statusDesc = $v.statusDesc;
      _isValid = $v.isValid;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderResponse other) {
    _$v = other as _$OrderResponse;
  }

  @override
  void update(void Function(OrderResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderResponse build() => _build();

  _$OrderResponse _build() {
    final _$result =
        _$v ??
        _$OrderResponse._(
          orderType: orderType,
          productName: productName,
          id: id,
          userId: userId,
          courseId: courseId,
          orderNo: orderNo,
          price: price,
          paymentMethod: paymentMethod,
          paymentMethodDesc: paymentMethodDesc,
          paymentTime: paymentTime,
          expireTime: expireTime,
          status: status,
          statusDesc: statusDesc,
          isValid: isValid,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
