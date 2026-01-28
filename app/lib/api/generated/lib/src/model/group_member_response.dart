//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'group_member_response.g.dart';

/// GroupMemberResponse
///
/// Properties:
/// * [id]
/// * [groupId]
/// * [memberType]
/// * [userId]
/// * [aiRoleId]
/// * [role]
/// * [nickname]
/// * [muteUntil]
/// * [joinTime]
/// * [userName]
/// * [userAvatar]
/// * [mute]
@BuiltValue()
abstract class GroupMemberResponse
    implements Built<GroupMemberResponse, GroupMemberResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'groupId')
  int? get groupId;

  @BuiltValueField(wireName: r'memberType')
  int? get memberType;

  @BuiltValueField(wireName: r'userId')
  int? get userId;

  @BuiltValueField(wireName: r'aiRoleId')
  int? get aiRoleId;

  @BuiltValueField(wireName: r'role')
  int? get role;

  @BuiltValueField(wireName: r'nickname')
  String? get nickname;

  @BuiltValueField(wireName: r'muteUntil')
  DateTime? get muteUntil;

  @BuiltValueField(wireName: r'joinTime')
  DateTime? get joinTime;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  @BuiltValueField(wireName: r'mute')
  bool? get mute;

  GroupMemberResponse._();

  factory GroupMemberResponse([void updates(GroupMemberResponseBuilder b)]) =
      _$GroupMemberResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GroupMemberResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GroupMemberResponse> get serializer =>
      _$GroupMemberResponseSerializer();
}

class _$GroupMemberResponseSerializer
    implements PrimitiveSerializer<GroupMemberResponse> {
  @override
  final Iterable<Type> types = const [
    GroupMemberResponse,
    _$GroupMemberResponse
  ];

  @override
  final String wireName = r'GroupMemberResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GroupMemberResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.groupId != null) {
      yield r'groupId';
      yield serializers.serialize(
        object.groupId,
        specifiedType: const FullType(int),
      );
    }
    if (object.memberType != null) {
      yield r'memberType';
      yield serializers.serialize(
        object.memberType,
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
    if (object.aiRoleId != null) {
      yield r'aiRoleId';
      yield serializers.serialize(
        object.aiRoleId,
        specifiedType: const FullType(int),
      );
    }
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType(int),
      );
    }
    if (object.nickname != null) {
      yield r'nickname';
      yield serializers.serialize(
        object.nickname,
        specifiedType: const FullType(String),
      );
    }
    if (object.muteUntil != null) {
      yield r'muteUntil';
      yield serializers.serialize(
        object.muteUntil,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.joinTime != null) {
      yield r'joinTime';
      yield serializers.serialize(
        object.joinTime,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userAvatar != null) {
      yield r'userAvatar';
      yield serializers.serialize(
        object.userAvatar,
        specifiedType: const FullType(String),
      );
    }
    if (object.mute != null) {
      yield r'mute';
      yield serializers.serialize(
        object.mute,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GroupMemberResponse object, {
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
    required GroupMemberResponseBuilder result,
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
        case r'groupId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.groupId = valueDes;
          break;
        case r'memberType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.memberType = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'aiRoleId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.aiRoleId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.role = valueDes;
          break;
        case r'nickname':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nickname = valueDes;
          break;
        case r'muteUntil':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.muteUntil = valueDes;
          break;
        case r'joinTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.joinTime = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'userAvatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAvatar = valueDes;
          break;
        case r'mute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mute = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GroupMemberResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GroupMemberResponseBuilder();
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
