# NovaCloudEdu 部署教程

本文给出一套可直接落地的部署方式：

- 前端打包后交给 Nginx 托管
- 后端以本地进程方式启动
- Docker 只负责基础设施服务，不启动 `backend` 容器

适用于把项目部署到一台 Linux 服务器，Nginx 对外提供访问，后端监听 `8080`，前端通过 `/api` 反向代理访问接口。

---

## 1. 部署拓扑

推荐的运行方式如下：

- Nginx：对外提供 `80` 端口
- 前端：`web/dist` 静态文件，由 Nginx 直接读取
- 后端：本机 Java 进程，监听 `8080`
- Docker：只启动数据库、Redis、Elasticsearch、Neo4j、文档服务、音视频服务等基础设施

这样做的好处是：

- 前端、后端和基础设施职责分离
- 便于排查问题，后端日志在本机，基础设施日志在 Docker
- 避免 `docker backend` 和本机后端同时占用 `8080` 端口

---

## 2. 前置条件

服务器上需要准备：

- Java 21
- Maven 3.9+
- Node.js 20+
- Docker 和 Docker Compose
- Nginx

如果你已经使用仓库里的构建环境，可以直接跳到后续步骤。

---

## 3. 启动 Docker 基础设施

进入 Docker 目录，先复制环境变量文件：

```bash
cd /home/debian/NovaCloudEdu/docker
cp .env.example .env
```

然后编辑 `.env`，至少确认这些值已修改为你自己的配置：

- `DB_PASSWORD`
- `REDIS_PASSWORD`
- `NEO4J_AUTH` / `NEO4J_PASSWORD`
- `JWT_SECRET`
- `ONLYOFFICE_JWT_SECRET`
- `TURN_PASSWORD`
- 需要外部能力时的 `ALIYUN_OSS_*`、`DASHSCOPE_API_KEY`、`MAIL_*` 等

### 3.1 不要启动 Docker 里的 backend

由于后端要改成本地进程启动，所以有两种做法：

1. 直接不要把 `backend` 放进启动命令里
2. 如果已经启动过，先停掉它

建议使用下面命令确保它是关闭的：

```bash
docker compose stop backend
docker compose rm -f backend
```

### 3.2 启动基础设施服务

启动时只跑基础设施和依赖服务，不包括 `backend`：

```bash
docker compose up -d \
  postgres redis elasticsearch neo4j \
  gotenberg onlyoffice \
  ppt-service typst-service \
  rtc-service srs coturn livekit
```

如果你当前业务只需要数据库和缓存，也可以只启动最小集合：

```bash
docker compose up -d postgres redis elasticsearch neo4j gotenberg onlyoffice
```

### 3.3 检查 Docker 服务状态

```bash
docker compose ps
```

常见检查项：

- PostgreSQL 是否在 `5432`
- Redis 是否在 `6379`
- Elasticsearch 是否在 `9200`
- Neo4j 是否在 `7474/7687`

---

## 4. 本地启动后端

后端默认配置文件是 `backend/src/main/resources/application.yml`，它会读取本机环境变量。

### 4.1 先准备数据库连接变量

因为基础设施是 Docker 启动、后端是本机启动，所以后端连接的主机地址应该指向本机 `127.0.0.1`：

```bash
export DB_HOST=127.0.0.1
export DB_PORT=5432
export REDIS_HOST=127.0.0.1
export REDIS_PORT=6379
export NEO4J_HOST=127.0.0.1
export NEO4J_BOLT_PORT=7687
export ES_HOST=127.0.0.1
export ES_PORT=9200
```

如果你使用了外部对象存储、AI、邮件、短信等能力，也继续补上对应变量。

### 4.2 构建后端

```bash
cd /home/debian/NovaCloudEdu/backend
mvn package -DskipTests
```

### 4.3 通过 systemd 启动后端

仓库里已经提供了一个管理脚本：[backend/manage-backend.sh](../backend/manage-backend.sh) 和 systemd 单元模板：[backend/systemd/novacloudedu-backend.service](../backend/systemd/novacloudedu-backend.service)。

先把环境变量文件放到系统默认位置：

```bash
sudo cp /home/debian/NovaCloudEdu/backend/systemd/novacloudedu-backend.env.example /etc/default/novacloudedu-backend
sudo nano /etc/default/novacloudedu-backend
```

