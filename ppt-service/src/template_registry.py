"""
模板注册表：管理系统预设模板和用户上传模板。
启动时扫描 templates/ 目录并解析配置，
支持通过 URL 下载用户模板并缓存。
"""
from __future__ import annotations

import hashlib
import logging
from pathlib import Path
from typing import Optional

from .schemas import TemplateConfig
from .template_parser import parse_template

logger = logging.getLogger(__name__)

# 模板根目录（相对于项目根）
_BASE_DIR = Path(__file__).resolve().parent.parent
TEMPLATES_DIR = _BASE_DIR / "templates"
CUSTOM_DIR = TEMPLATES_DIR / "custom"


class TemplateRegistry:
    """模板注册表（单例使用）"""

    def __init__(self):
        self._configs: dict[str, TemplateConfig] = {}
        self._paths: dict[str, Path] = {}

    # ---- 初始化 ----

    def scan_presets(self):
        """扫描 templates/ 下所有 .pptx 预设模板"""
        TEMPLATES_DIR.mkdir(parents=True, exist_ok=True)
        CUSTOM_DIR.mkdir(parents=True, exist_ok=True)

        for f in sorted(TEMPLATES_DIR.glob("*.pptx")):
            tid = f.stem
            try:
                cfg = parse_template(f, tid, tid)
                self._configs[tid] = cfg
                self._paths[tid] = f
                logger.info(
                    "预设模板已注册: %s (%d 页)",
                    tid, cfg.slide_count)
            except Exception as e:
                logger.error(
                    "预设模板解析失败: %s -> %s",
                    f.name, e)

    # ---- 查询 ----

    def list_templates(self) -> list[dict]:
        """返回所有可用模板的摘要列表"""
        result = []
        for tid, cfg in self._configs.items():
            slides_summary = [
                {
                    "index": si.index,
                    "role": si.role,
                    "fillable_count": si.fillable_count,
                }
                for si in cfg.slides
            ]
            result.append({
                "template_id": tid,
                "name": cfg.name,
                "slide_count": cfg.slide_count,
                "slides": slides_summary,
            })
        return result

    def all_configs(self) -> dict[str, TemplateConfig]:
        """返回所有已注册模板的配置"""
        return self._configs

    def get_config(
        self, template_id: str
    ) -> Optional[TemplateConfig]:
        return self._configs.get(template_id)

    def get_path(
        self, template_id: str
    ) -> Optional[Path]:
        return self._paths.get(template_id)

    # ---- 用户上传 ----

    def register_from_url(self, url: str) -> TemplateConfig:
        """下载用户模板并注册"""
        from .utils import download_file_sync
        data = download_file_sync(url)
        if not data:
            raise RuntimeError(f"下载模板失败: {url}")

        # 用 URL hash 作为 ID
        url_hash = hashlib.md5(
            url.encode()).hexdigest()[:12]
        tid = f"custom_{url_hash}"
        CUSTOM_DIR.mkdir(parents=True, exist_ok=True)
        dest = CUSTOM_DIR / f"{tid}.pptx"
        dest.write_bytes(data)

        cfg = parse_template(dest, tid, tid)
        self._configs[tid] = cfg
        self._paths[tid] = dest
        logger.info(
            "用户模板已注册: %s (%d 页)",
            tid, cfg.slide_count)
        return cfg

    def register_from_bytes(
        self, data: bytes, name: str = ""
    ) -> TemplateConfig:
        """从字节数据注册模板"""
        data_hash = hashlib.md5(data).hexdigest()[:12]
        tid = f"custom_{data_hash}"
        CUSTOM_DIR.mkdir(parents=True, exist_ok=True)
        dest = CUSTOM_DIR / f"{tid}.pptx"
        dest.write_bytes(data)

        display = name or tid
        cfg = parse_template(dest, tid, display)
        self._configs[tid] = cfg
        self._paths[tid] = dest
        return cfg


# 全局单例
registry = TemplateRegistry()
