import 'package:test/test.dart';
import 'package:nova_api/nova_api.dart';

/// tests for PPTApi
void main() {
  final instance = NovaApi().getPPTApi();

  group(PPTApi, () {
    // 删除PPT会话
    //
    //Future<BaseResponseVoid> deleteSession(int sessionId) async
    test('test deleteSession', () async {
      // TODO
    });

    // 删除模板
    //
    //Future<BaseResponseVoid> deleteTemplate1(int id) async
    test('test deleteTemplate1', () async {
      // TODO
    });

    // 基于模板生成PPT
    //
    //Future<BaseResponsePptGenerateResponse> generatePpt(GeneratePptRequest generatePptRequest) async
    test('test generatePpt', () async {
      // TODO
    });

    // 获取PPT会话详情
    //
    //Future<BaseResponseMapStringObject> getSessionDetail(int sessionId) async
    test('test getSessionDetail', () async {
      // TODO
    });

    // 查看模板详情
    //
    //Future<BaseResponsePptTemplateDetailResponse> getTemplateDetail(int id) async
    test('test getTemplateDetail', () async {
      // TODO
    });

    // 获取PPT会话列表
    //
    //Future<BaseResponseListMapStringObject> listSessions1() async
    test('test listSessions1', () async {
      // TODO
    });

    // 列出所有可用模板
    //
    //Future<BaseResponseListPptTemplateListResponse> listTemplates() async
    test('test listTemplates', () async {
      // TODO
    });

    // PPT生成助手（SSE流式）
    //
    // 多步骤PPT生成流程，通过 action 字段控制： 0. detect_intent - AI判断用户是否要生成PPT，提取主题 1. generate_outline - 输入主题，AI生成Markdown大纲 2. revise_outline - 不满意可修改大纲 3. confirm_outline - 确认大纲 4. select_template - 选择模板（系统模板ID 或 自定义URL） 5. generate_ppt - AI逐页生成内容并生成最终PPT文件  SSE事件：status / message / intent / outline / template_parsed / slide_progress / result / error / done
    //
    //Future<SseEmitter> stream(PptGenerationRequest pptGenerationRequest) async
    test('test stream', () async {
      // TODO
    });

    // 上传PPT模板
    //
    //Future<BaseResponseLong> uploadTemplate(String name, { String description, UploadTemplateRequest uploadTemplateRequest }) async
    test('test uploadTemplate', () async {
      // TODO
    });
  });
}
