FROM python:3.12-slim

# 安装系统依赖：中文字体 + curl + xz
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        xz-utils \
        fonts-noto-cjk \
        fonts-noto-cjk-extra \
    && rm -rf /var/lib/apt/lists/*

# 安装 Typst CLI (从 GitHub Releases 下载)
RUN ARCH=$(uname -m) && \
    TYPST_ARCH="x86_64" && \
    if [ "$ARCH" = "aarch64" ]; then TYPST_ARCH="aarch64"; fi && \
    curl -fsSL "https://github.com/typst/typst/releases/latest/download/typst-${TYPST_ARCH}-unknown-linux-musl.tar.xz" -o /tmp/typst.tar.xz && \
    tar -xf /tmp/typst.tar.xz -C /tmp && \
    mv /tmp/typst-${TYPST_ARCH}-unknown-linux-musl/typst /usr/local/bin/typst && \
    rm -rf /tmp/typst.tar.xz /tmp/typst-${TYPST_ARCH}-unknown-linux-musl

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8200

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8200"]
