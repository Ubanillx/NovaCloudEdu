//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'dart:typed_data';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_template_request.g.dart';

/// UploadTemplateRequest
///
/// Properties:
/// * [file] - PPTX模板文件
@BuiltValue()
abstract class UploadTemplateRequest
    implements Built<UploadTemplateRequest, UploadTemplateRequestBuilder> {
  /// PPTX模板文件
  @BuiltValueField(wireName: r'file')
  Uint8List get file;

  UploadTemplateRequest._();

  factory UploadTemplateRequest(
      [void updates(UploadTemplateRequestBuilder b)]) = _$UploadTemplateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadTemplateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadTemplateRequest> get serializer =>
      _$UploadTemplateRequestSerializer();
}

class _$UploadTemplateRequestSerializer
    implements PrimitiveSerializer<UploadTemplateRequest> {
  @override
  final Iterable<Type> types = const [
    UploadTemplateRequest,
    _$UploadTemplateRequest
  ];

  @override
  final String wireName = r'UploadTemplateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadTemplateRequest object, {
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
    UploadTemplateRequest object, {
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
    required UploadTemplateRequestBuilder result,
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
  UploadTemplateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadTemplateRequestBuilder();
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
