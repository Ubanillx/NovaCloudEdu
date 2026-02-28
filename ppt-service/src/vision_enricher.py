"""
多模态视觉模板分析器 — 通过视觉模型对每页幻灯片截图进行语义分析。

使用 DashScope OpenAI-compatible API 调用 qwen-vl-max 视觉模型，
结合渲染截图 + 结构化解析数据，为每页生成丰富的语义描述：
- 页面用途（purpose）
- 自然语言描述（description）
- 配色方案（color_scheme）
- 版式类型（layout_type）
- 内容容量（content_capacity）
- 视觉风格（visual_style）
- 推荐使用场景（recommended_usage）
- 关键词（keywords）

原始解析数据保存在 data 字段中供后续使用。
"""
from __future__ import annotations

import asyncio
import json
import logging
import os
import httpx

from .schemas import (
    TemplateConfig, SlideInfo,
    ColorScheme, SlideRawData,
    EnrichedSlideInfo, EnrichedTemplateConfig,
)

logger = logging.getLogger(__name__)

# ---- DashScope OpenAI-compatible API 配置 ----

_API_BASE = os.environ.get(
    "DASHSCOPE_API_BASE",
    "https://dashscope.aliyuncs.com/compatible-mode/v1",
)
_API_KEY = os.environ.get("DASHSCOPE_API_KEY", "")
_VISION_MODEL = os.environ.get(
    "ENRICHER_VISION_MODEL", "qwen-vl-max")
_TEXT_MODEL = os.environ.get(
    "ENRICHER_TEXT_MODEL", "qwen-max")
_CONCURRENCY = int(os.environ.get(
    "ENRICHER_CONCURRENCY", "4"))


# ---- Prompt 模板 ----

_SLIDE_ANALYSIS_PROMPT = """\
You are a senior presentation design consultant and visual analysis expert. \
Carefully examine the screenshot of this slide and cross-reference it with \
the structured parsing data below. Produce a precise semantic analysis as JSON.

## Required Fields (13 total)

1. **purpose** (string): Slide purpose. Must be one of: \
cover / table_of_contents / section_divider / content / \
data_chart / comparison / timeline / image_text_mixed / \
closing / credits / team_intro
2. **description** (string): One sentence describing the visual design, \
layout characteristics, and content-carrying capacity. Be specific \
(e.g. "Dark blue gradient background with large left-aligned title \
and right whitespace" instead of "A regular content slide").
3. **color_scheme** (object): Extract exact colors from the screenshot (HEX).
   - primary: Largest non-background color area
   - secondary: Secondary decorative color
   - accent: Highlight or emphasis color
   - background: Main background color
   - text: Primary text color
4. **layout_type** (string): Must be one of: \
title_centered / title_left_content_right / \
title_top_content_bottom / two_column / three_column / \
image_left_text_right / image_right_text_left / \
full_image_overlay / bullets_list / numbered_list / \
comparison_split / timeline_horizontal / \
timeline_vertical / grid_cards / icon_grid / \
quote_centered / blank_with_accent
5. **content_capacity** (string): Describe the specific content \
structure this slide can hold, using "title + N bullet points" \
format (e.g. "heading + subtitle", "title + 4-6 bullet points + \
bottom note").
6. **visual_style** (string): 2-4 visual style keywords, \
comma-separated (e.g. "modern corporate, flat design, gradient").
7. **recommended_usage** (string): One sentence recommending when \
to use this slide in a presentation.
8. **keywords** (array[string]): 3-5 content-type keywords best \
suited for this slide.
9. **text_density** (string): Must be one of: low / medium / high. \
low = title only or minimal text; medium = title + a few points; \
high = multiple paragraphs or dense lists.
10. **design_complexity** (string): Must be one of: \
simple / moderate / complex. \
simple = solid background + text; moderate = decorative shapes \
or gradients; complex = layered overlays or intricate charts.
11. **emphasis_area** (string): Where the visual focal point is \
(e.g. "center of page", "left third", "top banner area").
12. **font_style** (string): Observed font characteristics \
(e.g. "bold sans-serif headings + light body text", \
"large serif title + small monospace labels").
13. **suggested_content_format** (string): Must be one of: \
bullet_points / paragraphs / short_phrases / \
numbers_stats / mixed. \
Indicates the best text format for this slide's layout.

## Structured Data (parsed slot information for this slide)
```json
%s
```

Output a raw JSON object only. Do NOT include ```json markers, \
markdown formatting, or any non-JSON text."""

