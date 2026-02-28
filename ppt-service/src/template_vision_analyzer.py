"""
Vision-based 模板智能分析器 — 借鉴 PPTAgent V1 SlideInducter 设计。

通过渲染模板每页为图片，结合视觉模型 + 结构化解析结果，
为每一页生成丰富的语义描述，包括：
- 版式类型分类（封面/目录/章节/内容/结尾）
- 适合的内容结构（纯文本/图文混排/列表/对比等）
- 视觉特征描述（配色/装饰元素/留白分布）
- 推荐使用场景

相比纯结构解析（template_parser.py），Vision 分析能捕获：
- 背景图片/渐变等视觉元素
- 装饰性形状的语义含义
- 整体视觉风格和氛围
- 版式的空间布局合理性
"""
from __future__ import annotations

import logging
from dataclasses import dataclass, field, asdict

from .schemas import SlideInfo

logger = logging.getLogger(__name__)


@dataclass
class SlideVisionAnalysis:
    """单页模板的视觉分析结果"""
    slide_index: int
    # 版式分类
    layout_category: str = "content"  # cover/toc/section/content/ending
    # 适合的内容类型
    content_types: list[str] = field(
        default_factory=lambda: ["bullets"]
    )
    # 视觉特征
    visual_style: str = ""
    color_scheme: str = ""
    has_background_image: bool = False
    has_decorative_elements: bool = False
    # 空间分布
    text_area_ratio: float = 0.0
    image_area_ratio: float = 0.0
    whitespace_ratio: float = 0.0
    # 推荐场景
    recommended_for: str = ""
    # 原始视觉描述
    vision_description: str = ""

    def to_dict(self) -> dict:
        return asdict(self)


@dataclass
class TemplateVisionProfile:
    """模板整体视觉画像"""
    template_id: str
    overall_style: str = ""
    color_palette: list[str] = field(default_factory=list)
    slide_analyses: list[SlideVisionAnalysis] = field(
        default_factory=list
    )
    # 版式聚类：相似版式归为一组
    layout_clusters: dict[str, list[int]] = field(
        default_factory=dict
    )

    def to_dict(self) -> dict:
        return {
            "template_id": self.template_id,
            "overall_style": self.overall_style,
            "color_palette": self.color_palette,
            "slide_analyses": [
                s.to_dict() for s in self.slide_analyses
            ],
            "layout_clusters": self.layout_clusters,
        }


def analyze_slide_with_structure(
    slide_info: SlideInfo,
    slide_index: int,
    total_slides: int,
    slide_width: int = 12192000,
    slide_height: int = 6858000,
) -> SlideVisionAnalysis:
    """
    基于结构化解析结果进行智能分析（不依赖外部视觉模型）。
    这是 fallback 模式，当视觉模型不可用时使用。

    分析逻辑借鉴 SlideInducter 的 category_split：
    - 首页/末页 → 封面/结尾
    - 少量文本+大文字 → 章节过渡页
    - 多文本槽位 → 内容页
    - 图片槽位 → 图文混排
    """
    analysis = SlideVisionAnalysis(slide_index=slide_index)

    text_slots = slide_info.text_slots or []
    image_slots = slide_info.image_slots or []

    fillable_count = sum(
        1 for s in text_slots if s.is_fillable
    )
    has_images = len(image_slots) > 0
    role = slide_info.role or ""

    # 版式分类
    if role in ("cover", "title"):
        analysis.layout_category = "cover"
    elif role == "ending":
        analysis.layout_category = "ending"
    elif role == "section":
        analysis.layout_category = "section"
    elif role == "toc":
        analysis.layout_category = "toc"
    elif slide_index == 0:
        analysis.layout_category = "cover"
    elif slide_index == total_slides - 1:
        analysis.layout_category = "ending"
    elif fillable_count <= 1:
        analysis.layout_category = "section"
    else:
        analysis.layout_category = "content"

    # 内容类型推断
    content_types = []
    if has_images and fillable_count >= 2:
        content_types.append("image_text")
    if fillable_count >= 3:
        content_types.append("bullets")
    if fillable_count == 2:
        content_types.append("title_paragraph")
    if fillable_count == 1:
        content_types.append("title_only")
    if not content_types:
        content_types.append("title_only")
    analysis.content_types = content_types

    # 空间估算（slide_width/slide_height 来自 TemplateConfig）
    slide_w = slide_width or 12192000
    slide_h = slide_height or 6858000
    total_area = slide_w * slide_h

    text_area = 0
    for slot in text_slots:
        w = slot.width if slot.width else 0
        h = slot.height if slot.height else 0
        text_area += w * h

    img_area = 0
    for slot in image_slots:
        w = slot.width if slot.width else 0
        h = slot.height if slot.height else 0
        img_area += w * h

    if total_area > 0:
        analysis.text_area_ratio = round(
            text_area / total_area, 3
        )
        analysis.image_area_ratio = round(
            img_area / total_area, 3
        )
        analysis.whitespace_ratio = round(
            max(0, 1 - analysis.text_area_ratio
                - analysis.image_area_ratio), 3
        )

    # 推荐场景
    cat = analysis.layout_category
    if cat == "cover":
        analysis.recommended_for = "演示文稿封面、标题页"
    elif cat == "ending":
        analysis.recommended_for = "结尾页、感谢页、联系方式"
    elif cat == "section":
        analysis.recommended_for = "章节过渡、分隔页"
    elif cat == "toc":
        analysis.recommended_for = "目录页、概览"
    elif has_images:
        analysis.recommended_for = "图文混排内容、案例展示"
    elif fillable_count >= 3:
        analysis.recommended_for = "多要点内容、详细说明"
    else:
        analysis.recommended_for = "简洁内容、关键信息"

    return analysis


