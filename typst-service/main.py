"""
Typst 编译微服务
接收试卷 JSON 数据，生成 Typst 源码并编译为 PDF
"""

import json
import os
import tempfile
import subprocess
import copy
import mimetypes
import re
import urllib.request
from urllib.parse import urlparse
from pathlib import Path

from fastapi import FastAPI, HTTPException
from fastapi.responses import Response
from pydantic import BaseModel

app = FastAPI(title="Typst Compile Service", version="1.0.0")

TEMPLATES_DIR = Path(__file__).parent / "templates"
MAX_IMAGE_BYTES = 10 * 1024 * 1024


class CompileRequest(BaseModel):
    """编译请求"""
    template: str = "exam_paper"
    data: dict


def _image_extension(url: str, content_type: str | None) -> str:
    """Infer a Typst-friendly image extension from URL or HTTP content type."""
    if content_type:
        ext = mimetypes.guess_extension(content_type.split(";")[0].strip())
        if ext in {".jpg", ".jpeg", ".png", ".webp", ".gif", ".svg"}:
            return ".jpg" if ext == ".jpeg" else ext

    path = urlparse(url).path
    ext = Path(path).suffix.lower()
    if ext in {".jpg", ".jpeg", ".png", ".webp", ".gif", ".svg"}:
        return ".jpg" if ext == ".jpeg" else ext
    return ".png"


def _download_image(url: str, output_path: Path) -> str | None:
    """Download one question image with a hard size limit."""
    try:
        request = urllib.request.Request(url, headers={"User-Agent": "NovaCloudEdu-Typst/1.0"})
        with urllib.request.urlopen(request, timeout=10) as response:
            content_type = response.headers.get("Content-Type")
            ext = _image_extension(url, content_type)
            final_path = output_path.with_suffix(ext)

            data = response.read(MAX_IMAGE_BYTES + 1)
            if len(data) > MAX_IMAGE_BYTES:
                return None
            final_path.write_bytes(data)
            return final_path.name
    except Exception:
        return None


def prepare_question_images(data: dict, tmpdir: str) -> dict:
    """
    Typst reads local files, not remote OSS URLs. Download question images into
    the compile temp dir and add image_path to each question for templates.
    """
    prepared = copy.deepcopy(data)
    assets_dir = Path(tmpdir) / "assets"
    assets_dir.mkdir(exist_ok=True)

    for section_index, section in enumerate(prepared.get("sections", []), start=1):
        for question_index, question in enumerate(section.get("questions", []), start=1):
            image_url = question.get("imageUrl") or question.get("image_url")
            if not image_url:
                continue

            base_path = assets_dir / f"question_{section_index}_{question_index}"
            filename = _download_image(str(image_url), base_path)
            if filename:
                question["image_path"] = f"assets/{filename}"

    return prepared


def sanitize_cetz_code(code: str) -> str:
    """Normalize common LLM mistakes that are invalid in CeTZ."""
    if not code:
        return code
    replacements = (
        (r"mark\s*:\s*\"\"", "mark: none"),
        (r"mark\s*:\s*''", "mark: none"),
        (r"start\s*:\s*\"\"", "start: none"),
        (r"start\s*:\s*''", "start: none"),
        (r"end\s*:\s*\"\"", "end: none"),
        (r"end\s*:\s*''", "end: none"),
    )
    normalized = code
    for pattern, replacement in replacements:
        normalized = re.sub(pattern, replacement, normalized)
    return normalized


@app.get("/health")
async def health():
    return {"status": "ok", "service": "typst-service"}


