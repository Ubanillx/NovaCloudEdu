//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:nova_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_user_request.g.dart';

/// CreateUserRequest
///
/// Properties:
/// * [userAccount]
/// * [userPassword]
/// * [userName]
/// * [role]
/// * [userGender]
/// * [userPhone]
/// * [userEmail]
/// * [userAddress]
/// * [birthday]
@BuiltValue()
abstract class CreateUserRequest
    implements Built<CreateUserRequest, CreateUserRequestBuilder> {
  @BuiltValueField(wireName: r'userAccount')
  String get userAccount;

  @BuiltValueField(wireName: r'userPassword')
  String get userPassword;

  @BuiltValueField(wireName: r'userName')
  String? get userName;

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

  CreateUserRequest._();

  factory CreateUserRequest([void updates(CreateUserRequestBuilder b)]) =
      _$CreateUserRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateUserRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateUserRequest> get serializer =>
      _$CreateUserRequestSerializer();
}

class _$CreateUserRequestSerializer
    implements PrimitiveSerializer<CreateUserRequest> {
  @override
  final Iterable<Type> types = const [CreateUserRequest, _$CreateUserRequest];

  @override
  final String wireName = r'CreateUserRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateUserRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userAccount';
    yield serializers.serialize(
      object.userAccount,
      specifiedType: const FullType(String),
    );
    yield r'userPassword';
    yield serializers.serialize(
      object.userPassword,
      specifiedType: const FullType(String),
    );
    if (object.userName != null) {
      yield r'userName';
      yield serializers.serialize(
        object.userName,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateUserRequest object, {
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
    required CreateUserRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAccount = valueDes;
          break;
        case r'userPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userPassword = valueDes;
          break;
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateUserRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateUserRequestBuilder();
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