_TEMPLATE_SUMMARY_PROMPT = """\
Based on the per-slide semantic analysis results below, \
summarize the overall template characteristics.

Per-slide analysis:
%s

Output a raw JSON object with exactly these keys:
{"overall_style": "2-3 keyword overall style description",\
"color_palette": ["#hex1", "#hex2", "#hex3"],\
"template_description": "1-2 sentence template overview \
covering style, color tone, and suitable scenarios",\
"suitable_topics": ["topic1", "topic2", "topic3"],\
"audience_level": "one of: student / professional / \
executive / general",\
"tone": "one of: formal / casual / academic / \
creative / corporate"}
Output raw JSON only. No ```json markers or extra text."""


# ---- API 调用 ----

def _extract_json(text: str) -> str:
    """从可能包含 markdown 代码块的文本中提取 JSON"""
    text = text.strip()
    if text.startswith("```"):
        # 去掉第一行 ```json
        lines = text.split("\n", 1)
        text = lines[1] if len(lines) > 1 else text[3:]
        if text.endswith("```"):
            text = text[:-3]
        text = text.strip()
    start = text.find("{")
    end = text.rfind("}")
    if start >= 0 and end > start:
        return text[start:end + 1]
    return text


async def _call_vision_api(
    image_url: str,
    raw_json: str,
    semaphore: asyncio.Semaphore,
) -> dict:
    """调用视觉模型分析单页幻灯片"""
    async with semaphore:
        prompt = _SLIDE_ANALYSIS_PROMPT % raw_json
        payload = {
            "model": _VISION_MODEL,
            "messages": [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "image_url",
                            "image_url": {"url": image_url},
                        },
                        {"type": "text", "text": prompt},
                    ],
                },
            ],
            "max_tokens": 2000,
            "temperature": 0.2,
        }

        async with httpx.AsyncClient(
            timeout=60.0
        ) as client:
            resp = await client.post(
                f"{_API_BASE}/chat/completions",
                json=payload,
                headers={
                    "Authorization": f"Bearer {_API_KEY}",
                    "Content-Type": "application/json",
                },
            )
            resp.raise_for_status()
            data = resp.json()

        text = data["choices"][0]["message"]["content"]
        return json.loads(_extract_json(text))


async def _call_text_api(prompt: str) -> dict:
    """调用文本模型进行模板整体总结"""
    payload = {
        "model": _TEXT_MODEL,
        "messages": [
            {"role": "user", "content": prompt},
        ],
        "max_tokens": 1000,
        "temperature": 0.3,
    }

    async with httpx.AsyncClient(
        timeout=30.0
    ) as client:
        resp = await client.post(
            f"{_API_BASE}/chat/completions",
            json=payload,
            headers={
                "Authorization": f"Bearer {_API_KEY}",
                "Content-Type": "application/json",
            },
        )
        resp.raise_for_status()
        data = resp.json()

    text = data["choices"][0]["message"]["content"]
    return json.loads(_extract_json(text))


# ---- 数据转换 ----

def _build_raw_data(slide_info: SlideInfo) -> SlideRawData:
    """将 SlideInfo 转为 SlideRawData"""
    return SlideRawData(
        role=slide_info.role,
        layout_name=slide_info.layout_name,
        text_slots=slide_info.text_slots,
        image_slots=slide_info.image_slots,
        fillable_count=slide_info.fillable_count,
    )


def _parse_color_scheme(cs_dict: dict) -> ColorScheme:
    """安全解析配色方案"""
    if not isinstance(cs_dict, dict):
        return ColorScheme()
    return ColorScheme(
        primary=cs_dict.get("primary", ""),
        secondary=cs_dict.get("secondary", ""),
        accent=cs_dict.get("accent", ""),
        background=cs_dict.get("background", ""),
        text=cs_dict.get("text", ""),
    )


