# UpdateScheduleSettingRequest


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**semester** | **string** |  | [default to undefined]
**startDate** | **string** |  | [default to undefined]
**totalWeeks** | **number** |  | [optional] [default to undefined]
**daysPerWeek** | **number** |  | [optional] [default to undefined]
**sectionsPerDay** | **number** |  | [optional] [default to undefined]
**timeConfig** | [**Array&lt;TimeConfigItem&gt;**](TimeConfigItem.md) |  | [optional] [default to undefined]

## Example

```typescript
import { UpdateScheduleSettingRequest } from './api';

const instance: UpdateScheduleSettingRequest = {
    semester,
    startDate,
    totalWeeks,
    daysPerWeek,
    sectionsPerDay,
    timeConfig,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
