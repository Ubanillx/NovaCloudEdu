"""
高保真幻灯片渲染器：通过 Gotenberg (LibreOffice) 将 PPTX 转为 PDF，
再用 pdf2image 将 PDF 按页转为 PNG 图片。

环境变量：
  GOTENBERG_URL - Gotenberg 服务地址（默认 http://localhost:3000）
"""
from __future__ import annotations

import io
import logging
import os
from pathlib import Path
from typing import Union

import httpx
from pdf2image import convert_from_bytes
from PIL import Image

logger = logging.getLogger(__name__)

GOTENBERG_URL = os.environ.get("GOTENBERG_URL", "http://localhost:3000")

# 缩略图 DPI（用于模板选择预览）
THUMBNAIL_DPI = 150
# 高清 DPI（用于视觉模型输入）
HIGHRES_DPI = 200


def _pptx_to_pdf(pptx_data: bytes) -> bytes:
    """
    调用 Gotenberg LibreOffice 接口将 PPTX 转为 PDF。
    """
    url = f"{GOTENBERG_URL}/forms/libreoffice/convert"

    with httpx.Client(timeout=120.0) as client:
        resp = client.post(
            url,
            files={"files": ("template.pptx", pptx_data, "application/vnd.openxmlformats-officedocument.presentationml.presentation")},
        )
        resp.raise_for_status()

    logger.info("Gotenberg PPTX→PDF 转换完成: %d bytes", len(resp.content))
    return resp.content


def _pil_to_png(img: Image.Image) -> bytes:
    """将 PIL Image 转为 PNG bytes"""
    buf = io.BytesIO()
    img.save(buf, format="PNG", optimize=True)
    return buf.getvalue()


def _read_pptx_bytes(source: Union[str, Path, bytes]) -> bytes:
    """统一读取 PPTX 数据为 bytes"""
    if isinstance(source, bytes):
        return source
    path = Path(source)
    return path.read_bytes()


def render_pptx_to_images(source: Union[str, Path, bytes], dpi: int = THUMBNAIL_DPI) -> list[bytes]:
    """
    将 PPTX 的每一页渲染为高保真 PNG 图片。

    流程: PPTX → Gotenberg(LibreOffice) → PDF → pdf2image → PNG list

    Args:
        source: PPTX 文件路径或字节数据
        dpi: 渲染分辨率

    Returns:
        PNG 图片字节列表，按页码顺序
    """
    pptx_bytes = _read_pptx_bytes(source)
    pdf_bytes = _pptx_to_pdf(pptx_bytes)

    images = convert_from_bytes(pdf_bytes, dpi=dpi)
    results = [_pil_to_png(img) for img in images]

    logger.info("全部 %d 页渲染完成 (dpi=%d)", len(results), dpi)
    return results


def render_pptx_cover(source: Union[str, Path, bytes], dpi: int = THUMBNAIL_DPI) -> bytes:
    """
    渲染 PPTX 第一页为封面 PNG。

    Args:
        source: PPTX 文件路径或字节数据
        dpi: 渲染分辨率

    Returns:
        PNG 图片字节数据
    """
    pptx_bytes = _read_pptx_bytes(source)
    pdf_bytes = _pptx_to_pdf(pptx_bytes)

    images = convert_from_bytes(pdf_bytes, dpi=dpi, first_page=1, last_page=1)
    if not images:
        raise RuntimeError("封面渲染失败：PDF 无页面")

    cover_bytes = _pil_to_png(images[0])
    logger.info("封面渲染完成: %d bytes (dpi=%d)", len(cover_bytes), dpi)
    return cover_bytes


def render_pptx_first_page(source: Union[str, Path, bytes],
                           dpi: int = THUMBNAIL_DPI) -> bytes:
    """
    渲染 PPTX 第一页为 PNG（接受 bytes 输入，用于单页预览）。

    与 render_pptx_cover 功能相同，但名称更明确用于生成预览。
    """
    pptx_bytes = _read_pptx_bytes(source)
    pdf_bytes = _pptx_to_pdf(pptx_bytes)

    images = convert_from_bytes(
        pdf_bytes, dpi=dpi, first_page=1, last_page=1)
    if not images:
        raise RuntimeError("渲染失败：PDF 无页面")

    result = _pil_to_png(images[0])
    logger.info(
        "首页渲染完成: %d bytes (dpi=%d)", len(result), dpi)
    return result


def render_single_slide(source: Union[str, Path, bytes], slide_index: int,
                        dpi: int = HIGHRES_DPI) -> bytes:
    """
    渲染 PPTX 指定单页为高清 PNG（用于视觉模型输入）。

    Args:
        source: PPTX 文件路径或字节数据
        slide_index: 页码索引（0-based）
        dpi: 渲染分辨率

    Returns:
        PNG 图片字节数据
    """
    pptx_bytes = _read_pptx_bytes(source)
    pdf_bytes = _pptx_to_pdf(pptx_bytes)

    page_num = slide_index + 1  # pdf2image 使用 1-based
    images = convert_from_bytes(pdf_bytes, dpi=dpi,
                                first_page=page_num, last_page=page_num)
    if not images:
        raise RuntimeError(f"渲染第 {slide_index} 页失败：PDF 页数不足")

    result = _pil_to_png(images[0])
    logger.info("第 %d 页高清渲染完成: %d bytes (dpi=%d)", slide_index, len(result), dpi)
    return result
