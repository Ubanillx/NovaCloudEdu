//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_payment_request.g.dart';

/// 确认支付请求（管理员）
///
/// Properties:
/// * [orderNo] - 订单号
/// * [paymentMethod] - 支付方式：0-手动确认，1-支付宝，2-微信支付，3-银联支付
/// * [validityDays] - 有效期（天数），null表示永久有效
@BuiltValue()
abstract class ConfirmPaymentRequest
    implements Built<ConfirmPaymentRequest, ConfirmPaymentRequestBuilder> {
  /// 订单号
  @BuiltValueField(wireName: r'orderNo')
  String get orderNo;

  /// 支付方式：0-手动确认，1-支付宝，2-微信支付，3-银联支付
  @BuiltValueField(wireName: r'paymentMethod')
  int get paymentMethod;

  /// 有效期（天数），null表示永久有效
  @BuiltValueField(wireName: r'validityDays')
  int? get validityDays;

  ConfirmPaymentRequest._();

  factory ConfirmPaymentRequest(
      [void updates(ConfirmPaymentRequestBuilder b)]) = _$ConfirmPaymentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmPaymentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmPaymentRequest> get serializer =>
      _$ConfirmPaymentRequestSerializer();
}

class _$ConfirmPaymentRequestSerializer
    implements PrimitiveSerializer<ConfirmPaymentRequest> {
  @override
  final Iterable<Type> types = const [
    ConfirmPaymentRequest,
    _$ConfirmPaymentRequest
  ];

  @override
  final String wireName = r'ConfirmPaymentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmPaymentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'orderNo';
    yield serializers.serialize(
      object.orderNo,
      specifiedType: const FullType(String),
    );
    yield r'paymentMethod';
    yield serializers.serialize(
      object.paymentMethod,
      specifiedType: const FullType(int),
    );
    if (object.validityDays != null) {
      yield r'validityDays';
      yield serializers.serialize(
        object.validityDays,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmPaymentRequest object, {
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
    required ConfirmPaymentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orderNo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderNo = valueDes;
          break;
        case r'paymentMethod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.paymentMethod = valueDes;
          break;
        case r'validityDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.validityDays = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConfirmPaymentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmPaymentRequestBuilder();
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
