//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_password_request.g.dart';

/// ChangePasswordRequest
///
/// Properties:
/// * [oldPassword]
/// * [newPassword]
/// * [confirmPassword]
@BuiltValue()
abstract class ChangePasswordRequest
    implements Built<ChangePasswordRequest, ChangePasswordRequestBuilder> {
  @BuiltValueField(wireName: r'oldPassword')
  String get oldPassword;

  @BuiltValueField(wireName: r'newPassword')
  String get newPassword;

  @BuiltValueField(wireName: r'confirmPassword')
  String get confirmPassword;

  ChangePasswordRequest._();

  factory ChangePasswordRequest(
      [void updates(ChangePasswordRequestBuilder b)]) = _$ChangePasswordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangePasswordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangePasswordRequest> get serializer =>
      _$ChangePasswordRequestSerializer();
}

class _$ChangePasswordRequestSerializer
    implements PrimitiveSerializer<ChangePasswordRequest> {
  @override
  final Iterable<Type> types = const [
    ChangePasswordRequest,
    _$ChangePasswordRequest
  ];

  @override
  final String wireName = r'ChangePasswordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangePasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'oldPassword';
    yield serializers.serialize(
      object.oldPassword,
      specifiedType: const FullType(String),
    );
    yield r'newPassword';
    yield serializers.serialize(
      object.newPassword,
      specifiedType: const FullType(String),
    );
    yield r'confirmPassword';
    yield serializers.serialize(
      object.confirmPassword,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangePasswordRequest object, {
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
    required ChangePasswordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'oldPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.oldPassword = valueDes;
          break;
        case r'newPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPassword = valueDes;
          break;
        case r'confirmPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.confirmPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChangePasswordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangePasswordRequestBuilder();
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
