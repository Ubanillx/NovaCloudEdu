"""
内容长度验证器：校验 AI 填充内容是否匹配模板 shape 尺寸。

借鉴 PPTAgent V1 的 _validate_content() 设计思路：
- 根据 shape 的物理尺寸估算最大可容纳字符数
- 检测溢出（文字过多）和空洞（文字过少）
- 返回具体的问题描述，供 AI Agent 修正
"""
from __future__ import annotations

import logging

from pydantic import BaseModel, Field

from .schemas import SlotFill, SlideInfo, TextSlot

logger = logging.getLogger(__name__)

# EMU 常量
EMU_PER_CM = 360000
EMU_PER_PT = 12700

# 默认字体参数（用于估算）
DEFAULT_FONT_SIZE_PT = 14
DEFAULT_LINE_HEIGHT_FACTOR = 1.5
DEFAULT_CHAR_WIDTH_FACTOR = 0.6  # 中文字符宽度约等于字号 × 0.6


class ValidationIssue(BaseModel):
    """单个槽位的校验问题"""
    shape_id: int
    issue_type: str = Field(description="overflow | too_short | missing")
    severity: str = Field(description="error | warning")
    actual_chars: int = 0
    max_chars: int = 0
    message: str = ""


class ValidationResult(BaseModel):
    """整页的校验结果"""
    slide_index: int
    is_valid: bool = True
    issues: list[ValidationIssue] = Field(default_factory=list)
    suggestions: list[str] = Field(default_factory=list)


def estimate_max_chars(
    width_emu: int,
    height_emu: int,
    font_size_pt: float = DEFAULT_FONT_SIZE_PT,
    is_bullet: bool = False,
) -> int:
    """根据 shape 物理尺寸和字号估算最大可容纳字符数。

    算法：
    1. 将 EMU 转换为 pt
    2. 按字号估算单行可容纳字符数
    3. 按行高估算可容纳行数
    4. chars_per_line × lines = max_chars
    """
    width_pt = width_emu / EMU_PER_PT
    height_pt = height_emu / EMU_PER_PT

    # 减去内边距（约 10% 左右）
    usable_width = width_pt * 0.85
    usable_height = height_pt * 0.85

    # 单行可容纳字符数（中文字符约 font_size * 0.6 宽）
    char_width = font_size_pt * DEFAULT_CHAR_WIDTH_FACTOR
    chars_per_line = max(1, int(usable_width / char_width))

    # 可容纳行数
    line_height = font_size_pt * DEFAULT_LINE_HEIGHT_FACTOR
    max_lines = max(1, int(usable_height / line_height))

    # bullet 列表每行独占一行
    if is_bullet:
        return max_lines * chars_per_line

    return chars_per_line * max_lines


def estimate_font_size_for_role(role: str, height_emu: int) -> float:
    """根据角色和区域高度估算字号。"""
    height_cm = height_emu / EMU_PER_CM

    if role == "title":
        return max(24, min(36, height_cm * 8))
    elif role == "subtitle":
        return max(16, min(24, height_cm * 6))
    elif role == "label":
        return max(10, min(14, height_cm * 5))
    else:  # body
        if height_cm < 3:
            return 12
        elif height_cm < 8:
            return 14
        else:
            return 16


def count_fill_chars(fill: SlotFill) -> int:
    """统计一个 fill 的实际字符数。"""
    total = 0
    if fill.text:
        total += len(fill.text)
    if fill.items:
        total += sum(len(item) for item in fill.items)
    return total


