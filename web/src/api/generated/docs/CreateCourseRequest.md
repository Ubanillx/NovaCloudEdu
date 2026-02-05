# CreateCourseRequest

创建课程请求

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **string** | 课程标题 | [default to undefined]
**subtitle** | **string** | 课程副标题 | [optional] [default to undefined]
**description** | **string** | 课程描述 | [optional] [default to undefined]
**coverImage** | **string** | 封面图片URL | [optional] [default to undefined]
**price** | **number** | 课程价格 | [optional] [default to undefined]
**courseType** | **number** | 课程类型：0-公开课，1-付费课，2-会员课 | [default to undefined]
**difficulty** | **number** | 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家 | [default to undefined]
**teacherId** | **number** | 讲师ID | [default to undefined]
**tags** | **Array&lt;string&gt;** | 标签列表 | [optional] [default to undefined]

## Example

```typescript
import { CreateCourseRequest } from './api';

const instance: CreateCourseRequest = {
    title,
    subtitle,
    description,
    coverImage,
    price,
    courseType,
    difficulty,
    teacherId,
    tags,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
