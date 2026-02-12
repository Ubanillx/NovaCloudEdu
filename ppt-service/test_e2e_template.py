"""
端到端测试 v2：Markdown 大纲 → 解析模板 → 映射 → 克隆 → 生成 PPTX
验证生成的 PPTX 保留模板完整视觉设计。
"""
import json
import sys
import os

sys.path.insert(0, os.path.dirname(__file__))

from src.template_parser import parse_template
from src.template_registry import registry
from src.template_renderer import TemplateRenderer
from src.schemas import TemplateGenerationSpec

# ==================== Step 1: 解析模板 ====================

print("=" * 60)
print("Step 1: 解析模板幻灯片结构")
print("=" * 60)

registry.scan_presets()
cfg = registry.get_config("测试模板1")
if not cfg:
    print("❌ 模板未找到")
    sys.exit(1)

print(f"模板: {cfg.name} | 共 {cfg.slide_count} 页")
for si in cfg.slides:
    if si.fillable_count > 0 or si.role in (
        'cover', 'section', 'ending'
    ):
        slots_desc = ', '.join(
            f'id={s.shape_id}({s.role})'
            for s in si.text_slots
            if s.is_fillable or s.role == 'label'
        )
        print(f"  [{si.index:2d}] {si.role:8s} "
              f"fillable={si.fillable_count} "
              f"| {slots_desc}")

# ==================== Step 2: 映射大纲到模板页 ====================
# 模板页结构（从分析得出）：
#   0  = 封面
#   1  = 目录（4个章节标签 id=15,23,29,35）
#   2  = 章节头 PART01（id=9 章节标题标签）
#   3  = 3卡片内容（label id=9,22,29 + fill id=10,23,30）
#   5  = 2项内容（label id=9,15 + fill id=10,16）
#   6  = 3项内容（label id=11,14,17 + fill id=12,15,18）
#   7  = 章节头 PART02
#   8  = 标题+3段（id=11标题 + fill id=12,13,14）
#  10  = 壹贰叁3编号项（fill id=10,18,26）
#  11  = 章节头 PART03
#  12  = 3卡片（label id=9,13,17 + fill id=10,14,18）
#  14  = 2列（fill id=13,14）
#  15  = 章节头 PART04
#  19  = 结尾

print("\n" + "=" * 60)
print("Step 2: 构建填充配置")
print("=" * 60)

