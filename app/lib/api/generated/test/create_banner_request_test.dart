import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for CreateBannerRequest
void main() {
  final instance = CreateBannerRequestBuilder();
  // TODO add properties to the builder and call build()

  group(CreateBannerRequest, () {
    // 标题
    // String title
    test('to test the property `title`', () async {
      // TODO
    });

    // 图片URL
    // String imageUrl
    test('to test the property `imageUrl`', () async {
      // TODO
    });

    // 跳转类型: 0-无跳转, 1-内部路由, 2-外部链接
    // int linkType
    test('to test the property `linkType`', () async {
      // TODO
    });

    // 跳转URL/路由
    // String linkUrl
    test('to test the property `linkUrl`', () async {
      // TODO
    });

    // 排序权重，值越大越靠前
    // int sort
    test('to test the property `sort`', () async {
      // TODO
    });

    // 开始展示时间
    // DateTime startTime
    test('to test the property `startTime`', () async {
      // TODO
    });

    // 结束展示时间
    // DateTime endTime
    test('to test the property `endTime`', () async {
      // TODO
    });
  });
}
