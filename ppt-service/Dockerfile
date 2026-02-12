FROM python:3.11-slim

# 安装中文字体（思源黑体）
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-noto-cjk \
        fontconfig \
        poppler-utils \
    && fc-cache -fv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/

EXPOSE 8100

ENV PORT=8100

CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8100"]
