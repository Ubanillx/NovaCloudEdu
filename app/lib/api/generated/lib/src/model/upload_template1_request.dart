//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'dart:typed_data';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_template1_request.g.dart';

/// UploadTemplate1Request
///
/// Properties:
/// * [file] - Typst 模板文件 (.typ)
@BuiltValue()
abstract class UploadTemplate1Request
    implements Built<UploadTemplate1Request, UploadTemplate1RequestBuilder> {
  /// Typst 模板文件 (.typ)
  @BuiltValueField(wireName: r'file')
  Uint8List get file;

  UploadTemplate1Request._();

  factory UploadTemplate1Request(
          [void updates(UploadTemplate1RequestBuilder b)]) =
      _$UploadTemplate1Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadTemplate1RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadTemplate1Request> get serializer =>
      _$UploadTemplate1RequestSerializer();
}

class _$UploadTemplate1RequestSerializer
    implements PrimitiveSerializer<UploadTemplate1Request> {
  @override
  final Iterable<Type> types = const [
    UploadTemplate1Request,
    _$UploadTemplate1Request
  ];

  @override
  final String wireName = r'UploadTemplate1Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadTemplate1Request object, {
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
    UploadTemplate1Request object, {
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
    required UploadTemplate1RequestBuilder result,
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
  UploadTemplate1Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadTemplate1RequestBuilder();
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
