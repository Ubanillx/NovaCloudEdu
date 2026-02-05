//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_token_response.g.dart';

/// 刷新Token响应
///
/// Properties:
/// * [token] - 新的Access Token
/// * [refreshToken] - 新的Refresh Token
@BuiltValue()
abstract class RefreshTokenResponse
    implements Built<RefreshTokenResponse, RefreshTokenResponseBuilder> {
  /// 新的Access Token
  @BuiltValueField(wireName: r'token')
  String? get token;

  /// 新的Refresh Token
  @BuiltValueField(wireName: r'refreshToken')
  String? get refreshToken;

  RefreshTokenResponse._();

  factory RefreshTokenResponse([void updates(RefreshTokenResponseBuilder b)]) =
      _$RefreshTokenResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RefreshTokenResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RefreshTokenResponse> get serializer =>
      _$RefreshTokenResponseSerializer();
}

class _$RefreshTokenResponseSerializer
    implements PrimitiveSerializer<RefreshTokenResponse> {
  @override
  final Iterable<Type> types = const [
    RefreshTokenResponse,
    _$RefreshTokenResponse
  ];

  @override
  final String wireName = r'RefreshTokenResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RefreshTokenResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
    if (object.refreshToken != null) {
      yield r'refreshToken';
      yield serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RefreshTokenResponse object, {
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
    required RefreshTokenResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'refreshToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RefreshTokenResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RefreshTokenResponseBuilder();
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