def validate_slide_fills(
    fills: list[SlotFill],
    slide_info: SlideInfo,
    slide_index: int = 0,
) -> ValidationResult:
    """校验一页幻灯片的填充内容是否匹配模板 shape 尺寸。

    Args:
        fills: AI 生成的填充内容列表
        slide_info: 模板页的结构信息（含 text_slots）
        slide_index: 幻灯片索引（用于报告）

    Returns:
        ValidationResult 包含校验结果和修改建议
    """
    result = ValidationResult(slide_index=slide_index)

    # 构建 shape_id → slot 映射
    slot_map: dict[int, TextSlot] = {
        ts.shape_id: ts for ts in slide_info.text_slots
    }

    # 构建 shape_id → fill 映射
    fill_map: dict[int, SlotFill] = {
        f.shape_id: f for f in fills
    }

    # 1. 检查可填充槽位是否都被覆盖
    for ts in slide_info.text_slots:
        if ts.is_fillable and ts.shape_id not in fill_map:
            result.issues.append(ValidationIssue(
                shape_id=ts.shape_id,
                issue_type="missing",
                severity="error",
                message=f"可填充槽位 shape_id={ts.shape_id} "
                        f"(role={ts.role}) 未被填充，"
                        f"将导致模板原始文字残留",
            ))
            result.suggestions.append(
                f"请为 shape_id={ts.shape_id} (role={ts.role}) "
                f"提供填充内容，或输出空文本 {{\"shape_id\": {ts.shape_id}, \"text\": \"\"}}"
            )

    # 2. 检查每个 fill 的内容长度
    for fill in fills:
        ts = slot_map.get(fill.shape_id)
        if ts is None:
            continue

        # 跳过图片填充
        if fill.image_url:
            continue

        actual_chars = count_fill_chars(fill)
        if actual_chars == 0:
            continue  # 空填充是合法的（用于清除占位文本）

        font_size = estimate_font_size_for_role(
            ts.role, ts.height)
        is_bullet = fill.items is not None and len(fill.items) > 0
        max_chars = estimate_max_chars(
            ts.width, ts.height, font_size, is_bullet)

        # 溢出检查（120% 阈值）
        if actual_chars > max_chars * 1.2:
            overflow_pct = round(
                (actual_chars / max_chars - 1) * 100)
            result.issues.append(ValidationIssue(
                shape_id=fill.shape_id,
                issue_type="overflow",
                severity="error" if overflow_pct > 50 else "warning",
                actual_chars=actual_chars,
                max_chars=max_chars,
                message=f"shape_id={fill.shape_id} (role={ts.role}) "
                        f"内容溢出约 {overflow_pct}%: "
                        f"实际 {actual_chars} 字 > 建议上限 {max_chars} 字。"
                        f"shape 尺寸: {ts.width / EMU_PER_CM:.1f}cm × "
                        f"{ts.height / EMU_PER_CM:.1f}cm",
            ))
            if is_bullet:
                result.suggestions.append(
                    f"shape_id={fill.shape_id}: "
                    f"请精简列表项至每条不超过 "
                    f"{max(10, max_chars // max(1, len(fill.items)))} 字，"
                    f"或减少列表项数量"
                )
            else:
                result.suggestions.append(
                    f"shape_id={fill.shape_id}: "
                    f"请将文本精简至 {max_chars} 字以内"
                )

        # 空洞检查（20% 阈值，仅对 body 角色）
        elif ts.role == "body" and actual_chars < max_chars * 0.15:
            result.issues.append(ValidationIssue(
                shape_id=fill.shape_id,
                issue_type="too_short",
                severity="warning",
                actual_chars=actual_chars,
                max_chars=max_chars,
                message=f"shape_id={fill.shape_id} (role={ts.role}) "
                        f"内容过少: 实际 {actual_chars} 字，"
                        f"建议至少 {int(max_chars * 0.2)} 字。"
                        f"shape 尺寸: {ts.width / EMU_PER_CM:.1f}cm × "
                        f"{ts.height / EMU_PER_CM:.1f}cm",
            ))
            result.suggestions.append(
                f"shape_id={fill.shape_id}: "
                f"内容区域较大，建议补充更多要点或详细说明"
            )

    # 3. 检查 bullet 项数是否合理
    for fill in fills:
        if not fill.items:
            continue
        ts = slot_map.get(fill.shape_id)
        if ts is None:
            continue

        font_size = estimate_font_size_for_role(ts.role, ts.height)
        line_height = font_size * DEFAULT_LINE_HEIGHT_FACTOR
        usable_height = (ts.height / EMU_PER_PT) * 0.85
        max_lines = max(1, int(usable_height / line_height))

        if len(fill.items) > max_lines:
            result.issues.append(ValidationIssue(
                shape_id=fill.shape_id,
                issue_type="overflow",
                severity="warning",
                actual_chars=len(fill.items),
                max_chars=max_lines,
                message=f"shape_id={fill.shape_id}: "
                        f"列表项 {len(fill.items)} 条超过"
                        f"该区域估算最大行数 {max_lines}",
            ))
            result.suggestions.append(
                f"shape_id={fill.shape_id}: "
                f"请将列表项精简至 {max_lines} 条以内"
            )

    # 汇总
    has_error = any(
        i.severity == "error" for i in result.issues)
    result.is_valid = not has_error

    if result.issues:
        logger.info(
            "幻灯片 %d 内容校验: %d 个问题 (%s)",
            slide_index,
            len(result.issues),
            "不通过" if has_error else "警告",
        )

    return result


def format_validation_feedback(result: ValidationResult) -> str:
    """将校验结果格式化为可直接反馈给 AI Agent 的文本。"""
    if result.is_valid and not result.issues:
        return ""

    lines = [f"## 内容校验反馈（第 {result.slide_index + 1} 页）\n"]

    for issue in result.issues:
        icon = "❌" if issue.severity == "error" else "⚠️"
        lines.append(f"{icon} {issue.message}")

    if result.suggestions:
        lines.append("\n### 修改建议：")
        for s in result.suggestions:
            lines.append(f"- {s}")

    return "\n".join(lines)
