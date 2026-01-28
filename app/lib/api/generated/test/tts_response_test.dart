import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for TtsResponse
void main() {
  final instance = TtsResponseBuilder();
  // TODO add properties to the builder and call build()

  group(TtsResponse, () {
    // Base64 编码的音频数据
    // String audioBase64
    test('to test the property `audioBase64`', () async {
      // TODO
    });

    // 音频格式
    // String format
    test('to test the property `format`', () async {
      // TODO
    });

    // 音频数据大小（字节）
    // int size
    test('to test the property `size`', () async {
      // TODO
    });

    // 音频时长（毫秒），如果可用
    // int durationMs
    test('to test the property `durationMs`', () async {
      // TODO
    });
  });
}