# ---- 结构化分析兜底（无视觉模型时使用）----

def _fallback_enrichment(
    slide_info: SlideInfo,
    slide_index: int,
    total_slides: int,
) -> dict:
    """视觉模型不可用时的结构化分析兜底"""
    role = slide_info.role or "content"
    fillable = slide_info.fillable_count
    has_images = len(slide_info.image_slots) > 0

    purpose_map = {
        "cover": "封面展示",
        "toc": "目录导航",
        "section": "章节过渡",
        "ending": "总结致谢",
        "credits": "版权声明",
    }
    purpose = purpose_map.get(role, "内容讲解")

    layout_map = {
        "cover": "title_centered",
        "toc": "bullets_list",
        "section": "title_centered",
        "ending": "title_centered",
    }
    layout = layout_map.get(role, "top_title_bottom_content")
    if has_images and role == "content":
        layout = "image_left_text_right"

    capacity = "标题"
    if fillable >= 3:
        capacity = "标题+3-5个要点列表"
    elif fillable == 2:
        capacity = "标题+段落文本"
    elif fillable == 1:
        capacity = "大标题"
    if has_images:
        capacity += "+配图"

    desc_parts = [purpose, "页"]
    if fillable > 0:
        desc_parts.append(
            f"，包含{fillable}个可填充文本区域")
    if has_images:
        desc_parts.append(
            f"，{len(slide_info.image_slots)}个图片区域")

    # 文本密度推断
    if fillable >= 3:
        text_density = "high"
    elif fillable >= 1:
        text_density = "medium"
    else:
        text_density = "low"

    # 设计复杂度推断
    complexity = "simple"
    if has_images and fillable >= 2:
        complexity = "moderate"
    elif has_images or fillable >= 4:
        complexity = "moderate"

    # 内容格式推断
    if role in ("cover", "section", "ending"):
        content_fmt = "short_phrases"
    elif fillable >= 3:
        content_fmt = "bullet_points"
    else:
        content_fmt = "paragraphs"

    return {
        "purpose": purpose,
        "description": "".join(desc_parts),
        "color_scheme": {
            "primary": "", "secondary": "",
            "accent": "", "background": "", "text": "",
        },
        "layout_type": layout,
        "content_capacity": capacity,
        "visual_style": "",
        "recommended_usage": purpose,
        "keywords": [],
        "text_density": text_density,
        "design_complexity": complexity,
        "emphasis_area": "页面中央",
        "font_style": "",
        "suggested_content_format": content_fmt,
    }


# ---- 核心入口 ----