@app.post("/compile")
async def compile_pdf(request: CompileRequest):
    """
    接收试卷 JSON 数据，使用 Typst 模板编译为 PDF
    """
    template_file = TEMPLATES_DIR / f"{request.template}.typ"
    if not template_file.exists():
        raise HTTPException(status_code=400, detail=f"模板不存在: {request.template}")

    with tempfile.TemporaryDirectory() as tmpdir:
        data = prepare_question_images(request.data, tmpdir)
        # 写入 JSON 数据文件
        data_file = os.path.join(tmpdir, "data.json")
        with open(data_file, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

        # 复制模板文件到临时目录
        main_typ = os.path.join(tmpdir, "main.typ")
        with open(template_file, "r", encoding="utf-8") as src:
            template_content = src.read()
        with open(main_typ, "w", encoding="utf-8") as dst:
            dst.write(template_content)

        # 编译 Typst → PDF
        output_pdf = os.path.join(tmpdir, "output.pdf")
        result = subprocess.run(
            ["typst", "compile", main_typ, output_pdf],
            capture_output=True,
            text=True,
            timeout=30,
        )

        if result.returncode != 0:
            raise HTTPException(
                status_code=500,
                detail=f"Typst 编译失败: {result.stderr}"
            )

        # 读取并返回 PDF
        with open(output_pdf, "rb") as f:
            pdf_bytes = f.read()

        return Response(
            content=pdf_bytes,
            media_type="application/pdf",
            headers={
                "Content-Disposition": "inline; filename=exam_paper.pdf",
                "X-Compile-Status": "success",
            }
        )


class CompileWithTemplateRequest(BaseModel):
    """自定义模板编译请求"""
    template_content: str
    data: dict


@app.post("/compile-with-template")
async def compile_with_template(request: CompileWithTemplateRequest):
    """
    接收自定义 Typst 模板源码 + JSON 数据，编译为 PDF
    用于用户上传的自定义试卷模板
    """
    with tempfile.TemporaryDirectory() as tmpdir:
        data = prepare_question_images(request.data, tmpdir)
        # 写入 JSON 数据文件
        data_file = os.path.join(tmpdir, "data.json")
        with open(data_file, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)

        # 写入用户自定义模板
        main_typ = os.path.join(tmpdir, "main.typ")
        with open(main_typ, "w", encoding="utf-8") as dst:
            dst.write(request.template_content)

        # 编译 Typst → PDF
        output_pdf = os.path.join(tmpdir, "output.pdf")
        result = subprocess.run(
            ["typst", "compile", main_typ, output_pdf],
            capture_output=True,
            text=True,
            timeout=30,
        )

        if result.returncode != 0:
            raise HTTPException(
                status_code=500,
                detail=f"Typst 编译失败: {result.stderr}"
            )

        with open(output_pdf, "rb") as f:
            pdf_bytes = f.read()

        return Response(
            content=pdf_bytes,
            media_type="application/pdf",
            headers={
                "Content-Disposition": "inline; filename=exam_paper.pdf",
                "X-Compile-Status": "success",
            }
        )


class RenderRequest(BaseModel):
    """SVG 渲染请求"""
    code: str
    template: str = "geometry"


@app.post("/render-svg")
async def render_svg(request: RenderRequest):
    """
    将 Typst 绘图代码编译为 SVG（用于几何图形渲染）
    """
    template_file = TEMPLATES_DIR / f"{request.template}.typ"
    if not template_file.exists():
        raise HTTPException(status_code=400, detail=f"模板不存在: {request.template}")

    with tempfile.TemporaryDirectory() as tmpdir:
        # 写入绘图代码数据
        data_file = os.path.join(tmpdir, "data.json")
        with open(data_file, "w", encoding="utf-8") as f:
            json.dump({"code": sanitize_cetz_code(request.code)}, f, ensure_ascii=False)

        # 复制模板
        main_typ = os.path.join(tmpdir, "main.typ")
        with open(template_file, "r", encoding="utf-8") as src:
            content = src.read()
        with open(main_typ, "w", encoding="utf-8") as dst:
            dst.write(content)

        # 编译为 SVG
        output_svg = os.path.join(tmpdir, "output.svg")
        result = subprocess.run(
            ["typst", "compile", "--format", "svg", main_typ, output_svg],
            capture_output=True,
            text=True,
            timeout=30,
        )

        if result.returncode != 0:
            raise HTTPException(
                status_code=500,
                detail=f"Typst SVG 编译失败: {result.stderr}"
            )

        with open(output_svg, "rb") as f:
            svg_bytes = f.read()

        return Response(
            content=svg_bytes,
            media_type="image/svg+xml",
            headers={"X-Compile-Status": "success"}
        )


@app.post("/render-png")
async def render_png(request: RenderRequest):
    """
    将 Typst 绘图代码编译为 PNG（用于几何图形渲染后上传 OSS）
    """
    template_file = TEMPLATES_DIR / f"{request.template}.typ"
    if not template_file.exists():
        raise HTTPException(status_code=400, detail=f"模板不存在: {request.template}")

    with tempfile.TemporaryDirectory() as tmpdir:
        data_file = os.path.join(tmpdir, "data.json")
        with open(data_file, "w", encoding="utf-8") as f:
            json.dump({"code": sanitize_cetz_code(request.code)}, f, ensure_ascii=False)

        main_typ = os.path.join(tmpdir, "main.typ")
        with open(template_file, "r", encoding="utf-8") as src:
            content = src.read()
        with open(main_typ, "w", encoding="utf-8") as dst:
            dst.write(content)

        output_png = os.path.join(tmpdir, "output.png")
        result = subprocess.run(
            ["typst", "compile", "--format", "png", "--ppi", "300", main_typ, output_png],
            capture_output=True,
            text=True,
            timeout=30,
        )

        if result.returncode != 0:
            raise HTTPException(
                status_code=500,
                detail=f"Typst PNG 编译失败: {result.stderr}"
            )

        with open(output_png, "rb") as f:
            png_bytes = f.read()

        return Response(
            content=png_bytes,
            media_type="image/png",
            headers={"X-Compile-Status": "success"}
        )


@app.get("/templates")
async def list_templates():
    """列出可用模板"""
    templates = [f.stem for f in TEMPLATES_DIR.glob("*.typ")]
    return {"templates": templates}
