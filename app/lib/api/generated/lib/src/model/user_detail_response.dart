//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_detail_response.g.dart';

/// UserDetailResponse
///
/// Properties:
/// * [id]
/// * [userAccount]
/// * [userName]
/// * [userAvatar]
/// * [userProfile]
/// * [role]
/// * [userGender]
/// * [userPhone]
/// * [userEmail]
/// * [userAddress]
/// * [birthday]
/// * [level]
/// * [banned]
/// * [createTime]
/// * [updateTime]
@BuiltValue()
abstract class UserDetailResponse
    implements Built<UserDetailResponse, UserDetailResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  int? get id;

  @BuiltValueField(wireName: r'userAccount')
  String? get userAccount;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  @BuiltValueField(wireName: r'userProfile')
  String? get userProfile;

  @BuiltValueField(wireName: r'role')
  String? get role;

  @BuiltValueField(wireName: r'userGender')
  int? get userGender;

  @BuiltValueField(wireName: r'userPhone')
  String? get userPhone;

  @BuiltValueField(wireName: r'userEmail')
  String? get userEmail;

  @BuiltValueField(wireName: r'userAddress')
  String? get userAddress;

  @BuiltValueField(wireName: r'birthday')
  Date? get birthday;

  @BuiltValueField(wireName: r'level')
  int? get level;

  @BuiltValueField(wireName: r'banned')
  bool? get banned;

  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  @BuiltValueField(wireName: r'updateTime')
  DateTime? get updateTime;

  UserDetailResponse._();

  factory UserDetailResponse([void updates(UserDetailResponseBuilder b)]) =
      _$UserDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserDetailResponse> get serializer =>
      _$UserDetailResponseSerializer();
}

class _$UserDetailResponseSerializer
    implements PrimitiveSerializer<UserDetailResponse> {
  @override
  final Iterable<Type> types = const [UserDetailResponse, _$UserDetailResponse];

  @override
  final String wireName = r'UserDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
      );
    }
    if (object.userAccount != null) {
      yield r'userAccount';
      yield serializers.serialize(
        object.userAccount,
        specifiedType: const FullType(String),
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
    if (object.userProfile != null) {
      yield r'userProfile';
      yield serializers.serialize(
        object.userProfile,
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
    if (object.userGender != null) {
      yield r'userGender';
      yield serializers.serialize(
        object.userGender,
        specifiedType: const FullType(int),
      );
    }
    if (object.userPhone != null) {
      yield r'userPhone';
      yield serializers.serialize(
        object.userPhone,
        specifiedType: const FullType(String),
      );
    }
    if (object.userEmail != null) {
      yield r'userEmail';
      yield serializers.serialize(
        object.userEmail,
        specifiedType: const FullType(String),
      );
    }
    if (object.userAddress != null) {
      yield r'userAddress';
      yield serializers.serialize(
        object.userAddress,
        specifiedType: const FullType(String),
      );
    }
    if (object.birthday != null) {
      yield r'birthday';
      yield serializers.serialize(
        object.birthday,
        specifiedType: const FullType(Date),
      );
    }
    if (object.level != null) {
      yield r'level';
      yield serializers.serialize(
        object.level,
        specifiedType: const FullType(int),
      );
    }
    if (object.banned != null) {
      yield r'banned';
      yield serializers.serialize(
        object.banned,
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
    UserDetailResponse object, {
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
    required UserDetailResponseBuilder result,
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
        case r'userAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAccount = valueDes;
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
        case r'userProfile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userProfile = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'userGender':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userGender = valueDes;
          break;
        case r'userPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userPhone = valueDes;
          break;
        case r'userEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userEmail = valueDes;
          break;
        case r'userAddress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAddress = valueDes;
          break;
        case r'birthday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.birthday = valueDes;
          break;
        case r'level':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.level = valueDes;
          break;
        case r'banned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.banned = valueDes;
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
  UserDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserDetailResponseBuilder();
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
