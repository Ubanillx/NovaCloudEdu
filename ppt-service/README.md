# PPT 模板生成微服务

基于 PPTX 模板的克隆式 PPT 生成服务，供 NovaCloudEdu Java 后端调用。
提供 **HTTP REST + MCP (JSON-RPC)** 双协议接口。

模板文件和生成产物均存储在 **阿里云 OSS**，Python 侧不存储模板。

## 功能特性

- **模板驱动**：保留 PPTX 模板的完整视觉设计，按 `shape_id` 精准填充
- **OSS 集成**：生成的 PPTX 自动上传 OSS，返回下载 URL
- **封面截图**：解析模板时自动截取第一页生成封面缩略图上传 OSS
- **文本填充**：替换文本并保留原始字体格式
- **图片替换**：通过 `image_url` 替换模板中的图片形状
- **双协议**：HTTP REST + MCP JSON-RPC（兼容 AI 智能体调用）
- **中文支持**：Docker 镜像内置思源黑体

---

## 快速启动

### Docker（推荐）

```bash
cd ppt-service

# 设置 OSS 环境变量
export OSS_ENDPOINT=oss-cn-hangzhou.aliyuncs.com
export OSS_ACCESS_KEY_ID=your-key-id
export OSS_ACCESS_KEY_SECRET=your-key-secret
export OSS_BUCKET_NAME=your-bucket
export OSS_DOMAIN=https://your-cdn-domain.com  # 可选

docker-compose up -d
```

服务运行在 `http://localhost:8100`

### 本地开发

```bash
cd ppt-service
pip install -r requirements.txt

# 设置 OSS 环境变量（同上）
uvicorn src.server:app --host 0.0.0.0 --port 8100 --reload
```

---

## HTTP REST 接口

### 1. 解析模板 — `POST /api/templates/parse`

从 URL 下载 PPTX 模板并解析结构，自动截取封面上传 OSS。

```bash
curl -X POST http://localhost:8100/api/templates/parse \
  -H "Content-Type: application/json" \
  -d '{"template_url": "https://oss.example.com/ppt/template/xxx.pptx"}'
```

响应：

```json
{
  "success": true,
  "template_id": "xxx",
  "name": "xxx",
  "slide_count": 22,
  "cover_url": "https://oss.example.com/ppt/cover/20250212/abc.png",
  "slides": [
    {
      "index": 0,
      "role": "cover",
      "text_slots": [
        {"shape_id": 15, "role": "title", "sample_text": "标题文本", "is_fillable": true}
      ],
      "image_slots": [
        {"shape_id": 7, "name": "Picture 6", "width": 9144000, "height": 6858000}
      ]
    }
  ]
}
```

### 2. 生成 PPTX — `POST /api/generate`

基于模板 + 填充规格生成 PPTX，上传 OSS 返回文件 URL。

```bash
curl -X POST http://localhost:8100/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "template_url": "https://oss.example.com/ppt/template/xxx.pptx",
    "title": "AI助力教育发展",
    "author": "NovaCloudEdu",
    "slides": [
      {
        "template_slide_index": 0,
        "fills": [
          {"shape_id": 15, "text": "AI 助力教育发展"}
        ]
      },
      {
        "template_slide_index": 3,
        "fills": [
          {"shape_id": 9,  "text": "个性化学习"},
          {"shape_id": 10, "text": "AI 为每位学生定制学习计划"}
        ]
      }
    ]
  }'
```

响应：

```json
{
  "success": true,
  "file_name": "AI助力教育发展.pptx",
  "file_url": "https://oss.example.com/ppt/generated/20250212/def.pptx",
  "slide_count": 2,
  "preview": [
    {
      "slide_index": 0,
      "template_slide_index": 0,
      "elements": [
        {"role": "title", "text": "AI 助力教育发展", "left_pct": 6.66, "top_pct": 41.27}
      ]
    }
  ]
}
```

### 填充参数说明

| 字段 | 类型 | 说明 |
|------|------|------|
| `shape_id` | `int` | **必填**。目标形状 ID |
| `text` | `string` | 替换文本内容（支持 `\n` 多行） |
| `items` | `string[]` | 列表项（bullet 模式） |
| `image_url` | `string` | 图片 URL（替换 Picture 形状） |

### 3. 健康检查 — `GET /health`

