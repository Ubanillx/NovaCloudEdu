FROM python:3.11-slim

# 安装运行时依赖（包括 curl 用于健康检查）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-noto-cjk \
        fontconfig \
        poppler-utils \
        curl \
    && fc-cache -fv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录和非 root 用户
RUN mkdir -p /app && \
    useradd -m -u 1000 -s /bin/bash appuser && \
    chown -R appuser:appuser /app

WORKDIR /app

# 先复制依赖文件，利用 Docker 缓存
COPY --chown=appuser:appuser requirements.txt .
# 安装到系统目录，避免 PATH 问题
RUN pip install --no-cache-dir -r requirements.txt

# 复制源代码
COPY --chown=appuser:appuser src/ ./src/

# 切换到非 root 用户
USER appuser

EXPOSE 8100

ENV PORT=8100
ENV PYTHONUNBUFFERED=1

# 健康检查
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:8100/health || exit 1

CMD ["python", "-m", "uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8100"]
