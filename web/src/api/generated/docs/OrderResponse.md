# OrderResponse

订单信息响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**orderType** | **string** | 订单类型：COURSE-课程订单，MEMBERSHIP-会员订单 | [optional] [default to undefined]
**productName** | **string** | 商品名称（课程名/会员计划名） | [optional] [default to undefined]
**id** | **number** | 订单ID | [optional] [default to undefined]
**userId** | **number** | 用户ID | [optional] [default to undefined]
**courseId** | **number** | 课程ID | [optional] [default to undefined]
**orderNo** | **string** | 订单号 | [optional] [default to undefined]
**price** | **number** | 购买价格 | [optional] [default to undefined]
**paymentMethod** | **number** | 支付方式 | [optional] [default to undefined]
**paymentMethodDesc** | **string** | 支付方式描述 | [optional] [default to undefined]
**paymentTime** | **string** | 支付时间 | [optional] [default to undefined]
**expireTime** | **string** | 过期时间 | [optional] [default to undefined]
**status** | **number** | 订单状态：0-未支付，1-已支付，2-已过期，3-已退款 | [optional] [default to undefined]
**statusDesc** | **string** | 订单状态描述 | [optional] [default to undefined]
**isValid** | **boolean** | 是否有效 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { OrderResponse } from './api';

const instance: OrderResponse = {
    orderType,
    productName,
    id,
    userId,
    courseId,
    orderNo,
    price,
    paymentMethod,
    paymentMethodDesc,
    paymentTime,
    expireTime,
    status,
    statusDesc,
    isValid,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
