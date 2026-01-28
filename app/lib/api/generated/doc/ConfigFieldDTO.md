# nova_api.model.ConfigFieldDTO

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | 字段名 | [optional] 
**label** | **String** | 字段标签 | [optional] 
**fieldType** | **String** | 字段类型 | [optional] 
**required_** | **bool** | 是否必填 | [optional] 
**defaultValue** | [**JsonObject**](.md) | 默认值 | [optional] 
**description** | **String** | 字段描述 | [optional] 
**options** | [**BuiltList&lt;OptionDTO&gt;**](OptionDTO.md) | 选项列表（select类型时使用） | [optional] 
**validation** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) | 验证规则 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


