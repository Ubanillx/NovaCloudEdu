import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for SrsCallbackControllerApi
void main() {
  final instance = NovaApi().getSrsCallbackControllerApi();

  group(SrsCallbackControllerApi, () {
    //Future<int> onPlay(SrsCallbackRequest srsCallbackRequest) async
    test('test onPlay', () async {
      // TODO
    });

    //Future<int> onPublish(SrsCallbackRequest srsCallbackRequest) async
    test('test onPublish', () async {
      // TODO
    });

    //Future<int> onStop(SrsCallbackRequest srsCallbackRequest) async
    test('test onStop', () async {
      // TODO
    });

    //Future<int> onUnpublish(SrsCallbackRequest srsCallbackRequest) async
    test('test onUnpublish', () async {
      // TODO
    });
  });
}
