//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'upload_file_response.g.dart';

/// 文件上传响应
///
/// Properties:
/// * [fileUrl] - 文件URL
/// * [fileName] - 文件名
/// * [originalName] - 原始文件名
/// * [fileSize] - 文件大小（字节）
/// * [businessType] - 业务类型
@BuiltValue()
abstract class UploadFileResponse
    implements Built<UploadFileResponse, UploadFileResponseBuilder> {
  /// 文件URL
  @BuiltValueField(wireName: r'fileUrl')
  String? get fileUrl;

  /// 文件名
  @BuiltValueField(wireName: r'fileName')
  String? get fileName;

  /// 原始文件名
  @BuiltValueField(wireName: r'originalName')
  String? get originalName;

  /// 文件大小（字节）
  @BuiltValueField(wireName: r'fileSize')
  int? get fileSize;

  /// 业务类型
  @BuiltValueField(wireName: r'businessType')
  String? get businessType;

  UploadFileResponse._();

  factory UploadFileResponse([void updates(UploadFileResponseBuilder b)]) =
      _$UploadFileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UploadFileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UploadFileResponse> get serializer =>
      _$UploadFileResponseSerializer();
}

class _$UploadFileResponseSerializer
    implements PrimitiveSerializer<UploadFileResponse> {
  @override
  final Iterable<Type> types = const [UploadFileResponse, _$UploadFileResponse];

  @override
  final String wireName = r'UploadFileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UploadFileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.fileUrl != null) {
      yield r'fileUrl';
      yield serializers.serialize(
        object.fileUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileName != null) {
      yield r'fileName';
      yield serializers.serialize(
        object.fileName,
        specifiedType: const FullType(String),
      );
    }
    if (object.originalName != null) {
      yield r'originalName';
      yield serializers.serialize(
        object.originalName,
        specifiedType: const FullType(String),
      );
    }
    if (object.fileSize != null) {
      yield r'fileSize';
      yield serializers.serialize(
        object.fileSize,
        specifiedType: const FullType(int),
      );
    }
    if (object.businessType != null) {
      yield r'businessType';
      yield serializers.serialize(
        object.businessType,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UploadFileResponse object, {
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
    required UploadFileResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fileUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileUrl = valueDes;
          break;
        case r'fileName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileName = valueDes;
          break;
        case r'originalName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.originalName = valueDes;
          break;
        case r'fileSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fileSize = valueDes;
          break;
        case r'businessType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.businessType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UploadFileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UploadFileResponseBuilder();
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
