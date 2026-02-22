//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_plan_request.g.dart';

/// 创建会员计划请求
///
/// Properties:
/// * [name] - 计划名称
/// * [code] - 计划编码：FREE/BASIC/PRO/TEACHER
/// * [price] - 价格
/// * [description] - 计划描述
/// * [durationDays] - 有效期天数，0表示永久
@BuiltValue()
abstract class CreatePlanRequest
    implements Built<CreatePlanRequest, CreatePlanRequestBuilder> {
  /// 计划名称
  @BuiltValueField(wireName: r'name')
  String get name;

  /// 计划编码：FREE/BASIC/PRO/TEACHER
  @BuiltValueField(wireName: r'code')
  String get code;

  /// 价格
  @BuiltValueField(wireName: r'price')
  num get price;

  /// 计划描述
  @BuiltValueField(wireName: r'description')
  String? get description;

  /// 有效期天数，0表示永久
  @BuiltValueField(wireName: r'durationDays')
  int? get durationDays;

  CreatePlanRequest._();

  factory CreatePlanRequest([void updates(CreatePlanRequestBuilder b)]) =
      _$CreatePlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatePlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatePlanRequest> get serializer =>
      _$CreatePlanRequestSerializer();
}

class _$CreatePlanRequestSerializer
    implements PrimitiveSerializer<CreatePlanRequest> {
  @override
  final Iterable<Type> types = const [CreatePlanRequest, _$CreatePlanRequest];

  @override
  final String wireName = r'CreatePlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'price';
    yield serializers.serialize(
      object.price,
      specifiedType: const FullType(num),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
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
    CreatePlanRequest object, {
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
    required CreatePlanRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.price = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
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
  CreatePlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatePlanRequestBuilder();
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
