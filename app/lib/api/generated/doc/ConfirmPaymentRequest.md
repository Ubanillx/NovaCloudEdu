# nova_api.model.ConfirmPaymentRequest

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**orderNo** | **String** | 订单号 | 
**paymentMethod** | **int** | 支付方式：0-手动确认，1-支付宝，2-微信支付，3-银联支付 | 
**validityDays** | **int** | 有效期（天数），null表示永久有效 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


