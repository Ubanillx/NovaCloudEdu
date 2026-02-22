# nova_api.model.AiGenerateQuestionsRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**subject** | **String** | 学科: MATH/CHINESE/ENGLISH/PHYSICS/CHEMISTRY/BIOLOGY/HISTORY/GEOGRAPHY/POLITICS | 
**type** | **String** | 题型: SINGLE_CHOICE/MULTI_CHOICE/FILL_BLANK/TRUE_FALSE/SHORT_ANSWER/CALCULATION/ESSAY | 
**difficulty** | **int** | 难度: 1-5 | 
**count** | **int** | 生成数量 | 
**grade** | **String** | 年级 | [optional] 
**topic** | **String** | 知识点/主题描述 | [optional] 
**withDiagram** | **bool** | 是否生成几何图形（Typst cetz 渲染） | [optional] 
**withImage** | **bool** | 是否生成配图（文生图） | [optional] 
**enableWebSearch** | **bool** | 是否启用联网搜索热点出题 | [optional] 
**modelId** | **String** | AI 模型ID（可选，如 dashscope/qwen-max） | [optional] 
**userInput** | **String** | 用户自定义补充要求（如出题风格、特殊限制、场景描述等） | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


