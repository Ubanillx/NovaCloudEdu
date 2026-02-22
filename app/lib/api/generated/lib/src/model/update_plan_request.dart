//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_plan_request.g.dart';

/// 更新会员计划请求
///
/// Properties:
/// * [id] - 计划ID
/// * [name] - 计划名称
/// * [description] - 计划描述
/// * [price] - 价格
/// * [durationDays] - 有效期天数
@BuiltValue()
abstract class UpdatePlanRequest
    implements Built<UpdatePlanRequest, UpdatePlanRequestBuilder> {
  /// 计划ID
  @BuiltValueField(wireName: r'id')
  int get id;

  /// 计划名称
  @BuiltValueField(wireName: r'name')
  String? get name;

  /// 计划描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 价格
  @BuiltValueField(wireName: r'price')
  num? get price;

  /// 有效期天数
  @BuiltValueField(wireName: r'durationDays')
  int? get durationDays;

  UpdatePlanRequest._();

  factory UpdatePlanRequest([void updates(UpdatePlanRequestBuilder b)]) =
      _$UpdatePlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdatePlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdatePlanRequest> get serializer =>
      _$UpdatePlanRequestSerializer();
}

class _$UpdatePlanRequestSerializer
    implements PrimitiveSerializer<UpdatePlanRequest> {
  @override
  final Iterable<Type> types = const [UpdatePlanRequest, _$UpdatePlanRequest];

  @override
  final String wireName = r'UpdatePlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
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
    if (object.durationDays != null) {
      yield r'durationDays';
      yield serializers.serialize(
        object.durationDays,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdatePlanRequest object, {
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
    required UpdatePlanRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'durationDays':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.durationDays = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdatePlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdatePlanRequestBuilder();
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
