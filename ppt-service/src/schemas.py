"""
PPT 模板系统数据模型定义。
基于「克隆模板幻灯片 → 按 shape_id 填充文本/图片」的架构。
"""
from __future__ import annotations

from typing import Optional

from pydantic import BaseModel, Field


# ==================== 模板解析模型 ====================

class TextSlot(BaseModel):
    """模板幻灯片中的一个可编辑文本区域"""
    shape_id: int = Field(description="形状 ID")
    name: str = Field(default="", description="形状名称")
    sample_text: str = Field(
        default="", description="原始示例文本")
    is_fillable: bool = Field(
        default=False,
        description="是否为可填充区域")
    role: str = Field(
        default="body",
        description="角色: title/subtitle/body/label")
    left: int = Field(description="左边距(EMU)")
    top: int = Field(description="上边距(EMU)")
    width: int = Field(description="宽度(EMU)")
    height: int = Field(description="高度(EMU)")


class ImageSlot(BaseModel):
    """模板幻灯片中的一个图片区域"""
    shape_id: int = Field(description="形状 ID")
    name: str = Field(default="", description="形状名称")
    desc: str = Field(
        default="",
        description="图片描述/alt text")
    left: int = Field(description="左边距(EMU)")
    top: int = Field(description="上边距(EMU)")
    width: int = Field(description="宽度(EMU)")
    height: int = Field(description="高度(EMU)")


class SlideInfo(BaseModel):
    """模板中单个幻灯片的描述"""
    index: int = Field(description="在模板中的索引")
    role: str = Field(
        default="content",
        description="页面角色: cover/toc/section/"
                    "content/ending/credits")
    layout_name: str = Field(default="")
    text_slots: list[TextSlot] = Field(
        default_factory=list,
        description="该页包含的文本槽位")
    image_slots: list[ImageSlot] = Field(
        default_factory=list,
        description="该页包含的图片区域")
    fillable_count: int = Field(
        default=0,
        description="可填充文本区域数量")


class TemplateConfig(BaseModel):
    """模板解析后的完整配置"""
    template_id: str = Field(
        description="模板唯一标识")
    name: str = Field(description="模板显示名称")
    slide_width: int = Field(
        description="幻灯片宽度(EMU)")
    slide_height: int = Field(
        description="幻灯片高度(EMU)")
    slide_count: int = Field(
        default=0, description="模板总页数")
    slides: list[SlideInfo] = Field(
        default_factory=list,
        description="各幻灯片的描述")


class SlotFill(BaseModel):
    """AI 为一个槽位生成的填充内容（文本或图片）"""
    shape_id: int = Field(
        description="目标形状 ID")
    text: Optional[str] = Field(
        default=None, description="文本内容")
    items: Optional[list[str]] = Field(
        default=None,
        description="列表项（bullet 类型）")
    image_url: Optional[str] = Field(
        default=None,
        description="图片 URL（用于替换图片形状）")


class FilledSlide(BaseModel):
    """AI 为一页幻灯片匹配的模板页和填充"""
    template_slide_index: int = Field(
        description="要克隆的模板幻灯片索引")
    fills: list[SlotFill] = Field(
        default_factory=list,
        description="各文本槽位的填充内容")
    notes: Optional[str] = Field(
        default=None, description="演讲者备注")


class TemplateGenerationSpec(BaseModel):
    """基于模板的 PPT 生成规格"""
    template_url: str = Field(
        description="模板 PPTX 文件 URL")
    title: str = Field(description="PPT 标题")
    slides: list[FilledSlide] = Field(
        description="每页幻灯片的克隆来源和填充内容")
    author: Optional[str] = Field(
        default=None, description="作者")


class PreviewElement(BaseModel):
    """前端预览用的元素描述"""
    role: str = Field(description="角色")
    text: Optional[str] = Field(default=None)
    items: Optional[list[str]] = Field(default=None)
    left_pct: float = Field(
        description="左边距百分比")
    top_pct: float = Field(
        description="上边距百分比")
    width_pct: float = Field(
        description="宽度百分比")
    height_pct: float = Field(
        description="高度百分比")


class PreviewSlide(BaseModel):
    """前端预览用的单页描述"""
    slide_index: int
    template_slide_index: int = Field(default=-1)
    elements: list[PreviewElement] = Field(
        default_factory=list)
