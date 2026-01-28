//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'search_user_response.g.dart';

/// 搜索用户响应
///
/// Properties:
/// * [userId] - 用户ID
/// * [userAccount] - 用户账号
/// * [userName] - 用户名
/// * [userAvatar] - 用户头像
/// * [userProfile] - 个人简介
/// * [isFriend] - 是否已是好友
/// * [hasPendingRequest] - 是否有待处理的申请
@BuiltValue()
abstract class SearchUserResponse
    implements Built<SearchUserResponse, SearchUserResponseBuilder> {
  /// 用户ID
  @BuiltValueField(wireName: r'userId')
  int? get userId;

  /// 用户账号
  @BuiltValueField(wireName: r'userAccount')
  String? get userAccount;

  /// 用户名
  @BuiltValueField(wireName: r'userName')
  String? get userName;

  /// 用户头像
  @BuiltValueField(wireName: r'userAvatar')
  String? get userAvatar;

  /// 个人简介
  @BuiltValueField(wireName: r'userProfile')
  String? get userProfile;

  /// 是否已是好友
  @BuiltValueField(wireName: r'isFriend')
  bool? get isFriend;

  /// 是否有待处理的申请
  @BuiltValueField(wireName: r'hasPendingRequest')
  bool? get hasPendingRequest;

  SearchUserResponse._();

  factory SearchUserResponse([void updates(SearchUserResponseBuilder b)]) =
      _$SearchUserResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SearchUserResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SearchUserResponse> get serializer =>
      _$SearchUserResponseSerializer();
}

class _$SearchUserResponseSerializer
    implements PrimitiveSerializer<SearchUserResponse> {
  @override
  final Iterable<Type> types = const [SearchUserResponse, _$SearchUserResponse];

  @override
  final String wireName = r'SearchUserResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SearchUserResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
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
    if (object.isFriend != null) {
      yield r'isFriend';
      yield serializers.serialize(
        object.isFriend,
        specifiedType: const FullType(bool),
      );
    }
    if (object.hasPendingRequest != null) {
      yield r'hasPendingRequest';
      yield serializers.serialize(
        object.hasPendingRequest,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SearchUserResponse object, {
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
    required SearchUserResponseBuilder result,
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
        case r'isFriend':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isFriend = valueDes;
          break;
        case r'hasPendingRequest':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasPendingRequest = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SearchUserResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SearchUserResponseBuilder();
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