```bash
curl http://localhost:8100/health
# {"status": "ok", "service": "ppt-template-server"}
```

---

## MCP 接口

通过 `POST /mcp` 端点提供 JSON-RPC 2.0 协议的 MCP 工具调用。

| MCP 工具名 | 对应 HTTP 接口 | 说明 |
|------------|---------------|------|
| `parse_template` | `POST /api/templates/parse` | 解析模板 + 截封面 |
| `generate_ppt_from_template` | `POST /api/generate` | 生成 PPTX → OSS URL |

---

## Java 后端集成

模板管理由 Java 后端负责，通过 `PptTemplateController` 提供 REST API。

### Java API 端点

| 方法 | 路径 | 说明 |
|------|------|------|
| `POST` | `/api/ppt/templates` | 上传 PPTX 模板（multipart） |
| `GET` | `/api/ppt/templates` | 列出可用模板 |
| `GET` | `/api/ppt/templates/{id}` | 模板详情（含 structureJson） |
| `DELETE` | `/api/ppt/templates/{id}` | 删除模板 |
| `POST` | `/api/ppt/generate` | 生成 PPT |

### 完整调用流程

```
前端                      Java 后端                      Python ppt-service
 │                          │                                │
 ├─ 上传 PPTX ────────────▶ OSS(ppt/template) + DB          │
 │                          │ ─ 调 Python parse ───────────▶ 下载 → 解析 → 截封面 → 上传 OSS
 │                          │ ◀── 返回 structureJson + coverUrl
 │                          │ ─ 存 DB                        │
 ├─ 列表 ─────────────────▶ 从 DB 返回摘要                   │
 ├─ 详情 ─────────────────▶ 从 DB 返回 structureJson         │
 ├─ 生成 PPT ─────────────▶ 查 DB 得 templateUrl             │
 │                          │ ─ 调 Python generate ────────▶ 下载模板 → 生成 → 上传 OSS
 │                          │ ◀── 返回 file_url              │
 └─ 下载 ◀──────────────── 返回 OSS URL                     │
```

### 配置

`application-dev.yml`:

```yaml
ppt-service:
  url: http://localhost:8100
```

`docker-compose.yml` 环境变量:

```yaml
OSS_ENDPOINT, OSS_ACCESS_KEY_ID, OSS_ACCESS_KEY_SECRET, OSS_BUCKET_NAME, OSS_DOMAIN
```

---

## 项目结构

```
ppt-service/
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── README.md
├── src/
│   ├── __init__.py
│   ├── server.py            # FastAPI 服务（HTTP REST + MCP 双协议）
│   ├── schemas.py           # Pydantic 数据模型
│   ├── oss_client.py        # 阿里云 OSS 上传客户端
│   ├── thumbnail.py         # PPT 封面缩略图生成
│   ├── slide_cloner.py      # 幻灯片克隆/删除工具
│   ├── template_parser.py   # 模板解析器
│   ├── template_renderer.py # 模板渲染器（克隆 + 填充）
│   ├── template_registry.py # 模板注册表（URL 下载缓存）
│   └── utils.py             # HTTP 下载工具函数
```

## 核心模块说明

| 模块 | 职责 |
|------|------|
| `server.py` | 双协议服务端：HTTP REST + MCP JSON-RPC |
| `oss_client.py` | 阿里云 OSS 上传（oss2 SDK），与 Java 侧共享存储结构 |
| `thumbnail.py` | 从 PPTX 第一页生成封面缩略图（Pillow） |
| `schemas.py` | 数据模型定义 |
| `template_renderer.py` | 克隆模板页 → 填充文本/图片 → 输出 PPTX |
| `template_registry.py` | URL 下载模板 → 解析 → 缓存配置 |

---

## 关键技术细节

### 克隆机制（slide_cloner.py）

1. `prs.slides.add_slide(layout)` 创建空白页
2. 深拷贝源幻灯片 `spTree` + 构建 rId 映射
3. 只复制 `<p:bg>` 背景元素（不替换整个 cSld）

### 文本填充

- 递归遍历所有形状（含 GROUP 子形状）
- 通过 `shape_id` 定位，保留原始字体格式
- 支持多行文本和列表项

### 图片替换

- 下载图片 URL → 替换 Picture 形状
- 非 Picture 形状用 `add_picture()` 在同位置插入
