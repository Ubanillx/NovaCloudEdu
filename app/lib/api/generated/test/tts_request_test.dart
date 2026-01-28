import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

// tests for TtsRequest
void main() {
  final instance = TtsRequestBuilder();
  // TODO add properties to the builder and call build()

  group(TtsRequest, () {
    // 要合成的文本
    // String text
    test('to test the property `text`', () async {
      // TODO
    });

    // 发音人，可选值: xiaoyun, xiaogang, ruoxi 等
    // String voice
    test('to test the property `voice`', () async {
      // TODO
    });

    // 音量 (0-100)
    // int volume
    test('to test the property `volume`', () async {
      // TODO
    });

    // 语速 (-500 到 500)
    // int speechRate
    test('to test the property `speechRate`', () async {
      // TODO
    });

    // 语调 (-500 到 500)
    // int pitchRate
    test('to test the property `pitchRate`', () async {
      // TODO
    });

    // 音频格式: pcm, wav, mp3
    // String format (default value: 'mp3')
    test('to test the property `format`', () async {
      // TODO
    });
  });
}
