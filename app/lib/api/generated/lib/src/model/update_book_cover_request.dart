//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'dart:typed_data';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_book_cover_request.g.dart';

/// UpdateBookCoverRequest
///
/// Properties:
/// * [cover]
@BuiltValue()
abstract class UpdateBookCoverRequest
    implements Built<UpdateBookCoverRequest, UpdateBookCoverRequestBuilder> {
  @BuiltValueField(wireName: r'cover')
  Uint8List get cover;

  UpdateBookCoverRequest._();

  factory UpdateBookCoverRequest(
          [void updates(UpdateBookCoverRequestBuilder b)]) =
      _$UpdateBookCoverRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateBookCoverRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateBookCoverRequest> get serializer =>
      _$UpdateBookCoverRequestSerializer();
}

class _$UpdateBookCoverRequestSerializer
    implements PrimitiveSerializer<UpdateBookCoverRequest> {
  @override
  final Iterable<Type> types = const [
    UpdateBookCoverRequest,
    _$UpdateBookCoverRequest
  ];

  @override
  final String wireName = r'UpdateBookCoverRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateBookCoverRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'cover';
    yield serializers.serialize(
      object.cover,
      specifiedType: const FullType(Uint8List),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateBookCoverRequest object, {
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
    required UpdateBookCoverRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'cover':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Uint8List),
          ) as Uint8List;
          result.cover = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateBookCoverRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateBookCoverRequestBuilder();
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
