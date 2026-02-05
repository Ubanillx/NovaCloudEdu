// Openapi Generator last run: : 2026-02-05T17:14:57.845114
/// OpenAPI Generator 配置
///
/// 此文件仅用于开发时生成 API 客户端代码。
/// 运行命令: flutter pub run build_runner build --delete-conflicting-outputs
///
/// 注意: 生成代码时需要后端服务在 localhost:8080 运行
library;


import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: AdditionalProperties(
    pubName: 'nova_api',
    pubAuthor: 'NovaCloudEdu',
  ),
  inputSpec: InputSpec(path: './openapi.json'),
  generatorName: Generator.dio,
  outputDirectory: './lib/api/generated',
  runSourceGenOnOutput: true,
  skipSpecValidation: true,
  forceAlwaysRun: true,
)
class OpenapiConfig {}