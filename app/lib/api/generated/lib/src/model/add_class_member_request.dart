//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_class_member_request.g.dart';

/// 添加班级成员请求
///
/// Properties:
/// * [userId] - 用户ID
/// * [role] - 角色(TEACHER/STUDENT)
@BuiltValue()
abstract class AddClassMemberRequest
    implements Built<AddClassMemberRequest, AddClassMemberRequestBuilder> {
  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int get userId;

  /// 角色(TEACHER/STUDENT)
  @BuiltValueField(wireName: r'role')
  String get role;

  AddClassMemberRequest._();

  factory AddClassMemberRequest(
      [void updates(AddClassMemberRequestBuilder b)]) = _$AddClassMemberRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddClassMemberRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddClassMemberRequest> get serializer =>
      _$AddClassMemberRequestSerializer();
}

class _$AddClassMemberRequestSerializer
    implements PrimitiveSerializer<AddClassMemberRequest> {
  @override
  final Iterable<Type> types = const [
    AddClassMemberRequest,
    _$AddClassMemberRequest
  ];

  @override
  final String wireName = r'AddClassMemberRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddClassMemberRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddClassMemberRequest object, {
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
    required AddClassMemberRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddClassMemberRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddClassMemberRequestBuilder();
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
