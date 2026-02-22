# nova_api.model.OrderResponse

## Load the model package
```dart
import 'package:nova_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**orderType** | **String** | 订单类型：COURSE-课程订单，MEMBERSHIP-会员订单 | [optional] 
**productName** | **String** | 商品名称（课程名/会员计划名） | [optional] 
**id** | **int** | 订单ID | [optional] 
**userId** | **int** | 用户ID | [optional] 
**courseId** | **int** | 课程ID | [optional] 
**orderNo** | **String** | 订单号 | [optional] 
**price** | **num** | 购买价格 | [optional] 
**paymentMethod** | **int** | 支付方式 | [optional] 
**paymentMethodDesc** | **String** | 支付方式描述 | [optional] 
**paymentTime** | [**DateTime**](DateTime.md) | 支付时间 | [optional] 
**expireTime** | [**DateTime**](DateTime.md) | 过期时间 | [optional] 
**status** | **int** | 订单状态：0-未支付，1-已支付，2-已过期，3-已退款 | [optional] 
**statusDesc** | **String** | 订单状态描述 | [optional] 
**isValid** | **bool** | 是否有效 | [optional] 
**createTime** | [**DateTime**](DateTime.md) | 创建时间 | [optional] 
**updateTime** | [**DateTime**](DateTime.md) | 更新时间 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