def build_template_vision_profile(
    template_id: str,
    slides: list[SlideInfo],
    slide_width: int = 12192000,
    slide_height: int = 6858000,
) -> TemplateVisionProfile:
    """
    构建模板的视觉画像（结构分析模式）。
    遍历所有页面进行分析，并聚类相似版式。

    Args:
        template_id: 模板标识
        slides: 模板各页 SlideInfo 列表
        slide_width: 幻灯片宽度(EMU)，来自 TemplateConfig
        slide_height: 幻灯片高度(EMU)，来自 TemplateConfig
    """
    profile = TemplateVisionProfile(template_id=template_id)
    total = len(slides)

    # 逐页分析
    for i, slide_info in enumerate(slides):
        analysis = analyze_slide_with_structure(
            slide_info, i, total,
            slide_width, slide_height,
        )
        profile.slide_analyses.append(analysis)

    # 版式聚类
    clusters: dict[str, list[int]] = {}
    for analysis in profile.slide_analyses:
        cat = analysis.layout_category
        if cat not in clusters:
            clusters[cat] = []
        clusters[cat].append(analysis.slide_index)
    profile.layout_clusters = clusters

    # 整体风格推断
    content_count = len(clusters.get("content", []))
    has_section = "section" in clusters
    profile.overall_style = (
        f"共{total}页模板，"
        f"含{content_count}种内容版式"
        + ("，有章节过渡页" if has_section else "")
    )

    return profile


def format_vision_profile_for_agent(
    profile: TemplateVisionProfile,
) -> str:
    """
    将视觉画像格式化为 Agent 可读的文本描述。
    用于增强 PlannerAgent 和 LayoutSelectorAgent 的模板理解。
    """
    lines = [
        f"## 模板视觉画像 ({profile.template_id})",
        f"整体风格: {profile.overall_style}",
        "",
        "### 版式分类",
    ]

    for cat, indices in profile.layout_clusters.items():
        cat_label = {
            "cover": "封面",
            "toc": "目录",
            "section": "章节过渡",
            "content": "正文内容",
            "ending": "结尾",
        }.get(cat, cat)
        lines.append(
            f"- **{cat_label}**: 第 "
            + ", ".join(str(i) for i in indices) + " 页"
        )

    lines.append("")
    lines.append("### 各页详细分析")

    for a in profile.slide_analyses:
        ct = ", ".join(a.content_types)
        lines.append(
            f"- 第{a.slide_index}页 [{a.layout_category}]: "
            f"适合{ct}, "
            f"文本区={a.text_area_ratio:.0%}, "
            f"图片区={a.image_area_ratio:.0%}, "
            f"推荐: {a.recommended_for}"
        )

    return "\n".join(lines)
