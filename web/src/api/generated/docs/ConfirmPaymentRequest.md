# ConfirmPaymentRequest

确认支付请求（管理员）

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**orderNo** | **string** | 订单号 | [default to undefined]
**paymentMethod** | **number** | 支付方式：0-手动确认，1-支付宝，2-微信支付，3-银联支付 | [default to undefined]
**validityDays** | **number** | 有效期（天数），null表示永久有效 | [optional] [default to undefined]

## Example

```typescript
import { ConfirmPaymentRequest } from './api';

const instance: ConfirmPaymentRequest = {
    orderNo,
    paymentMethod,
    validityDays,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
