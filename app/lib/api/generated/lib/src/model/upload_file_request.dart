//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'dart:typed_data';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_file_request.g.dart';

/// UploadFileRequest
///
/// Properties:
/// * [file] - 文件
@BuiltValue()
abstract class UploadFileRequest
    implements Built<UploadFileRequest, UploadFileRequestBuilder> {
  /// 文件
  @BuiltValueField(wireName: r'file')
  Uint8List get file;

  UploadFileRequest._();

  factory UploadFileRequest([void updates(UploadFileRequestBuilder b)]) =
      _$UploadFileRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadFileRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadFileRequest> get serializer =>
      _$UploadFileRequestSerializer();
}

class _$UploadFileRequestSerializer
    implements PrimitiveSerializer<UploadFileRequest> {
  @override
  final Iterable<Type> types = const [UploadFileRequest, _$UploadFileRequest];

  @override
  final String wireName = r'UploadFileRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadFileRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'file';
    yield serializers.serialize(
      object.file,
      specifiedType: const FullType(Uint8List),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadFileRequest object, {
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
    required UploadFileRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'file':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Uint8List),
          ) as Uint8List;
          result.file = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadFileRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadFileRequestBuilder();
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
