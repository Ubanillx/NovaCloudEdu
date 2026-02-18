# DashboardOverviewResponse


## Properties

Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**totalUsers** | **number** |  | [optional] [default to undefined]
**usersByRole** | **{ [key: string]: number; }** |  | [optional] [default to undefined]
**todayNewUsers** | **number** |  | [optional] [default to undefined]
**yesterdayNewUsers** | **number** |  | [optional] [default to undefined]
**totalCourses** | **number** |  | [optional] [default to undefined]
**coursesByStatus** | **{ [key: string]: number; }** |  | [optional] [default to undefined]
**activeMembers** | **number** |  | [optional] [default to undefined]
**membersByPlan** | **{ [key: string]: number; }** |  | [optional] [default to undefined]
**todayOrders** | **number** |  | [optional] [default to undefined]
**yesterdayOrders** | **number** |  | [optional] [default to undefined]
**todayRevenue** | **number** |  | [optional] [default to undefined]
**yesterdayRevenue** | **number** |  | [optional] [default to undefined]
**todayDau** | **number** |  | [optional] [default to undefined]
**yesterdayDau** | **number** |  | [optional] [default to undefined]
**pendingFeedbacks** | **number** |  | [optional] [default to undefined]
**myClassCount** | **number** |  | [optional] [default to undefined]
**myStudentCount** | **number** |  | [optional] [default to undefined]

## Example

```typescript
import { DashboardOverviewResponse } from './api';

const instance: DashboardOverviewResponse = {
    totalUsers,
    usersByRole,
    todayNewUsers,
    yesterdayNewUsers,
    totalCourses,
    coursesByStatus,
    activeMembers,
    membersByPlan,
    todayOrders,
    yesterdayOrders,
    todayRevenue,
    yesterdayRevenue,
    todayDau,
    yesterdayDau,
    pendingFeedbacks,
    myClassCount,
    myStudentCount,
};
```

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)
