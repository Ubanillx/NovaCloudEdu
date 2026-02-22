//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_response.g.dart';

/// 订单信息响应
///
/// Properties:
/// * [orderType] - 订单类型：COURSE-课程订单，MEMBERSHIP-会员订单
/// * [productName] - 商品名称（课程名/会员计划名）
/// * [id] - 订单ID
/// * [userId] - 用户ID
/// * [courseId] - 课程ID
/// * [orderNo] - 订单号
/// * [price] - 购买价格
/// * [paymentMethod] - 支付方式
/// * [paymentMethodDesc] - 支付方式描述
/// * [paymentTime] - 支付时间
/// * [expireTime] - 过期时间
/// * [status] - 订单状态：0-未支付，1-已支付，2-已过期，3-已退款
/// * [statusDesc] - 订单状态描述
/// * [isValid] - 是否有效
/// * [createTime] - 创建时间
/// * [updateTime] - 更新时间
@BuiltValue()
abstract class OrderResponse
    implements Built<OrderResponse, OrderResponseBuilder> {
  /// 订单类型：COURSE-课程订单，MEMBERSHIP-会员订单
  @BuiltValueField(wireName: r'orderType')
  String? get orderType;

  /// 商品名称（课程名/会员计划名）
  @BuiltValueField(wireName: r'productName')
  String? get productName;

  /// 订单ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 课程ID
  @BuiltValueField(wireName: r'courseId')
  int? get courseId;

  /// 订单号
  @BuiltValueField(wireName: r'orderNo')
  String? get orderNo;

  /// 购买价格
  @BuiltValueField(wireName: r'price')
  num? get price;

  /// 支付方式
  @BuiltValueField(wireName: r'paymentMethod')
  int? get paymentMethod;

  /// 支付方式描述
  @BuiltValueField(wireName: r'paymentMethodDesc')
  String? get paymentMethodDesc;

  /// 支付时间
  @BuiltValueField(wireName: r'paymentTime')
  DateTime? get paymentTime;

  /// 过期时间
  @BuiltValueField(wireName: r'expireTime')
  DateTime? get expireTime;

  /// 订单状态：0-未支付，1-已支付，2-已过期，3-已退款
  @BuiltValueField(wireName: r'status')
  int? get status;

  /// 订单状态描述
  @BuiltValueField(wireName: r'statusDesc')
  String? get statusDesc;

  /// 是否有效
  @BuiltValueField(wireName: r'isValid')
  bool? get isValid;

  /// 创建时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  /// 更新时间
  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  OrderResponse._();

  factory OrderResponse([void updates(OrderResponseBuilder b)]) =
      _$OrderResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderResponse> get serializer =>
      _$OrderResponseSerializer();
}

class _$OrderResponseSerializer implements PrimitiveSerializer<OrderResponse> {
  @override
  final Iterable<Type> types = const [OrderResponse, _$OrderResponse];

  @override
  final String wireName = r'OrderResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.orderType != null) {
      yield r'orderType';
      yield serializers.serialize(
        object.orderType,
        specifiedType: const FullType(String),
      );
    }
    if (object.productName != null) {
      yield r'productName';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType(String),
      );
    }
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(int),
      );
    }
    if (object.courseId != null) {
      yield r'courseId';
      yield serializers.serialize(
        object.courseId,
        specifiedType: const FullType(int),
      );
    }
    if (object.orderNo != null) {
      yield r'orderNo';
      yield serializers.serialize(
        object.orderNo,
        specifiedType: const FullType(String),
      );
    }
    if (object.price != null) {
      yield r'price';
      yield serializers.serialize(
        object.price,
        specifiedType: const FullType(num),
      );
    }
    if (object.paymentMethod != null) {
      yield r'paymentMethod';
      yield serializers.serialize(
        object.paymentMethod,
        specifiedType: const FullType(int),
      );
    }
    if (object.paymentMethodDesc != null) {
      yield r'paymentMethodDesc';
      yield serializers.serialize(
        object.paymentMethodDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.paymentTime != null) {
      yield r'paymentTime';
      yield serializers.serialize(
        object.paymentTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.expireTime != null) {
      yield r'expireTime';
      yield serializers.serialize(
        object.expireTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(int),
      );
    }
    if (object.statusDesc != null) {
      yield r'statusDesc';
      yield serializers.serialize(
        object.statusDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.isValid != null) {
      yield r'isValid';
      yield serializers.serialize(
        object.isValid,
        specifiedType: const FullType(bool),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updateTime != null) {
      yield r'updateTime';
      yield serializers.serialize(
        object.updateTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderType = valueDes;
          break;
        case r'productName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'courseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.courseId = valueDes;
          break;
        case r'orderNo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderNo = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'paymentMethod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.paymentMethod = valueDes;
          break;
        case r'paymentMethodDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.paymentMethodDesc = valueDes;
          break;
        case r'paymentTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.paymentTime = valueDes;
          break;
        case r'expireTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expireTime = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.status = valueDes;
          break;
        case r'statusDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.statusDesc = valueDes;
          break;
        case r'isValid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isValid = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        case r'updateTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updateTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
