//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_member_response.g.dart';

/// 班级成员响应
///
/// Properties:
/// * [id] - 成员ID
/// * [classId] - 班级ID
/// * [userId] - 用户ID
/// * [role] - 角色
/// * [joinTime] - 加入时间
@BuiltValue()
abstract class ClassMemberResponse
    implements Built<ClassMemberResponse, ClassMemberResponseBuilder> {
  /// 成员ID
  @BuiltValueField(wireName: r'id')
  String? get id;

  /// 班级ID
  @BuiltValueField(wireName: r'classId')
  String? get classId;

  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  String? get userId;

  /// 角色
  @BuiltValueField(wireName: r'role')
  String? get role;

  /// 加入时间
  @BuiltValueField(wireName: r'joinTime')
  DateTime? get joinTime;

  ClassMemberResponse._();

  factory ClassMemberResponse([void updates(ClassMemberResponseBuilder b)]) =
      _$ClassMemberResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassMemberResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassMemberResponse> get serializer =>
      _$ClassMemberResponseSerializer();
}

class _$ClassMemberResponseSerializer
    implements PrimitiveSerializer<ClassMemberResponse> {
  @override
  final Iterable<Type> types = const [
    ClassMemberResponse,
    _$ClassMemberResponse
  ];

  @override
  final String wireName = r'ClassMemberResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassMemberResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(String),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(String),
      );
    }
    if (object.joinTime != null) {
      yield r'joinTime';
      yield serializers.serialize(
        object.joinTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClassMemberResponse object, {
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
    required ClassMemberResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.classId = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'joinTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.joinTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClassMemberResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassMemberResponseBuilder();
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
