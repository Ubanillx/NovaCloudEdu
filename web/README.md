# NovaCloudEdu Web

智云星课 Web，基于 **React 19 + TypeScript 5.9 + Vite 7.2 + TailwindCSS 4.1**。

## 技术栈


| 分类         | 技术                                 | 版本   |
| :----------- | :----------------------------------- | :----- |
| **框架**     | React                                | 19.2   |
| **语言**     | TypeScript                           | ~5.9.3 |
| **构建**     | Vite (SWC)                           | 7.2    |
| **样式**     | TailwindCSS + Typography 插件        | 4.1    |
| **路由**     | React Router DOM                     | 7.13   |
| **HTTP**     | Axios                                | 1.7    |
| **图标**     | Lucide React                         | 0.562  |
| **Markdown** | react-markdown                       | 10.1   |
| **API 生成** | OpenAPI Generator (typescript-axios) | 2.7    |

## 项目结构

```
src/
├── pages/                           # 页面
│   ├── LoginPage.tsx                #   登录页
│   ├── RegisterPage.tsx             #   注册页
│   ├── admin/                       #   管理后台页面
│   │   ├── UserManagementPage.tsx   #     用户管理
│   │   ├── AnnouncementManagementPage.tsx  # 公告管理
│   │   ├── BannerManagementPage.tsx #     轮播图管理
│   │   ├── PostManagementPage.tsx   #     帖子管理
│   │   ├── FeedbackManagementPage.tsx #   反馈管理
│   │   ├── DailyWordManagementPage.tsx #  每日单词管理
│   │   ├── DailyArticleManagementPage.tsx # 每日文章管理
│   │   ├── ScraperConfigPage.tsx    #     爬虫配置
│   │   └── ScraperTaskPage.tsx      #     爬虫任务
│   └── index.ts
│
├── components/                      # 通用组件
│   ├── layout/                      #   布局组件
│   │   ├── AdminLayout.tsx          #     管理后台布局
│   │   ├── Header.tsx / Sider.tsx   #     头部 / 侧边栏
│   │   ├── Content.tsx / Footer.tsx #     内容区 / 底部
│   │   └── index.ts
│   ├── ui/                          #   UI 组件
│   │   ├── Toast.tsx / Tooltip.tsx  #     提示 / 工具提示
│   │   └── index.ts
│   └── ProtectedRoute.tsx           #   路由守卫
│
├── context/                         # 全局状态管理（React Context）
├── data/                            # 静态数据
├── assets/                          # 静态资源
│
├── api/                             # API 层
│   └── generated/                   #   OpenAPI Generator 自动生成的 API 客户端
│
├── App.tsx                          # 应用入口
├── App.css                          # 全局样式
├── main.tsx                         # 渲染入口
└── index.css                        # 基础样式
```

## 快速开始

### 安装依赖

```bash
npm install
```

### 启动开发服务器

```bash
npm run dev
```

访问 http://localhost:5173

### 生成 API 客户端

从后端 Swagger 接口自动生成 TypeScript API 客户端：

```bash
# 从运行中的后端服务生成（需先启动后端）
npm run openapi:generate

# 从本地 openapi.json 文件生成
npm run openapi:generate:local
```

生成的代码位于 `src/api/generated/`。

### 构建生产版本

```bash
npm run build
```

### 代码检查

```bash
npm run lint
```
