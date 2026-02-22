import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for AdminDashboardControllerApi
void main() {
  final instance = NovaApi().getAdminDashboardControllerApi();

  group(AdminDashboardControllerApi, () {
    //Future<BaseResponseDashboardAiSystemResponse> getAiSystem() async
    test('test getAiSystem', () async {
      // TODO
    });

    //Future<BaseResponseDashboardAlertsResponse> getAlerts() async
    test('test getAlerts', () async {
      // TODO
    });

    //Future<BaseResponseDashboardContentResponse> getContent() async
    test('test getContent', () async {
      // TODO
    });

    //Future<BaseResponseDashboardFullResponse> getFull({ Date startDate, Date endDate }) async
    test('test getFull', () async {
      // TODO
    });

    //Future<BaseResponseDashboardLearningResponse> getLearning({ Date startDate, Date endDate }) async
    test('test getLearning', () async {
      // TODO
    });

    //Future<BaseResponseDashboardOverviewResponse> getOverview() async
    test('test getOverview', () async {
      // TODO
    });

    //Future<BaseResponseDashboardTrendsResponse> getTrends({ Date startDate, Date endDate }) async
    test('test getTrends', () async {
      // TODO
    });
  });
}
