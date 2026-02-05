# CourseResponse

课程信息响应

## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **number** | 课程ID | [optional] [default to undefined]
**title** | **string** | 课程标题 | [optional] [default to undefined]
**subtitle** | **string** | 课程副标题 | [optional] [default to undefined]
**description** | **string** | 课程描述 | [optional] [default to undefined]
**coverImage** | **string** | 封面图片URL | [optional] [default to undefined]
**price** | **number** | 课程价格 | [optional] [default to undefined]
**courseType** | **number** | 课程类型：0-公开课，1-付费课，2-会员课 | [optional] [default to undefined]
**courseTypeDesc** | **string** | 课程类型描述 | [optional] [default to undefined]
**difficulty** | **number** | 难度等级：1-入门，2-初级，3-中级，4-高级，5-专家 | [optional] [default to undefined]
**difficultyDesc** | **string** | 难度等级描述 | [optional] [default to undefined]
**status** | **number** | 状态：0-未发布，1-已发布，2-已下架 | [optional] [default to undefined]
**statusDesc** | **string** | 状态描述 | [optional] [default to undefined]
**teacherId** | **number** | 讲师ID | [optional] [default to undefined]
**totalDuration** | **number** | 总时长(分钟) | [optional] [default to undefined]
**totalChapters** | **number** | 总章节数 | [optional] [default to undefined]
**totalSections** | **number** | 总小节数 | [optional] [default to undefined]
**studentCount** | **number** | 学习人数 | [optional] [default to undefined]
**ratingScore** | **number** | 评分 | [optional] [default to undefined]
**tags** | **Array&lt;string&gt;** | 标签列表 | [optional] [default to undefined]
**createTime** | **string** | 创建时间 | [optional] [default to undefined]
**updateTime** | **string** | 更新时间 | [optional] [default to undefined]

## Example

```typescript
import { CourseResponse } from './api';

const instance: CourseResponse = {
    id,
    title,
    subtitle,
    description,
    coverImage,
    price,
    courseType,
    courseTypeDesc,
    difficulty,
    difficultyDesc,
    status,
    statusDesc,
    teacherId,
    totalDuration,
    totalChapters,
    totalSections,
    studentCount,
    ratingScore,
    tags,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
