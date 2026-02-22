//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/user_membership.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'base_response_list_user_membership.g.dart';

/// BaseResponseListUserMembership
///
/// Properties:
/// * [code]
/// * [data]
/// * [message]
@BuiltValue()
abstract class BaseResponseListUserMembership
    implements
        Built<BaseResponseListUserMembership,
            BaseResponseListUserMembershipBuilder> {
  @BuiltValueField(wireName: r'code')
  int? get code;

  @BuiltValueField(wireName: r'data')
  BuiltList<UserMembership>? get data;

  @BuiltValueField(wireName: r'message')
  String? get message;

  BaseResponseListUserMembership._();

  factory BaseResponseListUserMembership(
          [void updates(BaseResponseListUserMembershipBuilder b)]) =
      _$BaseResponseListUserMembership;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BaseResponseListUserMembershipBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BaseResponseListUserMembership> get serializer =>
      _$BaseResponseListUserMembershipSerializer();
}

class _$BaseResponseListUserMembershipSerializer
    implements PrimitiveSerializer<BaseResponseListUserMembership> {
  @override
  final Iterable<Type> types = const [
    BaseResponseListUserMembership,
    _$BaseResponseListUserMembership
  ];

  @override
  final String wireName = r'BaseResponseListUserMembership';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BaseResponseListUserMembership object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(int),
      );
    }
    if (object.data != null) {
      yield r'data';
      yield serializers.serialize(
        object.data,
        specifiedType: const FullType(BuiltList, [FullType(UserMembership)]),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BaseResponseListUserMembership object, {
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
    required BaseResponseListUserMembershipBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.code = valueDes;
          break;
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(UserMembership)]),
          ) as BuiltList<UserMembership>;
          result.data.replace(valueDes);
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BaseResponseListUserMembership deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BaseResponseListUserMembershipBuilder();
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
