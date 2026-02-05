# CreateScheduleSettingRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**classId** | **number** |  | [default to undefined]
**semester** | **string** |  | [default to undefined]
**startDate** | **string** |  | [default to undefined]
**totalWeeks** | **number** |  | [optional] [default to undefined]
**daysPerWeek** | **number** |  | [optional] [default to undefined]
**sectionsPerDay** | **number** |  | [optional] [default to undefined]
**timeConfig** | [**Array&lt;TimeConfigItem&gt;**](TimeConfigItem.md) |  | [optional] [default to undefined]

## Example

```typescript
import { CreateScheduleSettingRequest } from './api';

const instance: CreateScheduleSettingRequest = {
    classId,
    semester,
    startDate,
    totalWeeks,
    daysPerWeek,
    sectionsPerDay,
    timeConfig,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