然后安装并启用 systemd 服务：

```bash
cd /home/debian/NovaCloudEdu/backend
sudo ./manage-backend.sh service-install
sudo systemctl start novacloudedu-backend
sudo systemctl enable novacloudedu-backend
```

如果你还想手动以进程方式启动，脚本也保留了原来的本地管理方式：

```bash
cd /home/debian/NovaCloudEdu/backend
SPRING_PROFILES_ACTIVE=dev \
DB_HOST=127.0.0.1 \
DB_PORT=5432 \
REDIS_HOST=127.0.0.1 \
REDIS_PORT=6379 \
NEO4J_HOST=127.0.0.1 \
NEO4J_BOLT_PORT=7687 \
ES_HOST=127.0.0.1 \
ES_PORT=9200 \
./manage-backend.sh start
```

常用管理命令：

```bash
sudo systemctl status novacloudedu-backend
sudo systemctl stop novacloudedu-backend
sudo systemctl restart novacloudedu-backend
sudo journalctl -u novacloudedu-backend -f

# 本地进程模式
./manage-backend.sh status
./manage-backend.sh logs
./manage-backend.sh stop
./manage-backend.sh restart
```

### 4.4 后端启动检查

如果后端正常运行，应该能看到：

- 进程在 `8080`
- `systemctl status novacloudedu-backend` 显示 active (running)
- `curl http://127.0.0.1:8080/api/health` 返回正常结果

---

## 5. 打包前端并部署到 Nginx

前端已经配置为通过 `/api` 访问后端。

### 5.1 设置前端环境变量

在 `web/.env.production` 中保持：

```env
VITE_API_BASE_URL=/api
```

这意味着浏览器访问接口时会走同域 `/api`，再由 Nginx 转发到本地后端。

### 5.2 构建前端

```bash
cd /home/debian/NovaCloudEdu/web
npm install
npm run build
```

### 5.3 部署静态文件

把 `dist` 复制到 Nginx 的站点目录：

```bash
sudo mkdir -p /var/www/novacloudedu/web
sudo rsync -a --delete /home/debian/NovaCloudEdu/web/dist/ /var/www/novacloudedu/web/dist/
```

### 5.4 安装 Nginx 配置

仓库已经提供了配置文件：[docs/nginx/novacloudedu.conf](nginx/novacloudedu.conf)。

复制到 Nginx：

```bash
sudo cp /home/debian/NovaCloudEdu/docs/nginx/novacloudedu.conf /etc/nginx/conf.d/novacloudedu.conf
sudo nginx -t
sudo systemctl reload nginx
```

如果服务器上有默认站点抢占 `80` 端口，可以额外执行：

```bash
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

---

## 6. 访问方式

部署完成后，直接访问服务器 IP 或域名即可：

- 前端：`http://你的域名或IP/`
- 后端接口：`http://你的域名或IP/api/...`

Nginx 配置已经包含：

- `/api/` 反向代理到后端
- `/ws` WebSocket 代理
- SSE 路由关闭缓存和缓冲，避免流式接口被卡住

---

## 7. 常见问题

### 7.1 8080 端口被占用

通常是 Docker 里的 `backend` 还在跑，先停掉：

```bash
cd /home/debian/NovaCloudEdu/docker
docker compose stop backend
docker compose rm -f backend
```

然后再启动本地后端。

### 7.2 登录接口返回 401

先检查这几项：

- `web/.env.production` 是否仍然是 `VITE_API_BASE_URL=/api`
- Nginx 是否已重载成功
- 请求路径是否被拼成了双 `/api`

### 7.3 SSE 一直不返回内容

确认 Nginx 使用了仓库里的 SSE 配置，并且没有开启缓存或缓冲。

### 7.4 页面打开是 Nginx 默认页

说明静态文件没有复制到 `/var/www/novacloudedu/web/dist`，或者 Nginx 配置还没 reload。

---

## 8. 推荐执行顺序

最稳妥的上线顺序是：

1. 启动 Docker 基础设施，但不启动 `backend`
2. 本地构建并启动后端
3. 构建前端并发布到 Nginx
4. 校验 Nginx 配置并重载
5. 用浏览器和 `curl` 验证首页、登录接口、SSE 接口

如果后续需要把这套流程自动化，可以再补一个一键部署脚本。