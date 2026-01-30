//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/user_id.dart';
import 'package:built_collection/built_collection.dart';
import 'package:nova_api/src/model/group_id.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_group.g.dart';

/// ChatGroup
///
/// Properties:
/// * [id]
/// * [groupName]
/// * [avatar]
/// * [description]
/// * [ownerId]
/// * [classId]
/// * [maxMembers]
/// * [memberCount]
/// * [inviteMode]
/// * [joinMode]
/// * [announcement]
/// * [announcementTime]
/// * [createTime]
/// * [updateTime]
/// * [mute]
/// * [delete]
/// * [full]
@BuiltValue()
abstract class ChatGroup implements Built<ChatGroup, ChatGroupBuilder> {
  @BuiltValueField(wireName: r'id')
  GroupId? get id;

  @BuiltValueField(wireName: r'groupName')
  String? get groupName;

  @BuiltValueField(wireName: r'avatar')
  String? get avatar;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'ownerId')
  UserId? get ownerId;

  @BuiltValueField(wireName: r'classId')
  int? get classId;

  @BuiltValueField(wireName: r'maxMembers')
  int? get maxMembers;

  @BuiltValueField(wireName: r'memberCount')
  int? get memberCount;

  @BuiltValueField(wireName: r'inviteMode')
  ChatGroupInviteModeEnum? get inviteMode;
  // enum inviteModeEnum {  ALL,  ADMIN_ONLY,  };

  @BuiltValueField(wireName: r'joinMode')
  ChatGroupJoinModeEnum? get joinMode;
  // enum joinModeEnum {  FREE,  APPROVAL,  FORBIDDEN,  };

  @BuiltValueField(wireName: r'announcement')
  String? get announcement;

  @BuiltValueField(wireName: r'announcementTime')
  DateTime? get announcementTime;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  @BuiltValueField(wireName: r'mute')
  bool? get mute;

  @BuiltValueField(wireName: r'delete')
  bool? get delete;

  @BuiltValueField(wireName: r'full')
  bool? get full;

  ChatGroup._();

  factory ChatGroup([void updates(ChatGroupBuilder b)]) = _$ChatGroup;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatGroupBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatGroup> get serializer => _$ChatGroupSerializer();
}

class _$ChatGroupSerializer implements PrimitiveSerializer<ChatGroup> {
  @override
  final Iterable<Type> types = const [ChatGroup, _$ChatGroup];

  @override
  final String wireName = r'ChatGroup';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatGroup object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(GroupId),
      );
    }
    if (object.groupName != null) {
      yield r'groupName';
      yield serializers.serialize(
        object.groupName,
        specifiedType: const FullType(String),
      );
    }
    if (object.avatar != null) {
      yield r'avatar';
      yield serializers.serialize(
        object.avatar,
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
    if (object.ownerId != null) {
      yield r'ownerId';
      yield serializers.serialize(
        object.ownerId,
        specifiedType: const FullType(UserId),
      );
    }
    if (object.classId != null) {
      yield r'classId';
      yield serializers.serialize(
        object.classId,
        specifiedType: const FullType(int),
      );
    }
    if (object.maxMembers != null) {
      yield r'maxMembers';
      yield serializers.serialize(
        object.maxMembers,
        specifiedType: const FullType(int),
      );
    }
    if (object.memberCount != null) {
      yield r'memberCount';
      yield serializers.serialize(
        object.memberCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.inviteMode != null) {
      yield r'inviteMode';
      yield serializers.serialize(
        object.inviteMode,
        specifiedType: const FullType(ChatGroupInviteModeEnum),
      );
    }
    if (object.joinMode != null) {
      yield r'joinMode';
      yield serializers.serialize(
        object.joinMode,
        specifiedType: const FullType(ChatGroupJoinModeEnum),
      );
    }
    if (object.announcement != null) {
      yield r'announcement';
      yield serializers.serialize(
        object.announcement,
        specifiedType: const FullType(String),
      );
    }
    if (object.announcementTime != null) {
      yield r'announcementTime';
      yield serializers.serialize(
        object.announcementTime,
        specifiedType: const FullType(DateTime),
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
    if (object.mute != null) {
      yield r'mute';
      yield serializers.serialize(
        object.mute,
        specifiedType: const FullType(bool),
      );
    }
    if (object.delete != null) {
      yield r'delete';
      yield serializers.serialize(
        object.delete,
        specifiedType: const FullType(bool),
      );
    }
    if (object.full != null) {
      yield r'full';
      yield serializers.serialize(
        object.full,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatGroup object, {
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
    required ChatGroupBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GroupId),
          ) as GroupId;
          result.id.replace(valueDes);
          break;
        case r'groupName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.groupName = valueDes;
          break;
        case r'avatar':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.avatar = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.description = valueDes;
          break;
        case r'ownerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserId),
          ) as UserId;
          result.ownerId.replace(valueDes);
          break;
        case r'classId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classId = valueDes;
          break;
        case r'maxMembers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.maxMembers = valueDes;
          break;
        case r'memberCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.memberCount = valueDes;
          break;
        case r'inviteMode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChatGroupInviteModeEnum),
          ) as ChatGroupInviteModeEnum;
          result.inviteMode = valueDes;
          break;
        case r'joinMode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ChatGroupJoinModeEnum),
          ) as ChatGroupJoinModeEnum;
          result.joinMode = valueDes;
          break;
        case r'announcement':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.announcement = valueDes;
          break;
        case r'announcementTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.announcementTime = valueDes;
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
        case r'mute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mute = valueDes;
          break;
        case r'delete':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.delete = valueDes;
          break;
        case r'full':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.full = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatGroup deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatGroupBuilder();
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

class ChatGroupInviteModeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'ALL')
  static const ChatGroupInviteModeEnum ALL = _$chatGroupInviteModeEnum_ALL;
  @BuiltValueEnumConst(wireName: r'ADMIN_ONLY')
  static const ChatGroupInviteModeEnum ADMIN_ONLY =
      _$chatGroupInviteModeEnum_ADMIN_ONLY;

  static Serializer<ChatGroupInviteModeEnum> get serializer =>
      _$chatGroupInviteModeEnumSerializer;

  const ChatGroupInviteModeEnum._(String name) : super(name);

  static BuiltSet<ChatGroupInviteModeEnum> get values =>
      _$chatGroupInviteModeEnumValues;
  static ChatGroupInviteModeEnum valueOf(String name) =>
      _$chatGroupInviteModeEnumValueOf(name);
}

class ChatGroupJoinModeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'FREE')
  static const ChatGroupJoinModeEnum FREE = _$chatGroupJoinModeEnum_FREE;
  @BuiltValueEnumConst(wireName: r'APPROVAL')
  static const ChatGroupJoinModeEnum APPROVAL =
      _$chatGroupJoinModeEnum_APPROVAL;
  @BuiltValueEnumConst(wireName: r'FORBIDDEN')
  static const ChatGroupJoinModeEnum FORBIDDEN =
      _$chatGroupJoinModeEnum_FORBIDDEN;

  static Serializer<ChatGroupJoinModeEnum> get serializer =>
      _$chatGroupJoinModeEnumSerializer;

  const ChatGroupJoinModeEnum._(String name) : super(name);

  static BuiltSet<ChatGroupJoinModeEnum> get values =>
      _$chatGroupJoinModeEnumValues;
  static ChatGroupJoinModeEnum valueOf(String name) =>
      _$chatGroupJoinModeEnumValueOf(name);
}
