import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../core/network/api_client.dart';

/// 文件上传响应
class UploadFileResult {
  final String? fileUrl;
  final String? fileName;
  final String? originalName;
  final int? fileSize;
  final String? businessType;

  UploadFileResult({
    this.fileUrl,
    this.fileName,
    this.originalName,
    this.fileSize,
    this.businessType,
  });

  factory UploadFileResult.fromJson(Map<String, dynamic> json) {
    return UploadFileResult(
      fileUrl: json['fileUrl'] as String?,
      fileName: json['fileName'] as String?,
      originalName: json['originalName'] as String?,
      fileSize: json['fileSize'] as int?,
      businessType: json['businessType'] as String?,
    );
  }
}

/// 文件上传服务
class FileUploadService {
  static final FileUploadService _instance = FileUploadService._internal();
  factory FileUploadService() => _instance;
  FileUploadService._internal();

  final ImagePicker _picker = ImagePicker();
  final Dio _dio = ApiClient.instance.dio;

  /// 从相册选择图片
  Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
  }

  /// 从相机拍照
  Future<XFile?> pickImageFromCamera() async {
    return await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );
  }

  /// 上传文件
  /// [file] 文件
  /// [businessType] 业务类型，如 'post' 表示帖子图片
  Future<UploadFileResult?> uploadFile(XFile file, String businessType) async {
    try {
      final bytes = await file.readAsBytes();
      final fileName = file.name;

      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          bytes,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        '/api/file/upload/$businessType',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        // 后端返回 code=0 表示成功
        if ((data['code'] == 0 || data['code'] == 200) && data['data'] != null) {
          return UploadFileResult.fromJson(data['data'] as Map<String, dynamic>);
        }
      }
      return null;
    } catch (e) {
      print('文件上传失败: $e');
      return null;
    }
  }

  /// 上传图片并返回 Markdown 格式的图片链接
  Future<String?> uploadImageForMarkdown(XFile file, {String businessType = 'post'}) async {
    final result = await uploadFile(file, businessType);
    if (result?.fileUrl != null) {
      return '![${result!.originalName ?? 'image'}](${result.fileUrl})';
    }
    return null;
  }

  /// 从字节数据上传文件
  Future<UploadFileResult?> uploadBytes(
    Uint8List bytes,
    String fileName,
    String businessType,
  ) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          bytes,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        '/api/file/upload/$businessType',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        // 后端返回 code=0 表示成功
        if ((data['code'] == 0 || data['code'] == 200) && data['data'] != null) {
          return UploadFileResult.fromJson(data['data'] as Map<String, dynamic>);
        }
      }
      return null;
    } catch (e) {
      print('文件上传失败: $e');
      return null;
    }
  }
}
