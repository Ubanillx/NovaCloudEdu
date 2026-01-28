//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_info_response.g.dart';

/// 文件信息响应
///
/// Properties:
/// * [id] - 文件ID
/// * [fileName] - 文件名
/// * [originalName] - 原始文件名
/// * [fileUrl] - 文件URL
/// * [fileSize] - 文件大小（字节）
/// * [contentType] - 文件类型
/// * [businessType] - 业务类型
/// * [businessTypeDesc] - 业务类型描述
/// * [uploaderId] - 上传者ID
/// * [createTime] - 上传时间
@BuiltValue()
abstract class FileInfoResponse
    implements Built<FileInfoResponse, FileInfoResponseBuilder> {
  /// 文件ID
  @BuiltValueField(wireName: r'id')
  int? get id;

  /// 文件名
  @BuiltValueField(wireName: r'fileName')
  String? get fileName;

  /// 原始文件名
  @BuiltValueField(wireName: r'originalName')
  String? get originalName;

  /// 文件URL
  @BuiltValueField(wireName: r'fileUrl')
  String? get fileUrl;

  /// 文件大小（字节）
  @BuiltValueField(wireName: r'fileSize')
  int? get fileSize;

  /// 文件类型
  @BuiltValueField(wireName: r'contentType')
  String? get contentType;

  /// 业务类型
  @BuiltValueField(wireName: r'businessType')
  String? get businessType;

  /// 业务类型描述
  @BuiltValueField(wireName: r'businessTypeDesc')
  String? get businessTypeDesc;

  /// 上传者ID
  @BuiltValueField(wireName: r'uploaderId')
  int? get uploaderId;

  /// 上传时间
  @BuiltValueField(wireName: r'createTime')
  DateTime? get createTime;

  FileInfoResponse._();

  factory FileInfoResponse([void updates(FileInfoResponseBuilder b)]) =
      _$FileInfoResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileInfoResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileInfoResponse> get serializer =>
      _$FileInfoResponseSerializer();
}

class _$FileInfoResponseSerializer
    implements PrimitiveSerializer<FileInfoResponse> {
  @override
  final Iterable<Type> types = const [FileInfoResponse, _$FileInfoResponse];

  @override
  final String wireName = r'FileInfoResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileInfoResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(int),
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
    if (object.fileUrl != null) {
      yield r'fileUrl';
      yield serializers.serialize(
        object.fileUrl,
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
    if (object.contentType != null) {
      yield r'contentType';
      yield serializers.serialize(
        object.contentType,
        specifiedType: const FullType(String),
      );
    }
    if (object.businessType != null) {
      yield r'businessType';
      yield serializers.serialize(
        object.businessType,
        specifiedType: const FullType(String),
      );
    }
    if (object.businessTypeDesc != null) {
      yield r'businessTypeDesc';
      yield serializers.serialize(
        object.businessTypeDesc,
        specifiedType: const FullType(String),
      );
    }
    if (object.uploaderId != null) {
      yield r'uploaderId';
      yield serializers.serialize(
        object.uploaderId,
        specifiedType: const FullType(int),
      );
    }
    if (object.createTime != null) {
      yield r'createTime';
      yield serializers.serialize(
        object.createTime,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FileInfoResponse object, {
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
    required FileInfoResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
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
        case r'fileUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileUrl = valueDes;
          break;
        case r'fileSize':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.fileSize = valueDes;
          break;
        case r'contentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.contentType = valueDes;
          break;
        case r'businessType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.businessType = valueDes;
          break;
        case r'businessTypeDesc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.businessTypeDesc = valueDes;
          break;
        case r'uploaderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.uploaderId = valueDes;
          break;
        case r'createTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createTime = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileInfoResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileInfoResponseBuilder();
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
