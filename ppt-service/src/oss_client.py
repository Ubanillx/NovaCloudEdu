"""
阿里云 OSS 客户端封装。
通过环境变量配置，与 Java 后端 AliyunOssService 使用相同的存储结构。

环境变量：
  OSS_ENDPOINT          - OSS 端点（如 oss-cn-hangzhou.aliyuncs.com）
  OSS_ACCESS_KEY_ID     - Access Key ID
  OSS_ACCESS_KEY_SECRET - Access Key Secret
  OSS_BUCKET_NAME       - Bucket 名称
  OSS_DOMAIN            - 自定义域名（可选，如 https://cdn.example.com）
"""
from __future__ import annotations

import logging
import os
import uuid
from datetime import datetime
from pathlib import Path

import oss2

# 自动加载项目根目录下的 .env 文件
_env_path = Path(__file__).resolve().parent.parent / ".env"
if _env_path.exists():
    with open(_env_path) as _f:
        for _line in _f:
            _line = _line.strip()
            if _line and not _line.startswith("#") and "=" in _line:
                _k, _, _v = _line.partition("=")
                os.environ.setdefault(_k.strip(), _v.strip())

logger = logging.getLogger(__name__)

# ---- 配置 ----

OSS_ENDPOINT = os.environ.get("OSS_ENDPOINT", "")
OSS_ACCESS_KEY_ID = os.environ.get("OSS_ACCESS_KEY_ID", "")
OSS_ACCESS_KEY_SECRET = os.environ.get("OSS_ACCESS_KEY_SECRET", "")
OSS_BUCKET_NAME = os.environ.get("OSS_BUCKET_NAME", "")
OSS_DOMAIN = os.environ.get("OSS_DOMAIN", "")


def _is_configured() -> bool:
    """检查 OSS 是否已配置"""
    return bool(OSS_ENDPOINT and OSS_ACCESS_KEY_ID
                and OSS_ACCESS_KEY_SECRET and OSS_BUCKET_NAME)


def _get_bucket() -> oss2.Bucket:
    """获取 OSS Bucket 实例"""
    if not _is_configured():
        raise RuntimeError(
            "OSS 未配置，请设置环境变量: "
            "OSS_ENDPOINT, OSS_ACCESS_KEY_ID, "
            "OSS_ACCESS_KEY_SECRET, OSS_BUCKET_NAME"
        )
    auth = oss2.Auth(OSS_ACCESS_KEY_ID, OSS_ACCESS_KEY_SECRET)
    return oss2.Bucket(auth, OSS_ENDPOINT, OSS_BUCKET_NAME)


def _build_url(object_name: str) -> str:
    """根据 objectName 构建访问 URL（与 Java 侧逻辑一致）"""
    if OSS_DOMAIN:
        domain = OSS_DOMAIN.rstrip("/")
        return f"{domain}/{object_name}"
    return f"https://{OSS_BUCKET_NAME}.{OSS_ENDPOINT}/{object_name}"


def upload_bytes(
    data: bytes,
    extension: str,
    biz_folder: str = "ppt/generated",
) -> str:
    """
    上传字节数据到 OSS。

    Args:
        data: 文件字节内容
        extension: 文件扩展名（如 ".pptx", ".png"）
        biz_folder: 业务文件夹（如 "ppt/generated", "ppt/cover"）

    Returns:
        文件访问 URL
    """
    bucket = _get_bucket()

    date_folder = datetime.now().strftime("%Y%m%d")
    file_name = uuid.uuid4().hex + extension
    object_name = f"{biz_folder}/{date_folder}/{file_name}"

    bucket.put_object(object_name, data)
    url = _build_url(object_name)
    logger.info(
        "OSS 上传成功: %s (%.1f KB)", url, len(data) / 1024)
    return url
