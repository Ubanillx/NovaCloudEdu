//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_profile_request.g.dart';

/// UpdateProfileRequest
///
/// Properties:
/// * [userName]
/// * [userAvatar]
/// * [userProfile]
/// * [userGender]
/// * [userPhone]
/// * [userEmail]
/// * [userAddress]
/// * [birthday]
@BuiltValue()
abstract class UpdateProfileRequest
    implements Built<UpdateProfileRequest, UpdateProfileRequestBuilder> {
  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  @BuiltValueField(wireName: r'userProfile')
  String? get userProfile;

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

  UpdateProfileRequest._();

  factory UpdateProfileRequest([void updates(UpdateProfileRequestBuilder b)]) =
      _$UpdateProfileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateProfileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateProfileRequest> get serializer =>
      _$UpdateProfileRequestSerializer();
}

class _$UpdateProfileRequestSerializer
    implements PrimitiveSerializer<UpdateProfileRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateProfileRequest,
    _$UpdateProfileRequest
  ];

  @override
  final String wireName = r'UpdateProfileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateProfileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateProfileRequest object, {
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
    required UpdateProfileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateProfileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateProfileRequestBuilder();
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
