# CourseStructureResponse

课程结构响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**course** | [**CourseResponse**](CourseResponse.md) |  | [optional] [default to undefined]
**chapters** | [**Array&lt;ChapterResponse&gt;**](ChapterResponse.md) | 章节列表（包含小节） | [optional] [default to undefined]
**hasAccess** | **boolean** | 当前用户是否有权访问付费内容 | [optional] [default to undefined]
**purchased** | **boolean** | 当前用户是否已购买此课程（有有效订单） | [optional] [default to undefined]

## Example

```typescript
import { CourseStructureResponse } from './api';

const instance: CourseStructureResponse = {
    course,
    chapters,
    hasAccess,
    purchased,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