filled_slides = [
    # ---- 封面 ----
    {
        "template_slide_index": 0,
        "fills": [
            {"shape_id": 15, "text": "AI 助力教育发展"},
        ],
    },
    # ---- 目录 ----
    {
        "template_slide_index": 1,
        "fills": [
            {"shape_id": 15, "text": "核心应用场景"},
            {"shape_id": 23, "text": "个性化学习"},
            {"shape_id": 29, "text": "智能评估与教师赋能"},
            {"shape_id": 35, "text": "挑战与展望"},
        ],
    },
    # ---- PART01 章节头 ----
    {
        "template_slide_index": 2,
        "fills": [
            {"shape_id": 9, "text": "核心应用场景"},
        ],
    },
    # ---- 核心应用场景（3卡片）----
    {
        "template_slide_index": 3,
        "fills": [
            {"shape_id": 9, "text": "个性化学习"},
            {"shape_id": 10, "text": (
                "AI 通过知识图谱驱动学习路径推荐，"
                "为每位学生量身定制学习计划。"
            )},
            {"shape_id": 22, "text": "智能批改"},
            {"shape_id": 23, "text": (
                "自然语言处理自动批改作文，"
                "编程题智能评测与反馈。"
            )},
            {"shape_id": 29, "text": "自适应测试"},
            {"shape_id": 30, "text": (
                "根据学生知识水平动态调整试题难度，"
                "实现精准评估。"
            )},
        ],
    },
    # ---- PART02 章节头 ----
    {
        "template_slide_index": 7,
        "fills": [
            {"shape_id": 9, "text": "深入分析"},
        ],
    },
    # ---- 个性化学习（2项）----
    {
        "template_slide_index": 5,
        "fills": [
            {"shape_id": 9, "text": "知识图谱"},
            {"shape_id": 10, "text": (
                "基于知识图谱构建个性化学习路径，"
                "实时分析学情数据，"
                "精准推送差异化教学内容。"
            )},
            {"shape_id": 15, "text": "学情分析"},
            {"shape_id": 16, "text": (
                "通过大数据分析学生学习行为，"
                "及时发现薄弱环节并进行干预，"
                "让每个学生都能获得适合的学习支持。"
            )},
        ],
    },
    # ---- 智能评估（3项）----
    {
        "template_slide_index": 6,
        "fills": [
            {"shape_id": 11, "text": "NLP 批改"},
            {"shape_id": 12, "text": (
                "利用自然语言处理技术自动批改作文，"
                "提供详细的修改建议和评分。"
            )},
            {"shape_id": 14, "text": "自动评测"},
            {"shape_id": 15, "text": (
                "编程题、数学题等客观题目自动评分，"
                "过程性评价替代单一终结性考试。"
            )},
            {"shape_id": 17, "text": "成长档案"},
            {"shape_id": 18, "text": (
                "构建学生学习画像与成长档案，"
                "多维度记录学习轨迹和能力发展。"
            )},
        ],
    },
    # ---- PART03 章节头 ----
    {
        "template_slide_index": 11,
        "fills": [
            {"shape_id": 9, "text": "赋能与展望"},
        ],
    },
    # ---- 教师赋能（3卡片）----
    {
        "template_slide_index": 12,
        "fills": [
            {"shape_id": 9, "text": "自动教案"},
            {"shape_id": 10, "text": (
                "AI 自动生成教案与课件，"
                "帮助教师快速准备高质量教学材料。"
            )},
            {"shape_id": 13, "text": "课堂分析"},
            {"shape_id": 14, "text": (
                "AI 分析课堂互动行为，"
                "为教师提供个性化教学建议。"
            )},
            {"shape_id": 17, "text": "减负增效"},
            {"shape_id": 18, "text": (
                "将教师从重复批改中解放出来，"
                "让教师专注于创造性教学工作。"
            )},
        ],
    },
    # ---- 挑战与展望（2列）----
    {
        "template_slide_index": 14,
        "fills": [
            {"shape_id": 15, "text": "挑战"},
            {"shape_id": 13, "text": (
                "数据隐私与伦理问题亟需解决，"
                "教育公平性需要技术保障，"
                "避免算法偏见加剧教育不平等。"
            )},
            {"shape_id": 14, "text": (
                "技术与教学需要深度融合，"
                "培养 AI 时代的核心素养，"
                "让技术真正服务于育人目标。"
            )},
        ],
    },
    # ---- 结尾 ----
    {
        "template_slide_index": 19,
        "fills": [
            {"shape_id": 2, "text": "感谢观看"},
        ],
    },
]

spec_data = {
    "template_id": cfg.template_id,
    "title": "AI助力教育发展",
    "slides": filled_slides,
    "author": "NovaCloudEdu",
}

print(f"共 {len(filled_slides)} 页输出")
print(json.dumps(spec_data, ensure_ascii=False, indent=2))

# ==================== Step 3: 生成 PPTX ====================

print("\n" + "=" * 60)
print("Step 3: 克隆模板页 → 填充文本 → 生成 PPTX")
print("=" * 60)

spec = TemplateGenerationSpec(**spec_data)
tpath = registry.get_path(cfg.template_id)
renderer = TemplateRenderer(tpath, spec, cfg)
pptx_bytes, preview = renderer.render()

out_path = "AI助力教育发展.pptx"
with open(out_path, "wb") as f:
    f.write(pptx_bytes)

print(f"✅ PPTX 已生成: {out_path}")
print(f"   文件大小: {len(pptx_bytes):,} bytes")
print(f"   幻灯片数: {len(preview)}")

print("\n=== Preview JSON ===")
preview_data = [pv.model_dump() for pv in preview]
print(json.dumps(preview_data, ensure_ascii=False, indent=2))

print(f"\n✅ 请打开 {out_path} 验证模板样式是否保留！")
