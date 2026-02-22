//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'check_permission_request.g.dart';

/// CheckPermissionRequest
///
/// Properties:
/// * [callerId]
/// * [calleeId]
@BuiltValue()
abstract class CheckPermissionRequest
    implements Built<CheckPermissionRequest, CheckPermissionRequestBuilder> {
  @BuiltValueField(wireName: r'callerId')
  int? get callerId;

  @BuiltValueField(wireName: r'calleeId')
  int? get calleeId;

  CheckPermissionRequest._();

  factory CheckPermissionRequest(
          [void updates(CheckPermissionRequestBuilder b)]) =
      _$CheckPermissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckPermissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckPermissionRequest> get serializer =>
      _$CheckPermissionRequestSerializer();
}

class _$CheckPermissionRequestSerializer
    implements PrimitiveSerializer<CheckPermissionRequest> {
  @override
  final Iterable<Type> types = const [
    CheckPermissionRequest,
    _$CheckPermissionRequest
  ];

  @override
  final String wireName = r'CheckPermissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckPermissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.callerId != null) {
      yield r'callerId';
      yield serializers.serialize(
        object.callerId,
        specifiedType: const FullType(int),
      );
    }
    if (object.calleeId != null) {
      yield r'calleeId';
      yield serializers.serialize(
        object.calleeId,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckPermissionRequest object, {
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
    required CheckPermissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'callerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.callerId = valueDes;
          break;
        case r'calleeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.calleeId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckPermissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckPermissionRequestBuilder();
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
