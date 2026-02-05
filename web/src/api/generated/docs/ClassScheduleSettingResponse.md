# ClassScheduleSettingResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **string** |  | [optional] [default to undefined]
**classId** | **string** |  | [optional] [default to undefined]
**semester** | **string** |  | [optional] [default to undefined]
**startDate** | **string** |  | [optional] [default to undefined]
**totalWeeks** | **number** |  | [optional] [default to undefined]
**daysPerWeek** | **number** |  | [optional] [default to undefined]
**sectionsPerDay** | **number** |  | [optional] [default to undefined]
**timeConfig** | [**Array&lt;TimeConfigItem&gt;**](TimeConfigItem.md) |  | [optional] [default to undefined]
**isActive** | **boolean** |  | [optional] [default to undefined]
**createTime** | **string** |  | [optional] [default to undefined]
**updateTime** | **string** |  | [optional] [default to undefined]

## Example

```typescript
import { ClassScheduleSettingResponse } from './api';

const instance: ClassScheduleSettingResponse = {
    id,
    classId,
    semester,
    startDate,
    totalWeeks,
    daysPerWeek,
    sectionsPerDay,
    timeConfig,
    isActive,
    createTime,
    updateTime,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
