"""
工具函数
"""
from __future__ import annotations

import logging
from typing import Optional

import httpx

logger = logging.getLogger(__name__)


async def download_image(url: str) -> Optional[bytes]:
    """异步下载图片，返回字节数据"""
    try:
        async with httpx.AsyncClient(
            timeout=30.0, follow_redirects=True
        ) as client:
            resp = await client.get(url)
            resp.raise_for_status()
            return resp.content
    except Exception as e:
        logger.warning("下载图片失败: %s -> %s", url, e)
        return None


def download_image_sync(url: str) -> Optional[bytes]:
    """同步下载图片"""
    try:
        with httpx.Client(
            timeout=30.0, follow_redirects=True
        ) as client:
            resp = client.get(url)
            resp.raise_for_status()
            return resp.content
    except Exception as e:
        logger.warning("下载图片失败: %s -> %s", url, e)
        return None


def download_file_sync(
    url: str, timeout: float = 60.0
) -> Optional[bytes]:
    """同步下载文件（用于模板等大文件）"""
    try:
        with httpx.Client(
            timeout=timeout, follow_redirects=True
        ) as client:
            resp = client.get(url)
            resp.raise_for_status()
            return resp.content
    except Exception as e:
        logger.warning("下载文件失败: %s -> %s", url, e)
        return None