async def enrich_template(
    config: TemplateConfig,
    slide_image_urls: list[str],
) -> EnrichedTemplateConfig:
    """
    对模板进行语义增强分析。

    流程：
    1. 对每页幻灯片截图 + 结构化 JSON 调用视觉模型
    2. 提取语义字段（purpose/description/配色等）
    3. 调用文本模型总结模板整体特征
    4. 返回 EnrichedTemplateConfig

    Args:
        config: 原始模板解析结果 (TemplateConfig)
        slide_image_urls: 各页渲染后的 PNG 图片 URL
            （索引与 config.slides 对应）

    Returns:
        EnrichedTemplateConfig 语义增强后的模板配置
    """
    if not _API_KEY:
        logger.warning(
            "DASHSCOPE_API_KEY 未配置，使用结构化分析兜底")
        return _fallback_enrich(config, slide_image_urls)

    total = len(config.slides)
    semaphore = asyncio.Semaphore(_CONCURRENCY)

    # 并发分析每页
    async def analyze_slide(
        idx: int,
    ) -> EnrichedSlideInfo:
        slide_info = config.slides[idx]
        raw_data = _build_raw_data(slide_info)
        image_url = (
            slide_image_urls[idx]
            if idx < len(slide_image_urls) else ""
        )

        semantic: dict = {}
        if image_url:
            try:
                raw_json = raw_data.model_dump_json(
                    indent=2)
                semantic = await _call_vision_api(
                    image_url, raw_json, semaphore)
                logger.info("第%d页视觉分析完成", idx)
            except Exception as e:
                logger.warning(
                    "第%d页视觉分析失败，使用兜底: %s",
                    idx, e)

        if not semantic:
            semantic = _fallback_enrichment(
                slide_info, idx, total)

        cs = semantic.get("color_scheme", {})
        return EnrichedSlideInfo(
            index=idx,
            purpose=semantic.get("purpose", ""),
            description=semantic.get("description", ""),
            color_scheme=_parse_color_scheme(cs),
            layout_type=semantic.get("layout_type", ""),
            content_capacity=semantic.get(
                "content_capacity", ""),
            visual_style=semantic.get("visual_style", ""),
            recommended_usage=semantic.get(
                "recommended_usage", ""),
            keywords=semantic.get("keywords", []),
            text_density=semantic.get(
                "text_density", ""),
            design_complexity=semantic.get(
                "design_complexity", ""),
            emphasis_area=semantic.get(
                "emphasis_area", ""),
            font_style=semantic.get(
                "font_style", ""),
            suggested_content_format=semantic.get(
                "suggested_content_format", ""),
            preview_image_url=image_url,
            data=raw_data,
        )

    tasks = [analyze_slide(i) for i in range(total)]
    enriched_slides: list[EnrichedSlideInfo] = list(
        await asyncio.gather(*tasks))

    # 模板整体总结
    overall: dict = {}
    try:
        slides_summary = "\n".join(
            f"第{s.index}页: purpose={s.purpose}, "
            f"style={s.visual_style}, "
            f"colors={s.color_scheme.primary}/"
            f"{s.color_scheme.secondary}, "
            f"layout={s.layout_type}"
            for s in enriched_slides
        )
        overall = await _call_text_api(
            _TEMPLATE_SUMMARY_PROMPT % slides_summary)
        logger.info("模板整体总结完成")
    except Exception as e:
        logger.warning("模板整体总结失败: %s", e)

    return EnrichedTemplateConfig(
        template_id=config.template_id,
        name=config.name,
        slide_width=config.slide_width,
        slide_height=config.slide_height,
        slide_count=config.slide_count,
        overall_style=overall.get("overall_style", ""),
        color_palette=overall.get("color_palette", []),
        template_description=overall.get(
            "template_description", ""),
        suitable_topics=overall.get(
            "suitable_topics", []),
        audience_level=overall.get(
            "audience_level", ""),
        tone=overall.get("tone", ""),
        slides=enriched_slides,
    )


def _fallback_enrich(
    config: TemplateConfig,
    slide_image_urls: list[str],
) -> EnrichedTemplateConfig:
    """无视觉模型时的纯结构化兜底"""
    total = len(config.slides)
    enriched_slides = []

    for idx, slide_info in enumerate(config.slides):
        raw_data = _build_raw_data(slide_info)
        semantic = _fallback_enrichment(
            slide_info, idx, total)
        cs = semantic.get("color_scheme", {})
        image_url = (
            slide_image_urls[idx]
            if idx < len(slide_image_urls) else ""
        )

        enriched_slides.append(EnrichedSlideInfo(
            index=idx,
            purpose=semantic.get("purpose", ""),
            description=semantic.get("description", ""),
            color_scheme=_parse_color_scheme(cs),
            layout_type=semantic.get("layout_type", ""),
            content_capacity=semantic.get(
                "content_capacity", ""),
            visual_style=semantic.get("visual_style", ""),
            recommended_usage=semantic.get(
                "recommended_usage", ""),
            keywords=semantic.get("keywords", []),
            text_density=semantic.get(
                "text_density", ""),
            design_complexity=semantic.get(
                "design_complexity", ""),
            emphasis_area=semantic.get(
                "emphasis_area", ""),
            font_style=semantic.get(
                "font_style", ""),
            suggested_content_format=semantic.get(
                "suggested_content_format", ""),
            preview_image_url=image_url,
            data=raw_data,
        ))

    return EnrichedTemplateConfig(
        template_id=config.template_id,
        name=config.name,
        slide_width=config.slide_width,
        slide_height=config.slide_height,
        slide_count=config.slide_count,
        slides=enriched_slides,
    )
